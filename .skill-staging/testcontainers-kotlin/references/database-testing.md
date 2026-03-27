# Database Testing

## Practical defaults

- Use PostgreSQL containers for persistence behavior that should match production more closely.
- Verify schema, mappings, and query behavior against the real database.
- Keep fixtures small and focused on the assertion.

## What to verify

- repository queries
- transaction behavior
- constraint failures
- mapping correctness
- startup wiring for database-backed components
