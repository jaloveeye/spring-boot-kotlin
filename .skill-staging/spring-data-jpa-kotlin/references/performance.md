# Performance

## Watch for

- N+1 queries
- unbounded reads
- entity loading when only a subset of fields is needed
- accidental eager fetch chains

## Practical defaults

- Add pagination for collections that can grow.
- Use projections for list endpoints and summary screens.
- Keep write transactions narrow.
- Avoid loading full graphs when the caller only needs a small view.

## Debugging mindset

- Confirm query behavior with tests or logs before optimizing.
- Fix the access pattern first, then consider fetch tuning.
