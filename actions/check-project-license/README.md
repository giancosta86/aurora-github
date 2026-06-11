# check-project-license

Checks the validity of the project license file.

## 🃏 Example

```yaml
steps:
  - uses: giancosta86/aurora-github/actions/check-project-license@v11
```

**Please, note**: this action is automatically run by most language-oriented `verify-` actions.

## ☑️ Requirements

- The POSIX `date` command must be available on the system.

## 💡 How it works

1. Check that the `license-file` path actually points to an existing file.

1. Verify that the current year is mentioned within the license file.

## 📥 Inputs

|      Name      |    Type    |         Description          | Default value |
| :------------: | :--------: | :--------------------------: | :-----------: |
| `license-file` | **string** | The path to the license file |  **LICENSE**  |

## 🌐 Further references

- [aurora-github](../../README.md)
