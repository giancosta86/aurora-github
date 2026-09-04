# setup-jvm-context

Installs and configures a **JVM** environment using **SDKMAN**.

## 🃏 Example

```yaml
steps:
  - uses: giancosta86/aurora-github/actions/setup-jvm-context@v13
```

**Please, note**: this action is automatically run by [verify-jvm-project](../verify-jvm-project/README.md) and [publish-jvm-project](../publish-jvm-project/README.md).

## 💡 How it works

1. Verify that [.sdkmanrc](https://sdkman.io/usage/#env-command) exists.

1. Run `sdk env install`, to install all the SDKs required by **.sdkmanrc**.

1. Run `sdkman:setup-env`, to set/unset environment variables - especially **JAVA_HOME** - and propagate them to the rest of the workflow.

1. Set the following environment variables:
   - **jvm-descriptor**: the name of the descriptor file, among the supported ones.

   - **jvm-build-tool**: the command used to process the descriptor.

   If no supported descriptor is found in `working-directory`, the variables are set to _an empty value_.

## ☑️ Requirements

- The **.sdkmanrc** configuration file **must** exist - something like:

  ```toml
  java=23-open
  maven=3.9.9
  ```

## 📥 Inputs

|        Name         |    Type    |                 Description                 | Default value |
| :-----------------: | :--------: | :-----------------------------------------: | :-----------: |
| `working-directory` | **string** | Directory containing the **.sdkmanrc** file |     **.**     |

## 🌐 Further references

- [verify-jvm-project](../verify-jvm-project/README.md)

- [publish-jvm-project](../publish-jvm-project/README.md)

- [aurora-github](../../README.md)
