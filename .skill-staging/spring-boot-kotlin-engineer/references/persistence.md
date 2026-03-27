# Persistence

## General

- Keep transaction boundaries in services.
- Avoid exposing JPA entities directly through the API.
- Prefer aggregate-root-oriented repository design.

## Query choices

- Use simple repository methods for simple lookups.
- Use explicit queries or projections when reads become more complex.
- Watch for N+1 patterns and unbounded reads.

## Mapping

- Prefer explicit mapping between entities and DTOs.
- Keep persistence annotations out of API models.
