# print-rust-info

Displays the current version of the main **Rust** components.

## Example

```yaml
steps:
  - uses: giancosta86/aurora-github/actions/print-rust-info
```

## Inputs

|          Name           |    Type     |               Description                | Default value |
| :---------------------: | :---------: | :--------------------------------------: | :-----------: |
| `verify-toolchain-file` | **boolean** | Ensures `rust-toolchain.toml` is present |   **true**    |
|   `project-directory`   | **string**  |  The directory containing `Cargo.toml`   |     **.**     |
|         `shell`         | **string**  |      The shell used to run commands      |   **bash**    |

## Further references

- [aurora-github](../../README.md)
