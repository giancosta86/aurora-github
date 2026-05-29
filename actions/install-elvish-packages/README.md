# install-elvish-packages

Installs packages for the **Elvish** shell, supporting the extended format introduced by [epm-plus](https://github.com/giancosta86/epm-plus).

## 🃏 Example

```yaml
steps:
  - uses: giancosta86/aurora-github/actions/install-elvish-packages@v11
    with:
      packages: github.com/giancosta86/primrose@v1 github.com/giancosta86/astral-bridge@v1
```

## 💡 How it works

1. Ensures that **epm-plus** is installed, possibly using `epm` to install it.

1. Patches `epm` with **epm-plus**.

1. Install the required packages via the patched `epm:install`.

## ☑️ Requirements

This action requires the `elvish` shell to be installed.

## 📥 Inputs

|    Name    |    Type    |                           Description                            | Default value |
| :--------: | :--------: | :--------------------------------------------------------------: | :-----------: |
| `packages` | **string** | The **space-separated** `<name>[@<version>]` packages to install |               |

## 🌐 Further references

- [epm-plus](https://github.com/giancosta86/epm-plus)

- [aurora-github](../../README.md)
