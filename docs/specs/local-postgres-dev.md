# Local PostgreSQL Development Spec

## Goal

Provide a simple local PostgreSQL development workflow for the Spring Boot application on Windows with WSL 2 and Docker Engine running inside Ubuntu WSL.

## Scope

- Add a local development PostgreSQL container definition.
- Configure Spring Boot to connect to PostgreSQL using local defaults.
- Keep tests independent from the local PostgreSQL container.
- Document the startup flow for local developers.

## Non-Goals

- Introduce JPA entities, repositories, or Flyway migrations yet.
- Add production deployment configuration.

## Constraints

- Keep the existing Kotlin + Gradle + Spring Boot 4 structure.
- Keep local developer setup readable and explicit.
- Avoid making Docker a hard requirement for running tests.

## Acceptance Criteria

- `docker compose up -d postgres` starts a local PostgreSQL container.
- The application can start with `local` profile and point at the local PostgreSQL instance.
- `.\gradlew.bat test` does not require a running PostgreSQL container.
- The repository documents the local startup sequence.

## Verification

- Run `.\gradlew.bat test`.
- If Docker Desktop is available, run `docker compose up -d postgres` and then start the app with `local` profile.
