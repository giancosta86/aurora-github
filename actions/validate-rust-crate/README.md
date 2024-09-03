# validate-rust-crate

Validates the source files of a Rust crate - which is especially useful as a condition for merging a pull request.

## Example

The action can be placed right after checking out the source code:

```yaml
steps:
  - uses: actions/checkout@v4

  - uses: giancosta86/aurora-github/actions/validate-rust-crate
```

## Requirements

- `rust-toolchain.toml` must be present in `project-directory` - as described in [print-rust-info](../print-rust-info/README.md)

## Steps

1. Optionally run [check-artifact-version](../check-artifact-version/README.md).

1. Display the version info for the main components of the Rust toolchain - ensuring the existence of `rust-toolchain.toml`.

1. Check the style of the Rust source files - via `cargo fmt`.

1. Lint via `cargo clippy`, enabling all features and targets. All warnings are considered errors.

1. Run `cargo test` with no features.

1. Run `cargo test` enabling all features.

## Inputs

|           Name           |    Type     |                            Description                             | Default value |
| :----------------------: | :---------: | :----------------------------------------------------------------: | :-----------: |
| `check-artifact-version` | **boolean** | Runs [check-artifact-version](../check-artifact-version/README.md) |   **true**    |
|   `project-directory`    | **string**  |               The directory containing `Cargo.toml`                |     **.**     |
|         `shell`          | **string**  |                   The shell used to run commands                   |   **bash**    |

## Further references

- [check-artifact-version](../check-artifact-version/README.md)

- [print-rust-info](../print-rust-info/README.md)

- [aurora-github](../../README.md)
