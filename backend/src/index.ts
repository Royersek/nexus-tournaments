import express, { Application, Request, Response } from 'express';
import cors from 'cors';
import dotenv from 'dotenv';
import { pool } from './config/database.js';

dotenv.config();

const app: Application =express();
const PORT = process.env.PORT || 3000;

app.use(cors());
app.use(express.json());

// Ruta de prueba del sistema
app.get('/api/health', async (req: Request, res: Response) => {
  try {
    const result = await pool.query('SELECT NOW()');
    res.json({
      status: 'OK',
      message: 'Servidor de NexusTournaments funcionando correctamente',
      db_time: result.rows[0].now,
    });
  } catch (error) {
    res.status(500).json({ status: 'ERROR', message: 'Error de conexión con la Base de Datos', error });
  }
});

app.listen(PORT, () => {
  console.log(`Servidor corriendo en el puerto ${PORT}`);
});