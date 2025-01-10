# verify-jvm-project

Verifies the source files of a project for the **Java Virtual Machine** - using **Maven** or **Gradle**.

## 🃏Example

```yaml
steps:
  - uses: actions/checkout@v4

  - uses: giancosta86/aurora-github/actions/verify-jvm-project@v9
```

## 💡How it works

1. Run [enforce-branch-version](../enforce-branch-version/README.md), forwarding the `enforce-branch-version` input to its `mode` input.

1. Determine the build tool:

   - 🪶**Maven**, if the project descriptor is **pom.xml**

   - 🐘**Gradle**, if the project descriptor is **build.gradle** or **build.gradle.kts**

1. If a specific Java version is declared as `java-version`, pass it to [install-via-sdkman](../install-via-sdkman/README.md)

1. If a specific build tool version is declared as `tool-version`, pass it to [install-via-sdkman](../install-via-sdkman/README.md)

1. Run:

   - `mvn verify` - always with batched output (`-B`)

   - `gradle build`

   in quiet (`-q`) mode if `quiet-tool` is **true**.

1. Find [critical TODOs](../find-critical-todos/README.md) in the source code - which crash the workflow by default.

## ☑️Requirements

- The `mvn` or `gradle` command must be available, depending on the descriptor within the project directory - which also implies that a suitable **Java** environment is installed; by passing `java-version` and `tool-version`, you can enforce specific required versions instead of the default ones provided by the selected GitHub Actions runner.

## 📥Inputs

|           Name            |          Type           |                   Description                   |       Default value       |
| :-----------------------: | :---------------------: | :---------------------------------------------: | :-----------------------: |
|      `java-version`       |       **string**        |       Java version (in SDKMAN) to install       |                           |
|      `tool-version`       |       **string**        |    Build tool version (in SDKMAN) to install    |         **3.9.9**         |
|       `quiet-tool`        |       **boolean**       |        Run the build tool in quiet mode         |         **true**          |
| `crash-on-critical-todos` |       **boolean**       | Crash the workflow if critical TODOs are found  |         **true**          |
|    `source-file-regex`    |       **string**        |    PCRE pattern describing the source files     | view [source](action.yml) |
| `enforce-branch-version`  | `inject`,`check`,`skip` |    How the branch version should be enforced    |        **inject**         |
|    `project-directory`    |       **string**        | The directory containing the project descriptor |           **.**           |

## 🌐Further references

- [install-via-sdkman](../install-via-sdkman/README.md)

- [find-critical-todos](../find-critical-todos/README.md)

- [enforce-branch-version](../enforce-branch-version/README.md)

- [aurora-github](../../README.md)
