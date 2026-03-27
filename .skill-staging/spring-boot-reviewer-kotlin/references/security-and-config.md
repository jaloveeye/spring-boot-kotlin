# Security and Config

## Review checks

- Are protected endpoints still protected?
- Is input validation present at the boundary?
- Are sensitive values externalized?
- Is logging safe for credentials, tokens, or secrets?
- Does configuration remain understandable for local development?

## Risk patterns

- accidental public endpoints
- missing authorization on write operations
- secrets or tokens logged directly
- scattered configuration with unclear precedence
