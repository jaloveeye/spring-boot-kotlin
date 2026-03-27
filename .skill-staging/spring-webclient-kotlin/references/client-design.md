# Client Design

## Defaults

- Separate outbound HTTP code from business logic.
- Keep request and response DTOs explicit.
- Centralize configuration that multiple calls share.

## Review checks

- Is HTTP logic leaking into unrelated services?
- Are response mappings clear and maintainable?
