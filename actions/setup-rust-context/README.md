# setup-rust-context

Installs and configures a **Rust** toolchain.

## 🃏 Example

```yaml
steps:
  - uses: giancosta86/aurora-github/actions/setup-rust-context@v13
```

**Please, note**: this action is automatically run by [verify-rust-crate](../verify-rust-crate/README.md) and [publish-rust-crate](../publish-rust-crate/README.md).

## 💡 How it works

1. Verify that **rust-toolchain.toml** (see below) exists.

1. If the `rustup` and `cargo` commands are not accessible, run the [rustup](https://rustup.rs) installer.

1. If **Cargo.toml** exists, verify that the `edition` field is declared.

1. Set the `CARGO_TERM_COLOR` environment variable according to the value of the `cargo-colors` input.

1. Ensure the required components (**rustfmt**, **clippy**) are installed.

1. Display the versions of the main executables in the current Rust toolchain.

## ☑️ Requirements

- If existing, **rust-toolchain.toml** should include at least the required toolchain version - for example:

  ```toml
  [toolchain]
  channel = "1.80.0"
  ```

- **Cargo.toml**, if existing, requires the `edition` field.

## 📥 Inputs

|        Name         |    Type     |               Description               | Default value |
| :-----------------: | :---------: | :-------------------------------------: | :-----------: |
|   `cargo-colors`    | **boolean** |         Enable colors for Cargo         |   **true**    |
| `working-directory` | **string**  | Directory containing the toolchain file |     **.**     |

## 🌐 Further references

- [verify-rust-crate](../verify-rust-crate/README.md)

- [publish-rust-crate](../publish-rust-crate/README.md)

- [Rust language](https://rust-lang.org/)

- [aurora-github](../../README.md)
