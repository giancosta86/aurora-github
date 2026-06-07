# verify-elvish-package

Verifies the source files of an **Elvish** library.

## 🃏 Example

```yaml
steps:
  - uses: giancosta86/aurora-github/actions/verify-elvish-package@v11
```

## 💡 How it works

1. Run [check-project-license](../check-project-license/README.md) to verify the **LICENSE** file.

1. Ensure that the library _metadata_ are declared.

1. Execute the tests.

1. Find [critical TODOs](../find-critical-todos/README.md) in the source code - which crash the workflow by default.

## ☑️ Requirements

- `metadata.xml` must be present in `project-directory` - as described in [epm:metadata](https://elv.sh/ref/epm.html#epm:metadata)

## 📥 Inputs

|           Name            |    Type     |                  Description                   |       Default value       |
| :-----------------------: | :---------: | :--------------------------------------------: | :-----------------------: |
| `crash-on-critical-todos` | **boolean** | Crash the workflow if critical TODOs are found |         **true**          |
|    `source-file-regex`    | **string**  |    PCRE pattern describing the source files    | view [source](action.yml) |
|    `project-directory`    | **string**  |     The directory containing `Cargo.toml`      |           **.**           |

## 🌐 Further references

- [check-project-license](../check-project-license/README.md)

- [find-critical-todos](../find-critical-todos/README.md)

- [aurora-github](../../README.md)
