# verify-elvish-package

Verifies the source files of an **Elvish** package.

## 🃏 Example

```yaml
steps:
  - uses: giancosta86/aurora-github/actions/verify-elvish-package@v11
```

## 💡 How it works

1. Run [check-project-license](../check-project-license/README.md) to verify the **LICENSE** file.

1. Ensure that the package _metadata_ are declared.

1. Run [inject-branch-version](../inject-branch-version/README.md) on **metadata.json**.

1. Execute the tests.

1. Find [critical TODOs](../find-critical-todos/README.md) in the source code.

## ☑️ Requirements

- `metadata.xml` must be present in `working-directory` - as described in [epm:metadata](https://elv.sh/ref/epm.html#epm:metadata)

## 📥 Inputs

|        Name         |    Type    |                     Description                     |      Default value       |
| :-----------------: | :--------: | :-------------------------------------------------: | :----------------------: |
|    `todo-files`     | **string** | File patterns potentially containing critical TODOs | **\*\*[nomatch-ok].elv** |
|  `velvet-version`   | **string** |              The Velvet version to use              |          **v4**          |
| `working-directory` | **string** |      The directory containing `metadata.json`       |          **.**           |

## 🌐 Further references

- [check-project-license](../check-project-license/README.md)

- [inject-branch-version](../inject-branch-version/README.md)

- [find-critical-todos](../find-critical-todos/README.md)

- [aurora-github](../../README.md)
