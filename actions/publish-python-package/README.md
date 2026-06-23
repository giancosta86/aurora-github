# publish-python-package

Publishes a **Python** package using [PDM](https://pdm-project.org).

## 🃏 Example

```yaml
steps:
  - uses: giancosta86/aurora-github/actions/publish-python-package@v11
    with:
      index-user: __token__
      index-secret: ${{ secrets.PYPI_TOKEN }}
```

**Please, note**: this action is designed for _publication_ only - not for _verification_: you may want to use [verify-python-package](../verify-python-package/README.md) for that.

## 💡 How it works

1. Run [inject-branch-version](../inject-branch-version/README.md) on **pyproject.toml**.

1. If the `pdm` command is not installed (at the requested `pdm-version`, if declared), install it via **pipx**; upon installation, the latest version will be retrieved if `pdm-version` is not specified.

1. Run `pdm publish`, passing the `index-` inputs as environment variables; if `dry-run` is enabled, just perform a `pdm build`, skipping actual deployment.

## ☑️ Requirements

- `pipx` is mandatory when PDM has to be installed.

- Before the first publication, running with `dry-run` set to **true** is recommended.

## 📥 Inputs

|        Name         |    Type     |                Description                 | Default value |
| :-----------------: | :---------: | :----------------------------------------: | :-----------: |
|      `dry-run`      | **boolean** |        Run a simulated publication         |   **false**   |
|    `pdm-version`    | **string**  |     Version of PDM that should be used     |               |
|     `index-url`     | **string**  |          URL of the target index           |               |
|    `index-user`     | **string**  |      User for publishing to the index      |               |
|   `index-secret`    | **string**  | Password/token for publishing to the index |               |
| `working-directory` | **string**  | The directory containing `pyproject.toml`  |     **.**     |

## 🌐 Further references

- [verify-python-package](../verify-python-package/README.md)

- [aurora-github](../../README.md)
