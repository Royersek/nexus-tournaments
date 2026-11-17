# AGENTS.md - Directrices del Proyecto NexusTournaments

## 1. Visión General del Proyecto
NexusTournaments es una plataforma web para la creación, organización y gestión de torneos de esports (eliminación directa, control de cupos y registro de resultados).

## 2. Documentación Oficial (Fuente de Verdad)
Cualquier decisión técnica o de negocio debe respetar estrictamente los documentos ubicados en la carpeta `docs/`:
- `docs/idea.md`: Propuesta y alcance.
- `docs/spec.md`: Reglas de negocio (RN) e historias de usuario (HU).
- `docs/decisiones.md`: Decisiones tomadas ante dudas del negocio.
- `docs/tasks.md`: Plan de tareas actual.

## 3. Stack Tecnológico
- **Frontend:** React, TypeScript, Tailwind CSS, Vite.
- **Backend:** Node.js, Express, TypeScript.
- **Base de Datos:** PostgreSQL.

## 4. Ciclo de Trabajo para las Tareas
1. Ninguna tarea se considera iniciada sin revisar `docs/tasks.md`.
2. Las reglas de negocio especificadas en `docs/spec.md` son inquebrantables.
3. Todo cambio o desarrollo debe estar documentado mediante un commit claro en Git por cada tarea completada.
