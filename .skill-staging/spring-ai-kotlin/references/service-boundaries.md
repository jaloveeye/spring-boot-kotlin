# Service Boundaries

## Defaults

- Keep AI calls in dedicated services or adapters.
- Keep domain logic separate from provider-specific request construction.
- Make it easy to swap or evolve provider usage later.

## Review checks

- Is AI code leaking into controllers or unrelated services?
- Is provider-specific logic scattered?
