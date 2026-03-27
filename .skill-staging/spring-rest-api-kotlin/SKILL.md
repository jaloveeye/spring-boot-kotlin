---
name: spring-rest-api-kotlin
description: Design and implement REST APIs in Kotlin Spring Boot projects, including request and response DTOs, validation, exception handling, status codes, pagination-friendly endpoints, and pragmatic controller-service boundaries. Use when creating or reviewing REST controllers, API contracts, validation rules, or JSON response design in Kotlin and Gradle Spring Boot services.
---

# Spring REST API Kotlin

Prefer explicit API contracts over implicit entity exposure.
Keep controllers thin and responses predictable.
Use validation and error handling as part of the API design, not as afterthoughts.

## Core workflow

1. Identify the API use case and the resource shape.
2. Keep request and response DTOs separate from persistence entities.
3. For endpoint and DTO shape, read `references/contract-design.md`.
4. For validation and error handling, read `references/validation-and-errors.md`.
5. For pagination and list endpoints, read `references/collection-endpoints.md`.
6. Run relevant verification before finishing.

## Default implementation preferences

- Use request DTOs for input and response DTOs for output.
- Keep controllers focused on HTTP concerns and delegate business logic to services.
- Choose status codes intentionally.
- Prefer consistent JSON error payloads.
- Keep list endpoints pagination-friendly when data can grow.

## Verification

- Prefer `.\gradlew.bat test` after API changes.
- Verify at least one success case and one validation or failure case.
