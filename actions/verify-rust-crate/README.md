# verify-rust-crate

Verifies the source files of a **Rust** crate.

## Example

The action can be placed right after checking out the source code:

```yaml
steps:
  - uses: actions/checkout@v4

  - uses: giancosta86/aurora-github/actions/verify-rust-crate@v3
```

## How it works

1. Optionally run [check-artifact-version](../check-artifact-version/README.md), to ensure that the artifact version in `Cargo.toml` matches the version detected from the name of the current Git branch.

1. Display the version info for the main components of the Rust toolchain - verifying the existence of `rust-toolchain.toml`.

1. Check the style of the Rust source files - via `cargo fmt`.

1. Perform lint checks via `cargo clippy`, enabling all features and targets. All warnings are considered errors. This step can be skipped.

1. Run `cargo test` with all the project features _disabled_.

1. Run `cargo test` with all the project features _enabled_.

## Requirements

- `rust-toolchain.toml` must be present in `project-directory` - as described in [check-rust-versions](../check-rust-versions/README.md)

- The requirements for [check-artifact-version](../check-artifact-version/README.md), if `check-artifact-version` is enabled.

## Inputs

|           Name           |    Type     |                       Description                        | Default value |
| :----------------------: | :---------: | :------------------------------------------------------: | :-----------: |
|   `run-clippy-checks`    | **boolean** |                Enable linting via Clippy                 |   **true**    |
| `check-artifact-version` | **boolean** | Ensure the version in Cargo.toml matches the branch name |   **true**    |
|   `project-directory`    | **string**  |          The directory containing `Cargo.toml`           |     **.**     |
|         `shell`          | **string**  |              The shell used to run commands              |   **bash**    |

## Further references

- [check-artifact-version](../check-artifact-version/README.md)

- [check-rust-versions](../check-rust-versions/README.md)

- [aurora-github](../../README.md)
