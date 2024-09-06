# install-wasm-pack

Installs [wasm-pack](https://rustwasm.github.io/wasm-pack/), for creating **Rust**-based web assemblies.

## Example

```yaml
steps:
  - uses: giancosta86/aurora-github/actions/install-wasm-pack@v2
```

## Requirements

- `curl` must be installed in the system

## Inputs

|        Name         |    Type    |           Description            | Default value |
| :-----------------: | :--------: | :------------------------------: | :-----------: |
| `wasm-pack-version` | **string** | The wasm-pack version to install |               |
|       `shell`       | **string** |  The shell used to run commands  |   **bash**    |

## Further references

- [aurora-github](../../README.md)
