# Container Wiring

## General guidance

- Keep container setup shared when multiple tests need the same dependency.
- Make lifecycle choice explicit: per class, shared base, or narrower when justified.
- Register Spring properties in one visible place.

## Review checks

- Is the test relying on hidden local state instead of the container?
- Are container properties wired explicitly?
- Is the container broader than necessary for the test?
