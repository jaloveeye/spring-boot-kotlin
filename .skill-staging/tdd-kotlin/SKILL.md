---
name: tdd-kotlin
description: Apply test-driven development in Kotlin projects, especially Kotlin Spring Boot services, by writing a failing test first, implementing the smallest passing change, and refactoring safely. Use when adding new behavior, fixing regressions, or tightening confidence around backend logic in Kotlin and Gradle projects.
---

# TDD Kotlin

Start from the behavior that needs proof.
Write the failing test first when the expected outcome is clear.
Keep the red-green-refactor loop tight.

## Core workflow

1. Identify the behavior or regression to prove.
2. Write the smallest failing test that demonstrates the gap.
3. Implement the minimum change to make it pass.
4. Refactor while keeping tests green.
5. Repeat until the behavior is complete.

## Default implementation preferences

- Prefer focused tests that prove one behavior at a time.
- Keep test names explicit and behavior-oriented.
- Refactor only after green.
- Use TDD most aggressively for logic, validation, regressions, and boundary behavior.

## Verification

- Run `.\gradlew.bat test` as the default verification step.
- Keep at least one failure-path test when the behavior has meaningful error handling.
