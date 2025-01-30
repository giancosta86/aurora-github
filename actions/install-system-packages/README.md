# install-system-packages

Installs software using the platform's package manager.

## 🃏Example

```yaml
steps:
  - uses: giancosta86/aurora-github/actions/install-system-packages@v10
    with:
      packages: moreutils
```

## ☑️Requirements

This action currently supports only the `apt-get` package manager.

## 💡How it works

1. If `required-command` is specified and can be found by the `type` command, just exit the action.

1. If `initial-update` is **true** and no packages were installed by this action in the current workflow, update the package list.

1. Install the requested packages.

## 📥Inputs

|        Name        |    Type     |                               Description                                | Default value |
| :----------------: | :---------: | :----------------------------------------------------------------------: | :-----------: |
| `required-command` | **string**  | When declared, the packages are installed only if the command is missing |               |
|     `packages`     | **string**  |        The packages to install, separated by any spaces or commas        |               |
|  `initial-update`  | **boolean** |          Update the package list before the first installation           |   **true**    |

## 🌐Further references

- [aurora-github](../../README.md)
