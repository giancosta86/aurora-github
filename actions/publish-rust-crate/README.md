# publish-rust-crate

Publishes a **Rust** crate to [crates.io](https://crates.io/), with all of its features enabled.

## Example

```yaml
steps:
  - uses: actions/checkout@v4

  - uses: giancosta86/aurora-github/actions/publish-rust-crate@v2
    with:
      cargo-token: ${{ secrets.CARGO_TOKEN }}
```

**Please, note**: this action is designed for _publication_ only - not for _verification_: you may want to use [verify-rust-crate](../verify-rust-crate/README.md) for that.

## Requirements

- a secret publication token, provided by [crates.io](https://crates.io/).

- Before the first publication, running with `dry-run` set to **true** is recommended.

## Inputs

|          Name           |    Type     |                            Description                             | Default value |
| :---------------------: | :---------: | :----------------------------------------------------------------: | :-----------: |
|      `cargo-token`      | **string**  | The secret token for publishing to [crates.io](https://crates.io/) |               |
|        `dry-run`        | **boolean** |            Run a simulated publication via `--dry-run`             |   **false**   |
| `document-all-features` | **boolean** | Enable [Rustdoc for all features](https://docs.rs/about/metadata)  |   **true**    |
|   `project-directory`   | **string**  |               The directory containing `Cargo.toml`                |     **.**     |
|         `shell`         | **string**  |                   The shell used to run commands                   |   **bash**    |

## Further references

- [verify-rust-crate](../verify-rust-crate/README.md)

- [aurora-github](../../README.md)
