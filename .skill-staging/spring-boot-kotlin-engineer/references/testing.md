# Testing

## Defaults

- Run `.\gradlew.bat test` for backend verification.
- Add tests when behavior changes.
- Prefer focused tests over broad incidental coverage.

## Test shape

- Use slice tests when only one layer needs verification.
- Use full Spring Boot tests when wiring or integration matters.
- Cover at least the happy path and the main failure path for new behavior.

## Practical guidance

- Keep tests readable and explicit.
- Avoid unnecessary fixtures and indirection.
- Verify logs or startup only when behavior depends on them.
