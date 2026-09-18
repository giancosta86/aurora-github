# setup-sdkman-context

Installs a set of SDKs using [SDKMAN](https://sdkman.io/).

## 🃏 Example

```yaml
steps:
  - uses: giancosta86/aurora-github/actions/setup-sdkman-context@v13
```

**Please, note**: this action is automatically run by [setup-jvm-context](../setup-jvm-context/README.md).

## 💡 How it works

1. Verify that [.sdkmanrc](https://sdkman.io/usage/#env-command) exists in `working-directory`.

1. Run `sdkman:setup-env` to:
   - install all the SDKs required by **.sdkmanrc**

   - update the **PATH** accordingly

   - set/unset **\*\_HOME** environment variables - based on the candidates declared in **.sdkmanrc**

1. Export the following variables to downstream steps within the workflow:
   - **PATH**

   - **SDKMAN_ENV**

   - **\*\_HOME** - one for each _installed candidate_.

## ☑️ Requirements

- The **.sdkmanrc** configuration file **must** exist in `working-directory` - something like:

  ```toml
  java=23-open
  maven=3.9.9
  ```

## 📥 Inputs

|        Name         |    Type    |                 Description                 | Default value |
| :-----------------: | :--------: | :-----------------------------------------: | :-----------: |
| `working-directory` | **string** | Directory containing the **.sdkmanrc** file |     **.**     |

## 🌐 Further references

- [SDKMAN](https://sdkman.io/)

- [setup-jvm-context](../setup-jvm-context/README.md)

- [aurora-github](../../README.md)
