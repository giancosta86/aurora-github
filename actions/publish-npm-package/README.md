# publish-npm-package

Publishes a **NodeJS** package to an [npm](https://www.npmjs.com/) registry.

## Example

The action can be placed right after checking out the source code:

```yaml
steps:
  - uses: actions/checkout@v4

  - uses: giancosta86/aurora-github/actions/publish-npm-package@v5
    with:
      npm-token: ${{ secrets.NPM_TOKEN }}
```

**Please, note**: this action is designed for _publication_ only - not for _verification_: you may want use [verify-npm-package](../verify-npm-package/README.md) for that; as a plus, you can add publication-specific checks via the [pre-/post- hook scripts](https://docs.npmjs.com/cli/v10/using-npm/scripts) of your `package.json` file.

**Please, note:** this action is automatically run by [publish-rust-wasm](../publish-rust-wasm/README.md).

## Requirements

- The project's package manager must be [pnpm](https://pnpm.io/) - version `9` or later compatible.

- The requirements for [setup-nodejs-context](../setup-nodejs-context/README.md).

- Before the first publication, running with `dry-run` set to **true** is recommended.

## Inputs 📥

|        Name         |    Type     |                   Description                   |      Default value      |
| :-----------------: | :---------: | :---------------------------------------------: | :---------------------: |
|      `dry-run`      | **boolean** |   Run a simulated publication via `--dry-run`   |        **false**        |
|     `npm-token`     | **string**  | The secret token for publishing to the registry |                         |
|   `registry-url`    | **string**  |           The URL of the npm registry           | _Official npm registry_ |
|  `frozen-lockfile`  | **boolean** | Fail if `pnpm-lock.yaml` is missing or outdated |        **true**         |
| `project-directory` | **string**  |     The directory containing `package.json`     |          **.**          |
|       `shell`       | **string**  |         The shell used to run commands          |        **bash**         |

## Further references

- [setup-nodejs-context](../setup-nodejs-context/README.md)

- [verify-npm-package](../verify-npm-package/README.md)

- [publish-rust-wasm](../publish-rust-wasm/README.md)

- [aurora-github](../../README.md)
