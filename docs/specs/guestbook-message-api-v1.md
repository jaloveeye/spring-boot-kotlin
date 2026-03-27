# Guestbook Message API V1

## Goal

Add the first real vertical slice after the bootstrap work by introducing a small guestbook-style message API backed by the application database.
This gives us a concrete path that exercises controller, service, persistence, and test layers without over-designing the domain too early.

## Scope

- Add an API to create a guestbook message with a writer name and message body.
- Add an API to list guestbook messages in reverse creation order.
- Persist guestbook messages in the application database.
- Keep the implementation in a simple layered structure.
- Add tests that cover the main happy path and basic validation failures.

## Non-Goals

- Authentication or per-user ownership
- Update and delete endpoints
- Pagination, search, or admin tooling
- Rich formatting, attachments, or reactions

## Constraints

- Keep Kotlin + Spring Boot 4 + Gradle structure.
- Keep controllers thin and transaction boundaries in the service layer.
- Do not introduce premature modularization.
- Prefer JDBC first so we can keep the initial persistence layer explicit.
- Introduce schema management before or together with this feature if database tables are required.
- Tests should continue to run without requiring the local Docker PostgreSQL container.

## Proposed API

- `POST /api/guestbook/messages`
- `GET /api/guestbook/messages`

Request body for create:

```json
{
  "author": "Jane",
  "message": "Hello from step01"
}
```

Response body for create/list item:

```json
{
  "id": 1,
  "author": "Jane",
  "message": "Hello from step01",
  "createdAt": "2026-03-27T12:00:00Z"
}
```

## Acceptance Criteria

- Creating a valid guestbook message returns a success response with the stored payload and generated identifier.
- Listing guestbook messages returns stored messages ordered from newest to oldest.
- Blank `author` or blank `message` is rejected with a client error.
- The implementation includes automated tests for create, list, and validation behavior.
- The feature can run against local PostgreSQL with the `local` profile.
- The automated test suite remains runnable without Docker by using the test profile defaults.

## Verification

- Run `./gradlew test`.
- Start PostgreSQL with `docker compose up -d postgres`.
- Run `./gradlew bootRun --args="--spring.profiles.active=local"`.
- Create a message with `POST /api/guestbook/messages`.
- Confirm `GET /api/guestbook/messages` returns the saved message.

## Notes

- Assumption: the first feature should touch the database end-to-end so the new local PostgreSQL workflow gets validated by real application behavior.
- If we want stronger schema discipline, Flyway should be added as part of this feature before the repository implementation is finalized.
