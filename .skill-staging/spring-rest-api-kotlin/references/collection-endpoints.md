# Collection Endpoints

## Practical defaults

- Use pagination when collections can grow.
- Keep sorting and filtering readable and explicit.
- Return only the fields needed by the client.

## Review checks

- Is the endpoint unbounded?
- Would a projection or summary DTO be better than full objects?
