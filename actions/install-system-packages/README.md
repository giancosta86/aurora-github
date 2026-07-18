# install-system-packages

Installs software using the platform's package manager.

## 🃏 Example

```yaml
steps:
  - uses: giancosta86/aurora-github/actions/install-system-packages@v11
    with:
      packages: moreutils
```

## 💡 How it works

1. If `packages` is an empty list, just exit the action.

1. If `required-command` is specified and can be found by the `type` Bash command, just exit the action.

1. If `initial-update` is **true** and no packages were installed by this action in the current job, update the package list.

1. Install the requested packages.

## ☑️ Requirements

This action currently supports only the `apt-get` package manager.

## 📥 Inputs

|        Name        |    Type     |                          Description                          | Default value |
| :----------------: | :---------: | :-----------------------------------------------------------: | :-----------: |
| `required-command` | **string**  | The packages will be installed only if the command is missing |               |
|     `packages`     | **string**  |           Packages to install, separated by commas            |               |
|  `initial-update`  | **boolean** |     Update the package list before the first installation     |   **true**    |

## 🌐 Further references

- [aurora-github](../../README.md)
