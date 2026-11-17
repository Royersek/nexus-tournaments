import fs from "node:fs";
import path from "node:path";
import { pool } from "./pool";

function migrationsDir(): string {
  const nextToSource = path.join(__dirname, "migrations");
  if (fs.existsSync(nextToSource)) {
    return nextToSource;
  }
  return path.join(process.cwd(), "src/db/migrations");
}

export async function migrate(): Promise<string[]> {
  const appliedNow: string[] = [];

  await pool.query(`
    CREATE TABLE IF NOT EXISTS schema_migrations (
      id TEXT PRIMARY KEY,
      applied_at TIMESTAMPTZ NOT NULL DEFAULT now()
    )
  `);

  const dir = migrationsDir();
  const files = fs
    .readdirSync(dir)
    .filter((file) => file.endsWith(".sql"))
    .sort();

  for (const file of files) {
    const existing = await pool.query(
      "SELECT 1 FROM schema_migrations WHERE id = $1",
      [file],
    );
    if (existing.rowCount) {
      continue;
    }

    const sql = fs.readFileSync(path.join(dir, file), "utf8");
    const client = await pool.connect();
    try {
      await client.query("BEGIN");
      await client.query(sql);
      await client.query("INSERT INTO schema_migrations (id) VALUES ($1)", [file]);
      await client.query("COMMIT");
      appliedNow.push(file);
    } catch (error) {
      await client.query("ROLLBACK");
      throw error;
    } finally {
      client.release();
    }
  }

  return appliedNow;
}

if (require.main === module) {
  migrate()
    .then(async (files) => {
      if (files.length === 0) {
        console.log("No hay migraciones pendientes.");
      } else {
        for (const file of files) {
          console.log(`Migración aplicada: ${file}`);
        }
      }
      await pool.end();
    })
    .catch(async (error: unknown) => {
      console.error(error);
      await pool.end();
      process.exit(1);
    });
}
