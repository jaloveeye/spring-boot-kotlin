# Flyway, Docker, and CI/CD Bootstrap

## Goal

Prepare the project for repeatable deployment by replacing ad hoc schema initialization with Flyway, packaging the application as a Docker image, and adding a basic CI/CD workflow that enforces tests before deployment.

## Scope

- Introduce Flyway-based schema management.
- Add an application Dockerfile and docker ignore rules.
- Add deployment-oriented environment variable examples and compose file.
- Add GitHub Actions workflows for CI and manual deployment.
- Split deployment so `develop` can auto-deploy to dev while `main` remains a manual production deployment.
- Document how the new deployment baseline works.

## Non-Goals

- Full staging and production environment provisioning
- Kubernetes or ECS orchestration
- Advanced static analysis, security scanning, or release automation
- Database backup automation

## Constraints

- Keep the current Kotlin + Spring Boot + Gradle stack.
- Keep local development with WSL and Docker Compose simple.
- Preserve H2-backed tests without requiring Docker.
- Require tests to pass before any deployment workflow can proceed.

## Acceptance Criteria

- Schema changes are managed through Flyway migrations in the repository.
- The application can be packaged as a Docker image from the repository root.
- CI runs tests and validates that the Docker image builds.
- A deployment workflow exists that can build, push, and deploy the image once environment secrets are configured.
- The repository distinguishes between automatic dev deployment and manual production deployment.
- Repository documentation explains the deployment path and required secrets.

## Verification

- Run `./gradlew test`.
- Run `docker build -t step01:local .`.
- Review `.github/workflows/ci.yml`, `.github/workflows/deploy-dev.yml`, and `.github/workflows/deploy-prod.yml`.
- Confirm `DEPLOYMENT.md` lists the required secrets and deployment assumptions.

## Notes

- Assumption: GitHub Actions and GHCR are acceptable defaults for the first CI/CD iteration.
- Manual deployment approval is preferred over immediate auto-deploy while the project is still early.
