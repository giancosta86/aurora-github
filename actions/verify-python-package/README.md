# verify-python-package

Verifies the source files of a **Python** package using [PDM](https://pdm-project.org).

## 🃏 Example

```yaml
steps:
  - uses: giancosta86/aurora-github/actions/verify-python-package@v11
```

## 💡 How it works

1. Run [check-project-license](../check-project-license/README.md) to verify the **LICENSE** file.

1. Run [inject-branch-version](../inject-branch-version/README.md) on **pyproject.toml**.

1. If **pipx** is not already installed, install it.

1. If the `pdm` command is not installed (at the requested `pdm-version`, if declared), install it via **pipx**: the latest version will be retrieved if `pdm-version` is not specified.

1. Install the **project dependencies** via pdm.

1. Run `pdm run verify` - where the **verify** script should be defined in the `[tool.pdm.scripts]` of **pyproject.toml**.

1. Run `pdm build` to build the project artifacts.

1. Find [critical TODOs](../find-critical-todos/README.md) in the source code.

## ☑️ Requirements

- the **verify** script must be declared within **pyproject.toml**, like this:

  ```toml
  [tool.pdm.scripts]
  verify = "<your shell commands here>"
  ```

## 📥 Inputs

|        Name         |    Type    |                     Description                     | Default value |
| :-----------------: | :--------: | :-------------------------------------------------: | :-----------: |
|    `pdm-version`    | **string** |         Version of PDM that should be used          |               |
|    `todo-files`     | **string** | File patterns potentially containing critical TODOs |    **.py**    |
| `working-directory` | **string** |       Directory containing **pyproject.toml**       |     **.**     |

## 🌐 Further references

- [PDM](https://pdm-project.org)

- [check-project-license](../check-project-license/README.md)

- [inject-branch-version](../inject-branch-version/README.md)

- [find-critical-todos](../find-critical-todos/README.md)

- [aurora-github](../../README.md)
