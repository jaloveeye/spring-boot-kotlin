# Validation and Errors

## Validation

- Validate input at the API boundary.
- Keep validation rules close to request models when practical.
- Make failure responses clear and consistent.

## Error handling

- Prefer centralized exception handling.
- Use predictable error payloads.
- Avoid leaking internal exception details to clients.
