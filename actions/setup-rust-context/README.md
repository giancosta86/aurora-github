# setup-rust-context

Installs and configures a **Rust** toolchain.

## 🃏 Example

```yaml
steps:
  - uses: giancosta86/aurora-github/actions/setup-rust-context@v11
```

**Please, note**: this action is automatically run by [verify-rust-crate](../verify-rust-crate/README.md) and [publish-rust-crate](../publish-rust-crate/README.md).

## 💡 How it works

1. Set the `CARGO_TERM_COLOR` environment variable according to the value of the `cargo-colors` input.

1. If the `check-toolchain-file` input is **true**, verify that the toolchain file (discussed above) exists.

1. Ensure the required components (**rustfmt**, **clippy**) are installed.

1. Display the versions of the executables in the current Rust toolchain.

## ☑️ Requirements

- The **Cargo.toml** descriptor must exist in `working-directory`.

- Some version of the `cargo` and `rustup` executables must already be available in the path.

- if the `check-toolchain-file` input is **true**, the [toolchain file](https://rust-lang.github.io/rustup/overrides.html#the-toolchain-file) file must exist within `working-directory`.

  It should include at least the required toolchain version, for example:

  ```toml
  [toolchain]
  channel = "1.80.0"
  ```

## 📥 Inputs

|          Name          |    Type     |                Description                 | Default value |
| :--------------------: | :---------: | :----------------------------------------: | :-----------: |
|     `cargo-colors`     | **boolean** |          Enable colors for Cargo           |   **true**    |
| `check-toolchain-file` | **boolean** | Verify the existence of the toolchain file |   **true**    |
|  `working-directory`   | **string**  |  Directory containing the toolchain file   |     **.**     |

## 🌐 Further references

- [verify-rust-crate](../verify-rust-crate/README.md)

- [publish-rust-crate](../publish-rust-crate/README.md)

- [aurora-github](../../README.md)
