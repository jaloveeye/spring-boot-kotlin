---
name: spring-data-jpa-kotlin
description: Design and implement Spring Data JPA in Kotlin Spring Boot projects, including repository boundaries, entity mapping, DTO projections, transaction placement, query choices, and common performance fixes. Use when working on JPA entities, repositories, relationships, query tuning, or persistence-layer design in Kotlin and Gradle Spring Boot services.
---

# Spring Data JPA Kotlin

Keep repositories at aggregate boundaries.
Prefer explicit query and mapping choices over convenience that hides cost.
Optimize read paths before adding complexity elsewhere.

## Core workflow

1. Identify whether the change is write-side, read-side, or both.
2. Confirm the aggregate root and avoid creating repositories for every entity.
3. For query shape decisions, read `references/query-patterns.md`.
4. For relationship choices, read `references/relationships.md`.
5. For performance-sensitive paths, read `references/performance.md`.
6. For persistence-focused tests, read `references/testing.md`.
7. Run the smallest relevant verification before finishing.

## Default implementation preferences

- Keep transaction boundaries in services.
- Prefer DTOs or projections for read-heavy API responses.
- Avoid exposing entities directly through controllers.
- Use explicit mapping between entities and API models.
- Prefer readable `@Query` methods over long derived method names once a query becomes non-trivial.
- Treat `@ManyToMany` as a warning sign and prefer an explicit join entity when the relationship has behavior or metadata.

## Verification

- Prefer `.\gradlew.bat test` after persistence changes.
- When a query or mapping issue is suspected, verify with a focused test rather than guessing.
- Do not finish persistence work without checking the likely impact on lazy loading, pagination, and query count.
