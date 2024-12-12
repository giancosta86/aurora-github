# check-subpath-exports

Verifies that all the [subpath exports](https://nodejs.org/api/packages.html#subpath-exports) in **package.json** actually match existing files.

## 🃏Example

```yaml
steps:
  - uses: giancosta86/aurora-github/actions/check-subpath-exports@v8
```

**Please, note**: this action is automatically run by [verify-npm-package](../verify-npm-package/README.md).

## ☑️Requirements

- The `jq` command (especially version **1.7**) must be available in the operating system.

## 📥Inputs

|        Name         |    Type    |               Description               | Default value |
| :-----------------: | :--------: | :-------------------------------------: | :-----------: |
| `project-directory` | **string** | The directory containing `package.json` |     **.**     |

## 🌐Further references

- [package.json - subpath exports](https://nodejs.org/api/packages.html#subpath-exports)

- [verify-npm-package](../verify-npm-package/README.md)

- [aurora-github](../../README.md)
