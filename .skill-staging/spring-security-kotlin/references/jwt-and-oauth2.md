# JWT and OAuth2 Resource Server

## Defaults

- Prefer Spring Security OAuth2 Resource Server for JWT validation.
- Keep issuer, jwk-set, audience, and related settings externalized.
- Make validation rules explicit when defaults are not enough.

## Implementation guidance

- Separate token validation concerns from business logic.
- Keep claims mapping small and intentional.
- Avoid leaking token internals into unrelated layers.

## Common pitfalls

- partial endpoint protection
- trusting claims without validation
- mixing multiple auth approaches without a clear boundary
- missing tests for expired or malformed tokens
