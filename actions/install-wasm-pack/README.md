# install-wasm-pack

Installs [wasm-pack](https://rustwasm.github.io/wasm-pack/), for creating **Rust**-based web assemblies.

## Example

```yaml
steps:
  - uses: giancosta86/aurora-github/actions/install-wasm-pack@v2
```

## Inputs

|        Name         |    Type    |           Description            | Default value |
| :-----------------: | :--------: | :------------------------------: | :-----------: |
| `wasm-pack-version` | **string** | The wasm-pack version to install |               |
|       `shell`       | **string** |  The shell used to run commands  |   **bash**    |

## Further references

- [wasm-pack](https://rustwasm.github.io/wasm-pack/)

- [aurora-github](../../README.md)
