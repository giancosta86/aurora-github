# verify-python-package

Verifies the source files of a **Python** package using [PDM](https://pdm-project.org).

## 🃏Example

```yaml
steps:
  - uses: actions/checkout@v4

  - uses: giancosta86/aurora-github/actions/verify-python-package@v9
```

## 💡How it works

1. Run [check-project-license](../check-project-license/README.md) to verify the **LICENSE** file.

1. Run [enforce-branch-version](../enforce-branch-version/README.md), forwarding the `enforce-branch-version` input to its `mode` input.

1. If the `pdm` command is not installed (at the requested `pdm-version`, if declared), install it via **pipx**; upon installation, the latest version will be retrieved if `pdm-version` is not specified.

1. Run `pdm run verify` - where the **verify** script should be defined in the `[tool.pdm.scripts]` of **pyproject.toml**.

1. Run `pdm build` to build the project artifacts.

1. Find [critical TODOs](../find-critical-todos/README.md) in the source code - which crash the workflow by default.

## ☑️Requirements

- `pipx` is mandatory when PDM has to be installed.

- the **verify** script must be declared within **pyproject.toml**.

## 📥Inputs

|           Name            |          Type           |                  Description                   |       Default value       |
| :-----------------------: | :---------------------: | :--------------------------------------------: | :-----------------------: |
|       `pdm-version`       |       **string**        |       Version of PDM that should be used       |                           |
| `crash-on-critical-todos` |       **boolean**       | Crash the workflow if critical TODOs are found |         **true**          |
|    `source-file-regex`    |       **string**        |    PCRE pattern describing the source files    | view [source](action.yml) |
| `enforce-branch-version`  | `inject`,`check`,`skip` |   How the branch version should be enforced    |        **inject**         |
|    `project-directory`    |       **string**        |  The directory containing **pyproject.toml**   |           **.**           |

## 🌐Further references

- [check-project-license](../check-project-license/README.md)

- [enforce-branch-version](../enforce-branch-version/README.md)

- [find-critical-todos](../find-critical-todos/README.md)

- [aurora-github](../../README.md)
