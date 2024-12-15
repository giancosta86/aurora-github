# verify-maven-project

Verifies the source files of a **Maven** project.

## 🃏Example

```yaml
steps:
  - uses: actions/checkout@v4

  - uses: giancosta86/aurora-github/actions/verify-maven-project@v8
```

## 💡How it works

1. Run [enforce-branch-version](../enforce-branch-version/README.md), forwarding the `enforce-branch-version` input to its `mode` input.

1. If a specific Java version is declared as `java-version`, pass it to [install-via-sdkman](../install-via-sdkman/README.md)

1. If a specific Maven version is declared as `maven-version`, pass it to [install-via-sdkman](../install-via-sdkman/README.md)

1. Run `mvn verify` - always with batched output (`-B`), but also in quiet (`-q`) mode if `maven-quiet` is **true**.

1. Find [critical TODOs](../find-critical-todos/README.md) in the source code - which crash the workflow by default.

## ☑️Requirements

1. The `mvn` command must be available - which also implies that a suitable **Java** environment is installed; by passing `java-version` and `maven-version`, you can enforce specific required version instead of the default ones provided by the selected GitHub Actions runner.

## 📥Inputs

|           Name            |          Type           |                  Description                   |       Default value       |
| :-----------------------: | :---------------------: | :--------------------------------------------: | :-----------------------: |
|      `java-version`       |       **string**        |      Java version (in SDKMAN!) to install      |                           |
|      `maven-version`      |       **string**        |     Maven version (in SDKMAN!) to install      |         **3.9.9**         |
|       `maven-quiet`       |       **boolean**       |         Run Maven in quiet (`-q`) mode         |         **true**          |
| `crash-on-critical-todos` |       **boolean**       | Crash the workflow if critical TODOs are found |         **true**          |
|    `source-file-regex`    |       **string**        |    PCRE pattern describing the source files    | view [source](action.yml) |
| `enforce-branch-version`  | `inject`,`check`,`skip` |   How the branch version should be enforced    |        **inject**         |
|    `project-directory`    |       **string**        |     The directory containing `Cargo.toml`      |           **.**           |

## 🌐Further references

- [install-via-sdkman](../install-via-sdkman/README.md)

- [find-critical-todos](../find-critical-todos/README.md)

- [enforce-branch-version](../enforce-branch-version/README.md)

- [aurora-github](../../README.md)
