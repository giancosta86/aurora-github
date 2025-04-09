# setup-rust-context

Optionally installs and configures a **Rust** toolchain.

## 🃏Example

```yaml
steps:
  - uses: giancosta86/aurora-github/actions/setup-rust-context@v10
```

**Please, note**: this action is automatically run by [verify-rust-crate](../verify-rust-crate/README.md), [publish-rust-crate](../publish-rust-crate/README.md) and [run-custom-tests](../run-custom-tests/README.md).

## ☑️Requirements

- if the `check-toolchain-file` input is **true** (the default), the [toolchain file](https://rust-lang.github.io/rustup/overrides.html#the-toolchain-file) file must exist within `project-directory`.

  It should include at least the required toolchain version, for example:

  ```toml
  [toolchain]
  channel = "1.80.0"
  ```

## 💡How it works

1. Set the `CARGO_TERM_COLOR` environment variable according to the value of the `cargo-colors` input.

1. If the `check-toolchain-file` input is **true**, verify that the toolchain file (discussed above) exists.

1. Display the versions of the executables in the current Rust toolchain.

## 📥Inputs

|          Name          |    Type     |                 Description                 | Default value |
| :--------------------: | :---------: | :-----------------------------------------: | :-----------: |
|     `cargo-colors`     | **boolean** |           Enable colors for Cargo           |   **true**    |
| `check-toolchain-file` | **boolean** | Verify the existence of the toolchain file  |   **true**    |
|  `project-directory`   | **string**  | The directory containing the toolchain file |     **.**     |

## 🌐Further references

- [verify-rust-crate](../verify-rust-crate/README.md)

- [publish-rust-crate](../publish-rust-crate/README.md)

- [run-custom-tests](../run-custom-tests/README.md)

- [aurora-github](../../README.md)
