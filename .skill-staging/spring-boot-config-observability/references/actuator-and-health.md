# Actuator and Health

## Practical defaults

- Expose only the endpoints that are useful and intended.
- Keep liveness and readiness meaningful.
- Reflect real dependencies in health checks when needed.

## Review checks

- Are unnecessary management endpoints exposed?
- Do health endpoints match deployment expectations?
