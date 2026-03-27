# Filter Chain

## General guidance

- Keep authorization rules readable and ordered from specific to general.
- Treat `permitAll` as a deliberate choice, not a shortcut.
- Keep public endpoints small and easy to audit.

## Practical defaults

- Prefer stateless APIs for token-based REST services.
- Disable features that are not needed for the API style in use.
- Keep exception handling for unauthorized and forbidden cases consistent.

## Review checks

- Are unintended endpoints public?
- Are admin or write operations protected explicitly?
- Does the configuration match the actual API shape?
