---
name: spring-boot-kotlin-engineer
description: Build and evolve Kotlin-first Spring Boot applications using Gradle, Spring MVC, validation, configuration, testing, and pragmatic layered architecture. Use when working on Spring Boot Kotlin services, REST APIs, configuration, dependency choices, test strategy, or everyday backend implementation in Kotlin and Gradle projects.
---

# Spring Boot Kotlin Engineer

Use Kotlin-first Spring Boot defaults.
Keep architecture simple unless the domain clearly demands more.
Prefer official Spring Boot features before adding extra libraries.

## Core workflow

1. Confirm the project stack from `build.gradle.kts`, `settings.gradle.kts`, and source layout.
2. Keep the implementation aligned with the existing package structure and naming.
3. For web work, read `references/web-and-api.md`.
4. For persistence work, read `references/persistence.md`.
5. For verification or test design, read `references/testing.md`.
6. For setup or version choices, read `references/project-setup.md`.
7. Run the smallest useful verification before finishing.

## Default implementation preferences

- Prefer layered design with controller, service, and persistence responsibilities separated.
- Keep controllers thin and move business logic into services.
- Use DTOs for API boundaries instead of exposing entities directly.
- Prefer constructor injection and immutable data where practical.
- Use `application.yml` for configuration unless the project already standardizes otherwise.
- Keep Gradle changes minimal and explicit.

## Verification

- Prefer `.\gradlew.bat test` after meaningful backend changes.
- If startup behavior changed, also verify `.\gradlew.bat bootRun` when practical.
- Do not claim completion without at least one concrete verification step or a clear note about why it could not be run.
