# verify-rust-crate

Verifies the source files of a **Rust** crate.

## 🃏 Example

```yaml
steps:
  - uses: giancosta86/aurora-github/actions/verify-rust-crate@v11
```

**Please, note**: this action is automatically run by [verify-rust-wasm](../verify-rust-wasm/README.md).

## 💡 How it works

1. Run [check-project-license](../check-project-license/README.md) to verify the **LICENSE** file.

1. Run [inject-branch-version](../inject-branch-version/README.md).

1. Run [setup-rust-context](../setup-rust-context/README.md).

1. Check the style of the Rust source files - via `cargo fmt`.

1. Perform lint checks via `cargo clippy`, enabling all features and targets. All warnings are considered errors. This step can be skipped.

1. Extract each code snippet from `README.md` - if the file exists - as a standalone test file in the `tests` directory.

1. Run `cargo test` with all the project features _disabled_.

1. Run `cargo test` with all the project features _enabled_.

1. Generate the documentation, with all the project features _enabled_. All warnings are considered errors. This step can be skipped.

1. Find [critical TODOs](../find-critical-todos/README.md) in the source code - which crash the workflow by default.

## ☑️ Requirements

- `rust-toolchain.toml` must be present in `working-directory` - as described in [setup-rust-context](../setup-rust-context/README.md)

## 📥 Inputs

|        Name         |    Type     |                     Description                     |            Default value            |
| :-----------------: | :---------: | :-------------------------------------------------: | :---------------------------------: |
|    `run-clippy`     | **boolean** |              Enable linting via Clippy              |              **true**               |
|   `check-rustdoc`   | **boolean** |  Build the documentation - with warnings as errors  |              **true**               |
|    `todo-files`     | **string**  | File patterns potentially containing critical TODOs | **{src tests}/\*\*[nomatch-ok].rs** |
| `working-directory` | **string**  |        The directory containing `Cargo.toml`        |                **.**                |

## 🌐 Further references

- [check-project-license](../check-project-license/README.md)

- [find-critical-todos](../find-critical-todos/README.md)

- [inject-branch-version](../inject-branch-version/README.md)

- [setup-rust-context](../setup-rust-context/README.md)

- [verify-rust-wasm](../verify-rust-wasm/README.md)

- [aurora-github](../../README.md)
