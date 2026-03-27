# Secure Defaults

## API defaults

- Default to authenticated access unless an endpoint is intentionally public.
- Validate external input before it reaches sensitive logic.
- Do not log secrets, raw tokens, or sensitive credentials.

## Configuration

- Keep secrets out of source control.
- Prefer environment-driven configuration for sensitive settings.
- Document non-obvious local-development security shortcuts.

## Code review mindset

- Look for overly broad access rules.
- Look for missing authorization on write operations.
- Look for security logic hidden in controllers instead of configuration or services.
