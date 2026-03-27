# Persistence

## Review checks

- Are repository boundaries still sane?
- Did the change introduce likely N+1 behavior?
- Is pagination missing on potentially large reads?
- Are projections or DTOs ignored where they would clearly help?
- Did transaction placement become unclear or unsafe?

## Risk patterns

- entity exposure through APIs
- long derived query names replacing readable explicit queries
- broad graph traversal in loops
- write logic hidden inside read-oriented code paths
