# setup-elvish-context

Installs the **Elvish** shell and a set of core libraries.

## 🃏 Example

```yaml
steps:
  - uses: giancosta86/aurora-github/actions/setup-elvish-context@v11
```

## 💡 How it works

1. If the `elvish` command is **not** already available in the system, the requested `version` will be installed.

1. Ensures [epm-plus](https://github.com/giancosta86/epm-plus) is installed - and that `epm` is patched.

1. Ensures that the `github.com/giancosta86/aurora-github` library is a _symlink_ to the `core` directory in the **aurora-github** project.

1. If the `ethereal-version` input is set, such version of [Ethereal](https://github.com/giancosta86/ethereal) will be installed via the [install-elvish-packages](../install-elvish-packages/README.md) action.

## 📥 Inputs

|        Name        |    Type    |                        Description                        | Default value |
| :----------------: | :--------: | :-------------------------------------------------------: | :-----------: |
|     `version`      | **string** |               The Elvish version to install               |  **0.21.0**   |
| `ethereal-version` | **string** | The Ethereal version to install - or empty string to skip |    **v1**     |

## 🌐 Further references

- [epm-plus](https://github.com/giancosta86/epm-plus) - _Package versioning for epm in Elvish_

- [Ethereal](https://github.com/giancosta86/ethereal)

- [Elvish](https://elv.sh/)

- [aurora-github](../../README.md)
