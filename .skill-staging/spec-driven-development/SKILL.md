---
name: spec-driven-development
description: Drive implementation from a lightweight written specification, including scope definition, acceptance criteria, constraints, and verification planning. Use when work is non-trivial, spans multiple steps, changes behavior, or needs a clear implementation contract before coding in backend projects.
---

# Spec Driven Development

Write the spec before writing the implementation when the task is non-trivial.
Keep the spec short, testable, and tied to observable behavior.
Use the spec to reduce ambiguity during coding and review.

## Core workflow

1. Clarify the goal and why the change matters.
2. Define scope and explicit non-goals.
3. Capture constraints from stack, architecture, or runtime expectations.
4. Write acceptance criteria in observable terms.
5. Define verification before implementation starts.
6. Keep implementation aligned with the written spec.

## Default implementation preferences

- Prefer a short spec over a long design document.
- Use acceptance criteria that can be checked by tests or concrete runtime behavior.
- Update the spec when the intended behavior changes.
- Use the spec during review to judge whether the change is complete.
