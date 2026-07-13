# publish-rust-crate

Publishes a **Rust** crate - by default, to [crates.io](https://crates.io/) - with all of its features enabled.

## 🃏 Example

```yaml
steps:
  - uses: giancosta86/aurora-github/actions/publish-rust-crate@v11
    with:
      cargo-token: ${{ secrets.CARGO_TOKEN }}
```

**Please, note**: this action is designed for _publication_ only - not for _verification_: you may want to use [verify-rust-crate](../verify-rust-crate/README.md) for that.

## 💡 How it works

1. Run [inject-branch-version](../inject-branch-version/README.md) on **Cargo.toml**.

1. Run [setup-rust-context](../setup-rust-context/README.md) to setup a Rust toolchain.

1. If the `document-all-features` input is **true**, enable documentation for all the features - but only if the `[package.metadata.docs.rs]` header is not already in the descriptor. For details, please consult [this link](https://docs.rs/about/metadata).

1. Display **Cargo.toml** just before publication.

1. Run `cargo publish`, with the `--all-features` flag.

## ☑️ Requirements

- `cargo-token` is _not_ mandatory when `dry-run` is enabled.

- `rust-toolchain.toml` must be present in `working-directory` - as described in [setup-rust-context](../setup-rust-context/README.md).

- Before the first publication, running with `dry-run` set to **true** is recommended.

## 📥 Inputs

|          Name           |    Type     |                            Description                            | Default value |
| :---------------------: | :---------: | :---------------------------------------------------------------: | :-----------: |
|        `dry-run`        | **boolean** |            Run a simulated publication via `--dry-run`            |   **false**   |
|      `cargo-token`      | **string**  |            Secret token for publishing to the registry            |               |
| `document-all-features` | **boolean** | Enable [Rustdoc for all features](https://docs.rs/about/metadata) |   **true**    |
|   `working-directory`   | **string**  |                 Directory containing `Cargo.toml`                 |     **.**     |

## 🌐 Further references

- [inject-branch-version](../inject-branch-version/README.md)

- [setup-rust-context](../setup-rust-context/README.md)

- [verify-rust-crate](../verify-rust-crate/README.md)

- [aurora-github](../../README.md)
