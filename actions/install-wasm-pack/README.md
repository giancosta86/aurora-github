# install-wasm-pack

Installs [wasm-pack](https://rustwasm.github.io/wasm-pack/), for creating Rust-based web assemblies.

## Example

```yaml
steps:
  - uses: giancosta86/aurora-github/actions/install-wasm-pack
```

## Requirements

- `curl` must be installed in the system

## Inputs

|  Name   |    Type    |          Description           | Default value |
| :-----: | :--------: | :----------------------------: | :-----------: |
| `shell` | **string** | The shell used to run commands |   **bash**    |

## Further references

- [aurora-github](../../README.md)
