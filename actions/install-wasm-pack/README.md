# install-wasm-pack

Installs [wasm-pack](https://rustwasm.github.io/wasm-pack/), for creating **Rust**-based web assemblies.

## 🃏 Example

```yaml
steps:
  - uses: giancosta86/aurora-github/actions/install-wasm-pack@v11
```

**Please, note**: this action is automatically run by [verify-rust-wasm](../verify-rust-wasm/README.md) and [publish-rust-wasm](../publish-rust-wasm/README.md).

## ☑️ Requirements

The **npm** command must be available on the system.

## 📥 Inputs

|        Name         |    Type    |             Description             | Default value |
| :-----------------: | :--------: | :---------------------------------: | :-----------: |
| `wasm-pack-version` | **string** | The version of wasm-pack to install |               |

## 🌐 Further references

- [verify-rust-wasm](../verify-rust-wasm/README.md)

- [publish-rust-wasm](../publish-rust-wasm/README.md)

- [wasm-pack](https://rustwasm.github.io/wasm-pack/)

- [aurora-github](../../README.md)
