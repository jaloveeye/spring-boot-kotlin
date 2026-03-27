# Resilience

## Practical defaults

- Set timeouts intentionally.
- Make retry behavior explicit if used.
- Treat remote failures as expected conditions, not surprises.

## Review checks

- Are timeouts missing?
- Is retry hidden or uncontrolled?
- Are remote errors surfaced in a useful way?
