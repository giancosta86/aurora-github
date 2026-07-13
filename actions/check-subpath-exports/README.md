# check-subpath-exports

Verifies that all the [subpath exports](https://nodejs.org/api/packages.html#subpath-exports) in **package.json** actually match existing files.

## 🃏 Example

```yaml
steps:
  - uses: giancosta86/aurora-github/actions/check-subpath-exports@v11
```

**Please, note**: this action is automatically run by [verify-npm-package](../verify-npm-package/README.md).

## 📥 Inputs

|        Name         |    Type    |             Description             | Default value |
| :-----------------: | :--------: | :---------------------------------: | :-----------: |
| `working-directory` | **string** | Directory containing `package.json` |     **.**     |

## 🌐 Further references

- [package.json - subpath exports](https://nodejs.org/api/packages.html#subpath-exports)

- [verify-npm-package](../verify-npm-package/README.md)

- [aurora-github](../../README.md)
