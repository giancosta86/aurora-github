# verify-jvm-project

Verifies the source files of a project for the **Java Virtual Machine** - using **Maven** or **Gradle**.

## 🃏 Example

```yaml
steps:
  - uses: giancosta86/aurora-github/actions/verify-jvm-project@v11
```

## 💡 How it works

1. Run [check-project-license](../check-project-license/README.md) to verify the **LICENSE** file.

1. Determine the build tool:
   - 🪶**Maven**, if the project descriptor is **pom.xml**

   - 🐘**Gradle**, if the project descriptor is **build.gradle** or **build.gradle.kts**

1. If a specific Java version is declared as `java-version`, pass it to [install-via-sdkman](../install-via-sdkman/README.md)

1. If a specific build tool version is declared as `tool-version`, pass it to [install-via-sdkman](../install-via-sdkman/README.md)

1. Run [inject-branch-version](../inject-branch-version/README.md) on the project descriptor.

1. Run:
   - `mvn verify` - always with batched output (`-B`)

   - `gradle build`

   in quiet (`-q`) mode if `quiet-tool` is **true**.

1. Find [critical TODOs](../find-critical-todos/README.md) in the source code.

## ☑️ Requirements

- The `mvn` or `gradle` command must be available, depending on the descriptor within the project directory - which also implies that a suitable **Java** environment is installed; by passing `java-version` and `tool-version`, you can enforce specific required versions instead of the default ones provided by the selected GitHub Actions runner.

## 📥 Inputs

|        Name         |    Type     |                     Description                     |                  Default value                  |
| :-----------------: | :---------: | :-------------------------------------------------: | :---------------------------------------------: |
|   `java-version`    | **string**  |         Java version (in SDKMAN) to install         |                                                 |
|   `tool-version`    | **string**  |      Build tool version (in SDKMAN) to install      |                    **3.9.9**                    |
|    `quiet-tool`     | **boolean** |          Run the build tool in quiet mode           |                    **true**                     |
|    `todo-files`     | **string**  | File patterns potentially containing critical TODOs | **src/\*\*[nomatch-ok].{java kt scala groovy}** |
| `working-directory` | **string**  |     Directory containing the project descriptor     |                      **.**                      |

## 🌐 Further references

- [check-project-license](../check-project-license/README.md)

- [install-via-sdkman](../install-via-sdkman/README.md)

- [find-critical-todos](../find-critical-todos/README.md)

- [inject-branch-version](../inject-branch-version/README.md)

- [aurora-github](../../README.md)
