# publish-jvm-project

Publishes a project for the **Java Virtual Machine** - using **Maven** or **Gradle**.

## 🃏Example

```yaml
steps:
  - uses: actions/checkout@v4

  - uses: giancosta86/aurora-github/actions/publish-jvm-project@v8
    with:
      auth-user: userOnTheServer
      auth-token: ${{ secrets.SERVER_TOKEN }}
```

## 💡How it works

1. Run [enforce-branch-version](../enforce-branch-version/README.md), forwarding the `enforce-branch-version` input to its `mode` input.

1. Determine the build tool:

   - 🪶**Maven**, if the project descriptor is **pom.xml**

   - 🐘**Gradle**, if the project descriptor is **build.gradle** or **build.gradle.kts**

1. If a specific version of Java is requested via `java-version`, install it using SDKMAN

1. If a specific version of the build tool is requested via `tool-version`, install it using SDKMAN

1. If **Maven** is the build tool:

   - if the **settings.xml** file exists in `project-directory`, copy it to **$HOME/.m2**

   - otherwise, provide a default one connecting the action credentials (`auth-user`, `auth-token`) with a **target-server** server id

1. Run [publish-github-pages](../publish-github-pages/README.md) with the `optional` flag enabled

1. Publish, using the build tool:

   - for 🪶**Maven**, run `mvn deploy`

     - if `dry-run` is enabled, actually publish to the **target/dry-run** subdirectory instead of the target server

   - for 🐘**Gradle**, run `gradle publish`

     - if `dry-run` is enabled, the `--dry-run` flag is passed

   - in any case, the following environment variables will be available during this step only:

     - **JVM_AUTH_USER** - with the value of `auth-user`

     - **JVM_AUTH_TOKEN** - with the value of `auth-token`

## ☑️Requirements

- The `mvn` or `gradle` command must be available, depending on the descriptor within the project directory - which also implies that a suitable **Java** environment is installed; by passing `java-version` and `tool-version`, you can enforce specific required versions instead of the default ones provided by the selected GitHub Actions runner.

- `auth-user` and `auth-token` are never mandatory - because of the flexibility provided by the supported build tools - but they are recommended for the most common scenarios:

  - when the build tool is 🪶**Maven**, for deploying a conventional library it is generally essential to declare a server named **target-server** within **pom.xml**, like this:

    ```xml
    <distributionManagement>
      <repository>
        <id>target-server</id>
        <name>Server description</name>
        <url>THE URL, ESPECIALLY WITH HTTPS</url>
      </repository>
    </distributionManagement>
    ```

    As a plus, a default **settings.xml** will be generated for you - referencing the environment variables containing the credentials.

  - when the build tool is 🐘**Gradle**, deploying a conventional library is more minimalist - something like this (in **build.gradle.kts**):

    ```kotlin

    plugins {
      `maven-publish`
    }

    publishing {
      repositories {
          maven {
              url = uri("REPO_URL_PREFERABLY_HTTPS")
              credentials {
                  username = System.getenv("JVM_AUTH_USER")
                  password = System.getenv("JVM_AUTH_TOKEN")
              }
          }
      }
    }
    ```

    where the environment variables are automatically provided by the action, forwarding `auth-user` and `auth-token` to the build script.

- The requirements for [publish-github-pages](../publish-github-pages/README.md) if `website-directory` references an existing directory.

- Before the first publication, running with `dry-run` set to **true** is recommended.

## 📥Inputs

|           Name           |          Type           |                    Description                    | Default value |
| :----------------------: | :---------------------: | :-----------------------------------------------: | :-----------: |
|        `dry-run`         |       **boolean**       |            Run a simulated publication            |   **false**   |
|       `auth-user`        |       **string**        |            The username for publishing            |               |
|       `auth-token`       |       **string**        |          The secret token for publishing          |               |
|      `java-version`      |       **string**        |        Java version (in SDKMAN) to install        |               |
|      `tool-version`      |       **string**        |     Build tool version (in SDKMAN) to install     |               |
|       `quiet-tool`       |       **boolean**       |         Run the build tool in quiet mode          |   **true**    |
|   `website-directory`    |       **string**        | Relative directory containing the project website |  **website**  |
| `enforce-branch-version` | `inject`,`check`,`skip` |     How the branch version should be enforced     |  **inject**   |
|   `project-directory`    |       **string**        |  The directory containing the project descriptor  |     **.**     |

## 🌐Further references

- [publish-github-pages](../publish-github-pages/README.md)

- [enforce-branch-version](../enforce-branch-version/README.md)

- [verify-jvm-project](../verify-jvm-project/README.md)

- [aurora-github](../../README.md)
