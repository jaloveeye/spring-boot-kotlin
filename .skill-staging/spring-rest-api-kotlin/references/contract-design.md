# Contract Design

## Defaults

- Prefer stable, explicit JSON contracts.
- Keep resource naming predictable and consistent.
- Avoid leaking internal field names if the API contract should be decoupled.

## Review checks

- Are entities exposed directly?
- Are request and response shapes intentional?
- Is the endpoint path resource-oriented?
