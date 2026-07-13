# run-elvish-tests

Runs tests via an **Elvish** script or via [Velvet](https://github.com/giancosta86/velvet).

## 🃏 Example

```yaml
steps:
  - uses: giancosta86/aurora-github/actions/run-elvish-tests@v11
```

## 💡 How it works

1. If `working-directory` contains a **verify.elv** script, just run it.

1. Otherwise ensure the given `velvet-version` is installed, then run:

   > velvet &flawless [<velvet-scripts>]

   within `working-directory`.

## 📥 Inputs

|        Name         |    Type    |              Description              | Default value |
| :-----------------: | :--------: | :-----------------------------------: | :-----------: |
|  `velvet-version`   | **string** |         Velvet version to use         |    **v4**     |
|  `velvet-scripts`   | **string** | Comma-separated Velvet scripts to run |               |
| `working-directory` | **string** |    Directory containing the tests     |     **.**     |

## 🌐 Further references

- [Velvet](https://github.com/giancosta86/velvet) - _Smooth, functional testing in the Elvish shell_

- [Elvish](https://elv.sh/)

- [aurora-github](../../README.md)
