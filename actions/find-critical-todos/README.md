# find-critical-todos

Looks for _critical TODOs_ - that is, instances of the `TODO!` string - in source files.

## 🃏 Example

```yaml
steps:
  - uses: giancosta86/aurora-github/actions/find-critical-todos@v11
    with:
      files: "*.elv"
```

**Please, note**: this action is automatically run by most language-oriented `verify-` actions.

## 📥 Inputs

|        Name         |    Type    |                          Description                          | Default value |
| :-----------------: | :--------: | :-----------------------------------------------------------: | :-----------: |
|       `files`       | **string** | Comma-separated file patterns; if empty, the action won't run |               |
| `working-directory` | **string** |            The directory where the action must run            |     **.**     |

## 🌐 Further references

- [find-regex-pattern](../find-regex-pattern/README.md)

- [aurora-github](../../README.md)
