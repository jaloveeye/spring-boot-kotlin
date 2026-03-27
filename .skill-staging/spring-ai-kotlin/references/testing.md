# Testing

## Defaults

- Test surrounding business behavior even if model output itself is variable.
- Keep provider interaction boundaries mockable or adaptable where needed.
- Verify failure handling and fallback paths when they matter.

## Review checks

- Does the test prove application behavior rather than only a mocked call?
- Are failure paths ignored?
