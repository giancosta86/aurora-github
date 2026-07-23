# verify-elvish-package

Verifies the source files of an **Elvish** package.

## 🃏 Example

```yaml
steps:
  - uses: giancosta86/aurora-github/actions/verify-elvish-package@v11
```

## 💡 How it works

1. Run [check-project-license](../check-project-license/README.md) to verify the **LICENSE** file.

1. Run [inject-branch-version](../inject-branch-version/README.md) on **metadata.json**.

1. Performs checks on **metadata.json**.

1. Perform a **metadata-driven install** via [epm-plus](https://github.com/giancosta86/epm-plus).

1. Execute the tests via [run-elvish-tests](../run-elvish-tests/README.md).

1. Find [critical TODOs](../find-critical-todos/README.md) in the source code.

## ☑️ Requirements

- `metadata.json` must be present in `working-directory` - as described in [epm:metadata](https://elv.sh/ref/epm.html#epm:metadata)

## 📥 Inputs

|        Name         |    Type    |                     Description                     |      Default value       |
| :-----------------: | :--------: | :-------------------------------------------------: | :----------------------: |
|    `todo-files`     | **string** | File patterns potentially containing critical TODOs | **\*\*[nomatch-ok].elv** |
| `working-directory` | **string** |        Directory containing `metadata.json`         |          **.**           |

## 🌐 Further references

- [check-project-license](../check-project-license/README.md)

- [inject-branch-version](../inject-branch-version/README.md)

- [run-elvish-tests](../run-elvish-tests/README.md

- [find-critical-todos](../find-critical-todos/README.md)

- [aurora-github](../../README.md)
