# WSL VS Code Handoff

## Current Direction

This project should now be developed primarily from VS Code in `WSL: Ubuntu` mode.
The recommended working copy is:

```text
/home/jaloveeye/workspace/step01-wsl
```

The original Windows copy remains at:

```text
/mnt/c/Users/cjswo/Workspace/springboot/step01
```

Do not actively edit both copies at the same time.

## What Is Already Set Up

- Kotlin + Spring Boot + Gradle project
- Spring Boot 4.x baseline
- Java 25 runtime-oriented setup
- Git repository with `main` and `develop`
- Project rules for SDD, TDD, CodeRabbit, and GitFlow
- WSL 2 with Ubuntu 24.04
- Docker Engine installed inside Ubuntu WSL
- Docker Compose plugin installed inside Ubuntu WSL
- Local PostgreSQL compose file
- `local` Spring profile for database-backed startup
- H2-backed tests so `test` does not require Docker

## Verified State

- `.\gradlew.bat test` succeeded on the Windows copy
- `docker --version` succeeded in Ubuntu WSL
- `docker compose version` succeeded in Ubuntu WSL
- `docker ps` succeeded in Ubuntu WSL
- WSL still needs a Linux JDK on `PATH` or `JAVA_HOME` before `./gradlew` can run there

## Open In VS Code

From Windows PowerShell:

```powershell
code --folder-uri "vscode-remote://wsl+Ubuntu/home/jaloveeye/workspace/step01-wsl"
```

From Ubuntu WSL:

```bash
cd ~/workspace/step01-wsl
code .
```

Success indicator:

- VS Code bottom-left shows `WSL: Ubuntu`

## First Commands In WSL

```bash
cd ~/workspace/step01-wsl
git status
java -version
docker ps
docker compose up -d postgres
./gradlew test
./gradlew bootRun --args="--spring.profiles.active=local"
```

## Important Files

- `PROJECT_RULES.md`
- `SDD_TEMPLATE.md`
- `LOCAL_DEV.md`
- `compose.yaml`
- `gradle.properties`
- `src/main/resources/application.yml`
- `src/main/resources/application-local.yml`
- `src/test/resources/application.yml`

## Current Uncommitted Changes

These local development changes are present and expected:

- `.gitignore`
- `build.gradle.kts`
- `src/main/resources/application.yml`
- `LOCAL_DEV.md`
- `compose.yaml`
- `docs/specs/local-postgres-dev.md`
- `src/main/resources/application-local.yml`
- `src/test/resources/application.yml`

## Recommended Next Step

1. Open the WSL copy in VS Code.
2. Confirm the Codex extension is installed in the WSL extension host.
3. Make sure a Linux JDK is available in WSL and `java -version` succeeds.
4. Start PostgreSQL with `docker compose up -d postgres`.
5. Run the app with `./gradlew bootRun --args="--spring.profiles.active=local"`.
6. Continue feature work from the WSL copy only.
