# publish-rust-crate

Publishes a **Rust** crate - by default, to [crates.io](https://crates.io/) - with all of its features enabled.

## 🃏Example

```yaml
steps:
  - uses: actions/checkout@v4

  - uses: giancosta86/aurora-github/actions/publish-rust-crate@v8
    with:
      cargo-token: ${{ secrets.CARGO_TOKEN }}
```

**Please, note**: this action is designed for _publication_ only - not for _verification_: you may want to use [verify-rust-crate](../verify-rust-crate/README.md) for that.

## 💡How it works

1. Run [enforce-branch-version](../enforce-branch-version/README.md), forwarding the `enforce-branch-version` input to its `mode` input.

1. Run [publish-github-pages](../publish-github-pages/README.md) with the `optional` flag enabled

1. Run `cargo publish`, with the `--all-features` flag

## ☑️Requirements

- `cargo-token` is _not_ mandatory when `dry-run` is enabled.

- The requirements for [publish-github-pages](../publish-github-pages/README.md) if `website-directory` references an existing directory.

- Before the first publication, running with `dry-run` set to **true** is recommended.

## 📥Inputs

|           Name           |          Type           |                            Description                            | Default value |
| :----------------------: | :---------------------: | :---------------------------------------------------------------: | :-----------: |
|        `dry-run`         |       **boolean**       |            Run a simulated publication via `--dry-run`            |   **false**   |
|      `cargo-token`       |       **string**        |          The secret token for publishing to the registry          |               |
| `document-all-features`  |       **boolean**       | Enable [Rustdoc for all features](https://docs.rs/about/metadata) |   **true**    |
|   `website-directory`    |       **string**        |         Relative directory containing the project website         |  **website**  |
| `enforce-branch-version` | `inject`,`check`,`skip` |             How the branch version should be enforced             |  **inject**   |
|   `project-directory`    |       **string**        |               The directory containing `Cargo.toml`               |     **.**     |

## 🌐Further references

- [publish-github-pages](../publish-github-pages/README.md)

- [enforce-branch-version](../enforce-branch-version/README.md)

- [verify-rust-crate](../verify-rust-crate/README.md)

- [aurora-github](../../README.md)
