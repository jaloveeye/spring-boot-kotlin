# Local Development

## What This Adds

- PostgreSQL for local development via Docker Compose
- Spring Boot datasource defaults aligned with the local PostgreSQL container
- A `local` profile for explicit local environment startup
- H2-backed tests so Gradle test runs do not depend on Docker

## Prerequisites

- Windows with WSL 2 installed
- Ubuntu installed in WSL
- Docker Engine installed inside Ubuntu WSL
- A Linux JDK available inside Ubuntu WSL

## Recommended Workspace

Use the WSL working copy for daily development:

```bash
cd ~/workspace/step01-wsl
```

The original Windows path is still available at:

```text
/mnt/c/Users/cjswo/Workspace/springboot/step01
```

## Verify Java In WSL

Make sure the WSL shell can see a Linux JDK before running Gradle:

```bash
java -version
echo "$JAVA_HOME"
./gradlew -version
```

If `java` is not found, install or configure a Linux JDK in Ubuntu WSL first.
Do not point the repository at a Windows-only JDK path from `gradle.properties`.

## Start PostgreSQL

Run these commands from the WSL terminal:

```bash
docker compose up -d postgres
docker compose ps
```

Default local database values:

- Host: `localhost`
- Port: `5432`
- Database: `step01`
- Username: `step01`
- Password: `step01`

## Run The Application

From WSL:

```bash
./gradlew bootRun --args="--spring.profiles.active=local"
```

Useful endpoints:

- `http://localhost:8080/hello`
- `http://localhost:8080/actuator/health`

## Stop PostgreSQL

```bash
docker compose down
```

To remove persisted database data as well:

```bash
docker compose down -v
```

## Notes

- Tests use H2 and do not require Docker.
- Docker is installed inside Ubuntu WSL, not on Windows.
- VS Code should be opened in `WSL: Ubuntu` mode for the smoothest workflow.
- Gradle in WSL should use a Linux JDK from `PATH` or `JAVA_HOME`.
- The application datasource defaults are environment-variable friendly, so we can later move to Flyway, JPA, or Testcontainers without reworking the basics.
