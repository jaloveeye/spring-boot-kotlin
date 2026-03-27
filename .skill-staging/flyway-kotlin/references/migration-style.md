# Migration Style

## Defaults

- Keep migrations small and focused.
- Separate unrelated schema changes.
- Make index, constraint, and column changes easy to review.

## Review checks

- Is the migration doing too much at once?
- Is rollback thinking at least considered, even if migrations are forward-only?
- Will the migration be understandable months later?
