# Runtime Alignment

## Practical defaults

- Ensure startup schema expectations match Flyway-managed state.
- Keep test schema creation aligned with migrations.
- Avoid hidden schema drift between local and automated environments.

## Review checks

- Does the application assume schema that Flyway does not create?
- Do tests rely on stale or out-of-band schema setup?
