# publish-rust-crate

Publishes a Rust crate to [crates.io](https://crates.io/), with all the features enabled.

## Example

```yaml
steps:
  - uses: giancosta86/aurora-github/actions/publish-rust-crate
    with:
      cargo-token: ${{ secrets.CARGO_TOKEN }}
```

## Requirements

- a publication token

## Inputs

|        Name         |    Type    |                      Description                      | Default value |
| :-----------------: | :--------: | :---------------------------------------------------: | :-----------: |
|    `cargo-token`    | **string** | The token provided by [crates.io](https://crates.io/) |     **.**     |
| `project-directory` | **string** |         The directory containing `Cargo.toml`         |     **.**     |
|       `shell`       | **string** |            The shell used to run commands             |   **bash**    |

## Further references

- [aurora-github](../../README.md)