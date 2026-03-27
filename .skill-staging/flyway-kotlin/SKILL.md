---
name: flyway-kotlin
description: Add and maintain Flyway database migrations for Kotlin Spring Boot projects, including migration naming, schema evolution, local development setup, and test alignment. Use when introducing Flyway, creating schema migrations, evolving database structure, or reviewing migration safety in Kotlin and Gradle Spring Boot services.
---

# Flyway Kotlin

Treat schema changes as first-class code changes.
Keep migrations small, explicit, and easy to reason about.
Align local, test, and application startup expectations.

## Core workflow

1. Identify whether the task is introducing Flyway or adding a new schema change.
2. Keep migrations forward-only and easy to review.
3. For migration structure, read `references/migration-style.md`.
4. For local and test alignment, read `references/runtime-alignment.md`.
5. Run relevant verification before finishing.

## Default implementation preferences

- Prefer one clear migration per schema change.
- Keep file naming consistent and chronological.
- Make destructive changes deliberate and well explained.
- Keep test data assumptions aligned with the migrated schema.

## Verification

- Prefer `.\gradlew.bat test` after migration-related changes.
- Verify that schema expectations and code mappings still match.
