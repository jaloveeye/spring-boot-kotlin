# Service Wiring

## Defaults

- Keep hostnames, ports, and credentials aligned with local application config.
- Use named volumes only when persistence across restarts matters.
- Keep dependencies obvious from the compose file.

## Review checks

- Does the app config match compose networking and ports?
- Are there services defined that nobody needs locally?
