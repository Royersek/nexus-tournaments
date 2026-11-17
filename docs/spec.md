# Especificación Funcional (Spec) - NexusTournaments

## 1. Reglas de Negocio (RN)
- **RN01 - Límite de cupos:** Ningún torneo podrá aceptar más equipos que el `max_teams` definido por el administrador.
- **RN02 - Validación de integrantes:** Todo equipo registrado debe cumplir con la cantidad mínima de integrantes requeridos antes de inscribirse.
- **RN03 - Superposición de horarios:** Un equipo no puede tener dos partidas asignadas en el mismo rango horario.
- **RN04 - Generación de llaves:** El torneo no puede pasar a estado "En Curso" hasta completar el cupo o cerrar inscripciones con una cantidad válida de equipos (potencias de 2: 4, 8, 16...).

## 2. Historias de Usuario (HU)
- **HU01:** Como organizador, quiero crear un torneo especificando nombre y cupo máximo para que los equipos puedan inscribirse.
  - *Criterio de aceptación:* Dado que soy admin, cuando completo el formulario válido, entonces el torneo se crea en estado abierto.
- **HU02:** Como capitán, quiero inscribir a mi roster en un torneo abierto.
  - *Criterio de aceptación:* Dado que hay cupos, cuando selecciono mi equipo e inscribe, entonces se vincula al torneo y reduce el cupo disponible.
