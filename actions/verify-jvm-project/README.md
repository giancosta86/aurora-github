# verify-jvm-project

Verifies the source files of a project for the **Java Virtual Machine** - using **Maven** or **Gradle**.

## 🃏 Example

```yaml
steps:
  - uses: giancosta86/aurora-github/actions/verify-jvm-project@v13
```

## 💡 How it works

1. Run [check-project-license](../check-project-license/README.md) to verify the **LICENSE** file, unless `check-license` is set to **false**.

1. Run [setup-jvm-context](../setup-jvm-context/README.md) to set up a JVM environment via [SDKMAN](https://sdkman.io/).

1. Run [inject-branch-version](../inject-branch-version/README.md) on the project descriptor.

1. Run:
   - `mvn verify` - always with batched output (`-B`)

   - `gradle build`

   in quiet (`-q`) mode if `quiet-tool` is **true**.

1. Find [critical TODOs](../find-critical-todos/README.md) in the source code.

## 📥 Inputs

|        Name         |    Type     |                     Description                     |                  Default value                  |
| :-----------------: | :---------: | :-------------------------------------------------: | :---------------------------------------------: |
|    `quiet-tool`     | **boolean** |          Run the build tool in quiet mode           |                    **true**                     |
|   `check-license`   | **boolean** |          Run checks on the project license          |                    **true**                     |
|    `todo-files`     | **string**  | File patterns potentially containing critical TODOs | **src/\*\*[nomatch-ok].{java kt scala groovy}** |
| `working-directory` | **string**  |     Directory containing the project descriptor     |                      **.**                      |

## 🌐 Further references

- [setup-jvm-context](../setup-jvm-context/README.md)

- [check-project-license](../check-project-license/README.md)

- [find-critical-todos](../find-critical-todos/README.md)

- [inject-branch-version](../inject-branch-version/README.md)

- [aurora-github](../../README.md)
