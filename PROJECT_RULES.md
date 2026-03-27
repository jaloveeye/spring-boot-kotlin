# Project Rules

## Stack

- Use Kotlin first for application code.
- Use Gradle with Kotlin DSL.
- Use Spring Boot 4.x for framework features and dependencies.
- Run on Java 25.
- Keep Java bytecode target aligned with current Kotlin support in the build.

## Architecture

- Default to a simple layered structure unless the domain clearly needs more.
- Prefer small, explicit packages over premature modularization.
- Keep controllers thin, services focused, and persistence concerns isolated.
- Avoid adding abstractions unless they remove clear duplication or complexity.

## Dependencies

- Prefer official Spring starters and well-supported libraries.
- Avoid adding libraries when Spring Boot or Kotlin standard tooling already solves the problem.
- Do not introduce Lombok.

## Quality

- Do not mark work complete without running a relevant verification command.
- For backend changes, prefer `.\gradlew.bat test` as the default verification.
- Add or update tests when behavior changes.
- Prefer readable code over clever code.
- Use TDD when implementing new behavior or fixing a regression with a clear expected outcome.
- Prefer writing or updating the failing test first when the target behavior is well understood.
- Keep the red-green-refactor loop tight and visible.

## Delivery Workflow

- Use SDD as the default for non-trivial work.
- Write or update a short specification before implementation when the task has multiple steps, behavior changes, or design choices.
- Keep the specification focused on scope, constraints, acceptance criteria, and verification.
- Treat the spec as the source of truth during implementation.
- Before merging meaningful changes, ensure tests and review feedback align with the spec.

## Code Review

- Treat CodeRabbit review as part of the normal pull request workflow.
- Prefer small pull requests with clear scope so automated review can stay accurate.
- Resolve or consciously dismiss review findings; do not ignore them silently.
- Keep review comments tied to behavior, safety, maintainability, or spec compliance.

## Git Workflow

- Use GitFlow as the default branching model.
- Keep `main` for production-ready history.
- Keep `develop` as the integration branch.
- Create feature work from `develop` using `feature/*` branches.
- Use `release/*` and `hotfix/*` branches only when the lifecycle requires them.
- Prefer small, reviewable commits with clear intent.
- Merge through pull requests when possible so automated review and checks stay in the loop.

## API and Data

- Favor explicit request and response models over exposing persistence entities.
- Validate external input close to the API boundary.
- Keep transaction boundaries in the service layer.
- Prefer projections or targeted queries when read paths become heavier.

## Operational Defaults

- Keep local development friction low.
- Prefer project-local defaults that let `.\gradlew.bat` work without extra shell setup.
- Document non-obvious build or runtime constraints in the repository.
