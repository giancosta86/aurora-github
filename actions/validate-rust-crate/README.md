# validate-rust-crate

Validates the source files of a Rust crate - which is especially useful as a condition for merging a pull request.

## Example

The action can be placed right after checking out the source code:

```yaml
steps:
  - uses: actions/checkout@v4

  - uses: giancosta86/aurora-github/actions/validate-rust-crate
```

## Steps

1. Optionally run [check-artifact-version](../check-version/README.md)

1. Print out the version info for the main components of the Rust toolchain - optionally ensuring the existence of `rust-toolchain.toml`

1. Check the style of the Rust source files - via `cargo fmt`

1. Lint via `cargo clippy` on all the targets and the features. All warnings are considered errors

1. Run `cargo test` with additional features disabled

1. Run `cargo test` with all features on

## Inputs

|           Name           |    Type     |                            Description                             | Default value |
| :----------------------: | :---------: | :----------------------------------------------------------------: | :-----------: |
| `check-artifact-version` | **boolean** | Runs [check-artifact-version](../check-artifact-version/README.md) |   **true**    |
| `verify-toolchain-file`  | **boolean** |              Ensures `rust-toolchain.toml` is present              |   **true**    |
|   `project-directory`    | **string**  |               The directory containing `Cargo.toml`                |     **.**     |
|         `shell`          | **string**  |                   The shell used to run commands                   |   **bash**    |

## Further references

- [aurora-github](../../README.md)
