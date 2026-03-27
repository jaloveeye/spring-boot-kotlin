# Testing

## Defaults

- Prefer focused persistence tests for repositories, mappings, and queries.
- Use full Spring Boot tests when transaction wiring or integration matters.

## What to verify

- expected rows returned
- relationship mapping behavior
- failure paths for invalid state or constraints
- pagination and sort behavior where applicable

## Practical guidance

- Cover the happy path and the likely regression path.
- When a query is performance-sensitive, verify the returned shape and not only that the test passes.
