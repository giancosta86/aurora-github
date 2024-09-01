# install-wasm-pack

Installs [wasm-pack](https://rustwasm.github.io/wasm-pack/) for creating Rust-based web assemblies.

## Requirements

- a Bash-compatible shell must be available and used by this action.

## Inputs

|  Name   |    Type    |          Description           | Default value |
| :-----: | :--------: | :----------------------------: | :-----------: |
| `shell` | **string** | The shell used to run commands |   **bash**    |

## Example

```yaml
steps:
  - uses: giancosta86/aurora-github/actions/install-wasm-pack@v2
```

## Further references

- [aurora-github](../../README.md)
