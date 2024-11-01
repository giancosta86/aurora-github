# check-rust-versions

Displays the current version of the main **Rust** components, after ensuring that `rust-toolchain.toml` is in the project directory.

## Example

```yaml
steps:
  - uses: giancosta86/aurora-github/actions/check-rust-versions@v5
```

**Please, note:** this action is automatically run by [verify-rust-crate](../verify-rust-crate/README.md).

## Requirements

- the [toolchain file](https://rust-lang.github.io/rustup/overrides.html#the-toolchain-file) file must exist within `project-directory`.

  It should include at least the required toolchain version, for example:

  ```toml
  [toolchain]
  channel = "1.80.0"
  ```

## Inputs 📥

|        Name         |    Type    |              Description              | Default value |
| :-----------------: | :--------: | :-----------------------------------: | :-----------: |
| `project-directory` | **string** | The directory containing `Cargo.toml` |     **.**     |
|       `shell`       | **string** |    The shell used to run commands     |   **bash**    |

## Further references

- [verify-rust-crate](../verify-rust-crate/README.md)

- [aurora-github](../../README.md)
