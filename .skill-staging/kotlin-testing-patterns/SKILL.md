---
name: kotlin-testing-patterns
description: Apply practical testing patterns in Kotlin projects, especially Kotlin Spring Boot services, including unit tests, slice tests, integration tests, fixture style, and test readability. Use when adding or improving tests, choosing test scope, or reviewing test design in Kotlin backend projects.
---

# Kotlin Testing Patterns

Prefer tests that explain behavior clearly.
Choose the smallest test scope that still proves the risk.
Keep fixtures and helpers from becoming harder to understand than the code under test.

## Core workflow

1. Identify the behavior that actually needs proof.
2. Choose unit, slice, or integration scope intentionally.
3. For scope choice, read `references/test-scope.md`.
4. For fixture and readability guidance, read `references/test-readability.md`.
5. Run the relevant verification before finishing.

## Default implementation preferences

- Prefer clear test names that describe behavior.
- Keep setup focused on what the assertion needs.
- Cover both happy path and meaningful failure path when behavior changed.
- Avoid over-mocking when integration behavior is the real risk.

## Verification

- Prefer `.\gradlew.bat test`.
- Do not add tests that pass without proving the changed behavior.
