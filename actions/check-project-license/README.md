# check-project-license

Checks the validity of the project license file.

## 🃏 Example

```yaml
steps:
  - uses: giancosta86/aurora-github/actions/check-project-license@v10
```

**Please, note**: this action is automatically run by:

- [verify-npm-package](../verify-npm-package/README.md)

- [verify-rust-crate](../verify-rust-crate/README.md)

- [verify-rust-wasm](../verify-rust-wasm/README.md)

- [verify-jvm-project](../verify-jvm-project/README.md)

- [verify-python-package](../verify-python-package/README.md)

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

- [verify-npm-package](../verify-npm-package/README.md)

- [verify-rust-crate](../verify-rust-crate/README.md)

- [verify-rust-wasm](../verify-rust-wasm/README.md)

- [verify-jvm-project](../verify-jvm-project/README.md)

- [verify-python-package](../verify-python-package/README.md)

- [aurora-github](../../README.md)
