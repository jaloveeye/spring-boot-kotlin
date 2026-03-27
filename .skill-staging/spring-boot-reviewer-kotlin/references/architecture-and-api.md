# Architecture and API

## Review checks

- Are controllers too heavy?
- Is business logic misplaced in controllers or configuration classes?
- Are persistence entities exposed directly through the API?
- Are DTO boundaries clear and stable?
- Is new abstraction actually justified?

## Risk patterns

- controller-to-repository shortcuts
- service methods doing too many unrelated things
- response models that leak internal state
- package structure drifting away from the chosen architecture
