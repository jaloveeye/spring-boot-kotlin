# Testing

## Review checks

- Does the change alter behavior without updating tests?
- Is there at least one failure-path test when the logic warrants it?
- Are tests focused enough to catch the intended regression?

## Risk patterns

- only happy-path tests
- missing verification of validation failures
- broad integration tests with no focused unit or slice coverage
- new behavior added with zero automated checks
