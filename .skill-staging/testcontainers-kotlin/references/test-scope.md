# Test Scope

## Choose the smallest useful scope

- Use repository-focused tests for query and mapping behavior.
- Use full Spring Boot tests when application wiring is part of the risk.
- Avoid broad end-to-end style tests when a narrower integration test would catch the same issue.

## Speed vs confidence

- Add container-backed tests where mocks would hide real failure modes.
- Do not use containers for logic that does not depend on infrastructure behavior.
- Keep the suite balanced so useful integration tests do not crowd out fast feedback.
