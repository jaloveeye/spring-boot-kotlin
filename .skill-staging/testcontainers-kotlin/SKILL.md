---
name: testcontainers-kotlin
description: Add and maintain Testcontainers-based integration tests in Kotlin Spring Boot projects, including container lifecycle choices, PostgreSQL setup, Spring Boot test wiring, dynamic property registration, and pragmatic integration-test boundaries. Use when adding database-backed integration tests, replacing fragile local test dependencies, or wiring Spring Boot tests to disposable containers in Kotlin and Gradle projects.
---

# Testcontainers Kotlin

Prefer integration tests that prove real wiring over mocks where infrastructure behavior matters.
Keep containers focused on the dependency the test actually needs.
Use Spring Boot test support and Testcontainers together in the simplest reliable way.

## Core workflow

1. Identify what the test needs to prove: repository wiring, transaction behavior, API flow, or startup integration.
2. Choose the narrowest Spring test style that still exercises the required wiring.
3. For container lifecycle and property wiring, read `references/container-wiring.md`.
4. For PostgreSQL and data-test patterns, read `references/database-testing.md`.
5. For test boundaries and speed tradeoffs, read `references/test-scope.md`.
6. Run the relevant verification before finishing.

## Default implementation preferences

- Use Testcontainers only where real infrastructure behavior matters.
- Prefer a single clearly defined container setup over many duplicated ones.
- Keep test data setup explicit and readable.
- Register container-backed properties in a way that makes the wiring obvious.
- Avoid turning every test into a full application integration test.

## Verification

- Prefer `.\gradlew.bat test` after adding or changing container-backed tests.
- Ensure tests fail clearly when wiring is wrong rather than passing accidentally on local state.
- Keep the integration boundary intentional and documented in the test.
