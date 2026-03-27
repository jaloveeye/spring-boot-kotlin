# Testing

## What to verify

- public endpoints stay reachable when intended
- protected endpoints reject unauthenticated requests
- role or authority checks behave as expected
- invalid or expired token scenarios fail safely

## Practical approach

- Prefer focused security tests around changed behavior.
- Use Spring Security test support for mocked authentication where appropriate.
- Add at least one negative case for authorization changes.
