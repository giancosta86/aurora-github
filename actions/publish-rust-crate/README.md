# publish-rust-crate

Publishes a Rust crate to [crates.io](https://crates.io/), with all the features enabled.

## Example

```yaml
steps:
  - uses: actions/checkout@v4

  - uses: giancosta86/aurora-github/actions/publish-rust-crate
    with:
      cargo-token: ${{ secrets.CARGO_TOKEN }}
```

**Please, note**: this action is designed for **publication** only - not for validation: you can use [validate-rust-crate](../validate-rust-crate/README.md) instead.

## Requirements

- a secret publication token, provided by [crates.io](https://crates.io/).

## Inputs

|        Name         |    Type    |                         Description                          | Default value |
| :-----------------: | :--------: | :----------------------------------------------------------: | :-----------: |
|    `cargo-token`    | **string** | The secret token provided by [crates.io](https://crates.io/) |     **.**     |
| `project-directory` | **string** |            The directory containing `Cargo.toml`             |     **.**     |
|       `shell`       | **string** |                The shell used to run commands                |   **bash**    |

## Further references

- [validate-rust-crate](../validate-rust-crate/README.md)

- [aurora-github](../../README.md)
