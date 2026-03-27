# Web and API

## Controller guidance

- Keep controllers focused on request mapping, validation, and response shaping.
- Push business logic into services.
- Prefer explicit request and response DTOs.

## API design

- Use clear resource-oriented paths.
- Return stable JSON contracts.
- Validate request payloads at the boundary.
- Use Spring's built-in response handling before introducing custom frameworks.

## Error handling

- Prefer centralized exception handling for consistent error responses.
- Keep error payloads simple and predictable.
