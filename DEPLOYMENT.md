# Deployment Overview

## Recommended Shape

- Build and test on pull requests
- Require review before merge
- Publish a Docker image for deployments
- Deploy the application container separately from the production PostgreSQL service
- Use Flyway for schema management at application startup

## Files

- `Dockerfile`
- `.dockerignore`
- `.env.example`
- `deploy/compose.app.yml`
- `deploy/compose.local.yml`
- `deploy/.env.local-deploy.example`
- `scripts/local-deploy.sh`
- `.github/workflows/ci.yml`
- `.github/workflows/deploy-dev.yml`
- `.github/workflows/deploy-prod.yml`

## CI Flow

Pull requests and pushes to `develop` and `main` run:

```bash
./gradlew test
docker build -t step01:ci .
```

## CD Flow

Deployment is split by branch and target environment:

- `develop` is deployed automatically to the `dev` environment after the `CI` workflow completes successfully.
- `main` is deployed manually to the `prod` environment through GitHub Actions `workflow_dispatch`.
- `prod` should use GitHub Environment protection rules such as required reviewers.

Expected GitHub environment secrets for both `dev` and `prod`:

- `DEPLOY_HOST`
- `DEPLOY_PORT`
- `DEPLOY_USER`
- `DEPLOY_SSH_KEY`
- `SPRING_DATASOURCE_URL`
- `SPRING_DATASOURCE_USERNAME`
- `SPRING_DATASOURCE_PASSWORD`

Optional GitHub environment variable:

- `SERVER_PORT`
- `SPRING_PROFILES_ACTIVE`

Workflow behavior:

- `ci.yml`: runs tests and validates the Docker image build on pull requests and pushes
- `deploy-dev.yml`: auto-builds, pushes, and deploys `develop-*` images after successful CI on `develop`, but skips cleanly until dev deployment secrets are configured
- `deploy-prod.yml`: manually builds, pushes, tests, and deploys `prod-*` images from a chosen git ref

## Deployment Target

The provided deployment compose file expects:

- Docker Engine installed on the target Linux host
- The host to be able to pull from GHCR
- PostgreSQL to be reachable through the provided datasource URL

## Local Experiment Deployment

If the deployment target is the same local computer, use the local deployment files instead of the SSH-based workflow.

Create the local env file once:

```bash
cp deploy/.env.local-deploy.example deploy/.env.local-deploy
```

Then use:

```bash
bash scripts/local-deploy.sh up
bash scripts/local-deploy.sh status
bash scripts/local-deploy.sh logs
bash scripts/local-deploy.sh down
```

Defaults:

- App port: `18081`
- PostgreSQL port: `55432`
- Image tag: `step01:local`

## Notes

- `local` development still uses the repository `compose.yaml`.
- Production deployment should not rely on the local PostgreSQL compose service.
- Flyway migrations in `src/main/resources/db/migration` are now the source of truth for schema changes.
- Local experiment deployment intentionally uses separate ports so it does not collide with the existing development flow.
- Before a real deployment target exists, `deploy-dev.yml` is expected to no-op instead of failing on missing deployment secrets.
