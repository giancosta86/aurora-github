# setup-python-context

Installs and configures a [PDM](https://pdm-project.org/en/latest/)-based **Python** environment.

## 🃏 Example

```yaml
steps:
  - uses: giancosta86/aurora-github/actions/setup-python-context@v13
    with:
      pdm-version: 2.28.2
```

**Please, note**: this action is automatically run by:

- [verify-python-package](../verify-python-package/README.md)

- [publish-python-package](../publish-python-package/README.md)

## 💡 How it works

1. Verify that [pyproject.toml](https://pydevtools.com/handbook/reference/pyproject.toml/) exists in `working-directory`.

1. If **pipx** is not already installed, install it.

1. Install the **project dependencies** via `pdm install`, if `install-dependencies` is set to **true** (the default).

## ☑️ Requirements

- The [pyproject.toml](https://pydevtools.com/handbook/reference/pyproject.toml/) descriptor **must** exist in `working-directory`.

## 📥 Inputs

|          Name          |    Type     |                   Description                    | Default value |
| :--------------------: | :---------: | :----------------------------------------------: | :-----------: |
|     `pdm-version`      | **string**  |         Version of PDM that will be used         |               |
| `install-dependencies` | **boolean** |           Run PDM's `install` command            |   **true**    |
|  `working-directory`   | **string**  | Directory containing the **pyproject.toml** file |     **.**     |

## 🌐 Further references

- [pipx](https://pipx.pypa.io/latest/index.html)

- [PDM](https://pdm-project.org/en/latest/)

- [Python](https://www.python.org/)

- [aurora-github](../../README.md)
