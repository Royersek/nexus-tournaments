-- Creación de tablas iniciales para NexusTournaments

-- 1. Usuarios / Jugadores / Administradores
CREATE TABLE IF NOT EXISTS users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    role VARCHAR(20) DEFAULT 'PLAYER' CHECK (role IN ('ADMIN', 'PLAYER')),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 2. Equipos
CREATE TABLE IF NOT EXISTS teams (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) UNIQUE NOT NULL,
    captain_id INT REFERENCES users(id) ON DELETE CASCADE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 3. Torneos (Cumple con RN01: max_teams y estado)
CREATE TABLE IF NOT EXISTS tournaments (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    game VARCHAR(50) NOT NULL,
    max_teams INT NOT NULL,
    status VARCHAR(20) DEFAULT 'OPEN' CHECK (status IN ('OPEN', 'IN_PROGRESS', 'FINISHED')),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 4. Inscripciones a Torneos (Maneja cupos y lista de espera por RN01)
CREATE TABLE IF NOT EXISTS registrations (
    id SERIAL PRIMARY KEY,
    tournament_id INT REFERENCES tournaments(id) ON DELETE CASCADE,
    team_id INT REFERENCES teams(id) ON DELETE CASCADE,
    status VARCHAR(20) DEFAULT 'REGISTERED' CHECK (status IN ('REGISTERED', 'WAITLIST', 'CANCELLED')),
    registered_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(tournament_id, team_id)
);

-- 5. Partidas / Brackets (Cumple con RN03 y RN04)
CREATE TABLE IF NOT EXISTS matches (
    id SERIAL PRIMARY KEY,
    tournament_id INT REFERENCES tournaments(id) ON DELETE CASCADE,
    team1_id INT REFERENCES teams(id) ON DELETE SET NULL,
    team2_id INT REFERENCES teams(id) ON DELETE SET NULL,
    winner_id INT REFERENCES teams(id) ON DELETE SET NULL,
    round INT NOT NULL, -- 1: Octavos/Cuartos, 2: Semis, etc.
    status VARCHAR(20) DEFAULT 'PENDING' CHECK (status IN ('PENDING', 'IN_PROGRESS', 'COMPLETED')),
    scheduled_time TIMESTAMP
);