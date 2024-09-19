# install-wasm-pack

Installs [wasm-pack](https://rustwasm.github.io/wasm-pack/), for creating **Rust**-based web assemblies.

## Example

```yaml
steps:
  - uses: giancosta86/aurora-github/actions/install-wasm-pack@v3
```

**Please, note:** this action is automatically run by [verify-rust-wasm](../verify-rust-wasm/README.md) and [publish-rust-wasm](../publish-rust-wasm/README.md).

## Inputs

|        Name         |    Type    |           Description            | Default value |
| :-----------------: | :--------: | :------------------------------: | :-----------: |
| `wasm-pack-version` | **string** | The wasm-pack version to install |               |
|       `shell`       | **string** |  The shell used to run commands  |   **bash**    |

## Further references

- [verify-rust-wasm](../verify-rust-wasm/README.md)

- [publish-rust-wasm](../publish-rust-wasm/README.md)

- [wasm-pack](https://rustwasm.github.io/wasm-pack/)

- [aurora-github](../../README.md)
