# setup-jvm-context

Installs and configures a **JVM** environment using [SDKMAN](https://sdkman.io/).

## 🃏 Example

```yaml
steps:
  - uses: giancosta86/aurora-github/actions/setup-jvm-context@v13
```

**Please, note**: this action is automatically run by [verify-jvm-project](../verify-jvm-project/README.md) and [publish-jvm-project](../publish-jvm-project/README.md).

## 💡 How it works

1. Run [setup-sdkman-context](../setup-sdkman-context/README.md) on the given `working-directory`.

1. Set the following environment variables:
   - **jvm-descriptor** - the name of the descriptor file, among the supported ones:
     - `pom.xml` - 🪶 **Maven**

     - `build.gradle.kts` - 🐘 **Gradle** with **Kotlin** scripting

     - `build.gradle` - 🐘 **Gradle** with **Groovy** scripting

   - **jvm-build-tool** - the command used to process the descriptor:
     - `mvn` - 🪶 **Maven**

     - `gradle` - 🐘 **Gradle**

   If no supported descriptor is found in `working-directory`, the action _crashes_.

## ☑️ Requirements

- The **.sdkmanrc** configuration file **must** exist in `working-directory` - something like:

  ```toml
  java=23-open
  maven=3.9.9
  ```

- One of the supported descriptors **must** exist in `working-directory`.

## 📥 Inputs

|        Name         |    Type    |                 Description                 | Default value |
| :-----------------: | :--------: | :-----------------------------------------: | :-----------: |
| `working-directory` | **string** | Directory containing the **.sdkmanrc** file |     **.**     |

## 🌐 Further references

- [verify-jvm-project](../verify-jvm-project/README.md)

- [publish-jvm-project](../publish-jvm-project/README.md)

- [setup-sdkman-context](../setup-sdkman-context/README.md)

- [SDKMAN](https://sdkman.io/)

- [aurora-github](../../README.md)
