# Query Patterns

## Simple lookups

- Use repository method names for truly simple lookups.
- Stop using derived method names when the query becomes hard to read.

## Explicit queries

- Prefer `@Query` for joins, filtering across relationships, or multi-condition searches.
- Keep query intent obvious and aligned with the use case.

## DTO and projection use

- Prefer DTO projections for read-only API responses.
- Return only the fields the caller needs.
- Use entities when the workflow needs domain behavior or state changes.

## Read/write split

- Keep write-side repositories focused on aggregates.
- For complex read models, consider dedicated query services instead of overloading write-side repositories.
