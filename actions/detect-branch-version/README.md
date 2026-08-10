# detect-branch-version

Extracts the version from the name of the current **Git** branch, returning a variety of info.

## 🃏 Example

```yaml
steps:
  - id: detector
    uses: giancosta86/aurora-github/actions/detect-branch-version@v11
```

## ☑️ Requirements

- **Essential**: the branch name must adhere to a [semantic version](https://semver.org/) format, optionally preceded by `v`. For example: `v1.0.2`.

## 📥 Inputs

_No inputs required._

## 📤 Outputs

|       Name        |    Type    |                       Description                        |   Example   |
| :---------------: | :--------: | :------------------------------------------------------: | :---------: |
|     `branch`      | **string** |                    Current Git branch                    | **v2.4.8**  |
|     `version`     | **string** | Version detected from the branch - always without prefix |  **2.4.8**  |
| `escaped-version` | **string** |        Escaped version - for regular expressions         | **2\.4\.8** |
|      `major`      | **string** |             `major` component of the version             |    **2**    |

## 🌐 Further references

- [semantic version](https://semver.org/)

- [aurora-github](../../README.md)
