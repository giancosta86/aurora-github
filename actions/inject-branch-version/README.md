# inject-branch-version

Injects the current branch version in lieu of `0.0.0` in the given file patterns.

## 🃏 Example

```yaml
steps:
  - uses: giancosta86/aurora-github/actions/inject-branch-version@v11
    with:
      files: package.json
```

## 📥 Inputs

|        Name         |    Type    |              Description              | Default value |
| :-----------------: | :--------: | :-----------------------------------: | :-----------: |
|       `files`       | **string** |    _Comma-separated_ file patterns    |     `**`      |
| `working-directory` | **string** | Directory where the action should run |      `.`      |

## 🌐 Further references

- [detect-branch-version](../detect-branch-version/README.md)

- [aurora-github](../../README.md)
