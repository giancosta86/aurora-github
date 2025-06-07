# install-via-sdkman

Installs the requested SDK using [SDKMAN!](https://sdkman.io/)

## 🃏 Example

```yaml
steps:
  - uses: giancosta86/aurora-github/actions/install-sdkman-candidate@v11
    with:
      candidate: java
      version: 23-open
```

## 💡 How it works

1. If SDKMAN is not installed, download and install it.

1. Install the requested SDK and append its path to the **PATH** environment variable.

**Please, note**: all the SDKS are installed to `$HOME/.sdkman/candidates`

## ☑️ Requirements

- `candidate` must be an identifier belonging to the [list of SDKs](https://sdkman.io/sdks) supported by SDKMAN.

- `version` must be one of the versions supported for the chosen candidate. You can see it by running:

  ```bash
  sdk list <candidate>
  ```

  where `candidate` is the identifier of the required SDK.

## 📥 Inputs

|    Name     |    Type    |                 Description                  | Default value |
| :---------: | :--------: | :------------------------------------------: | :-----------: |
| `candidate` | **string** | Identifier (in SDKMAN) of the SDK to install |               |
|  `version`  | **string** |    Identifier (in SDKMAN) of the version     |               |

## 🌐 Further references

- [SDKMAN!](https://sdkman.io/)

- [aurora-github](../../README.md)
