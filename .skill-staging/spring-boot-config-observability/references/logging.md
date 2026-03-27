# Logging

## Defaults

- Log enough to debug behavior without flooding output.
- Do not log secrets, credentials, or raw tokens.
- Keep log levels intentional by environment.

## Review checks

- Is the log noise too high?
- Are sensitive values exposed?
- Are important transitions hard to observe?
