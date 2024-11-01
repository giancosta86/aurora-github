# setup-nodejs-context

Installs a specific **NodeJS** version, [pnpm](https://pnpm.io/), and the dependencies listed in **package.json**.

## Example

```yaml
steps:
  - uses: actions/checkout@v4

  - uses: giancosta86/aurora-github/actions/setup-nodejs-context@v5
```

**Please, note:** this action is automatically run by [verify-npm-package](../verify-npm-package/README.md) and [publish-npm-package](../publish-npm-package/README.md).

## Requirements

The project directory must contain:

- the `package.json` descriptor

- the `.nvmrc` file, containing the expected NodeJS version, as expected by [nvm](https://github.com/nvm-sh/nvm)

- an updated `pnpm-lock.yaml` file, if `frozen-lockfile` is enabled

## Inputs 📥

|        Name         |    Type     |                   Description                   |      Default value      |
| :-----------------: | :---------: | :---------------------------------------------: | :---------------------: |
|   `pnpm-version`    | **string**  |           The version of pnpm to use            |          **9**          |
|   `registry-url`    | **string**  |           The URL of the npm registry           | _Official npm registry_ |
|  `frozen-lockfile`  | **boolean** | Fail if "pnpm-lock.yaml" is missing or outdated |        **true**         |
| `project-directory` | **string**  |     The directory containing `package.json`     |          **.**          |
|       `shell`       | **string**  |         The shell used to run commands          |        **bash**         |

## Further references

- [verify-npm-package](../verify-npm-package/README.md)

- [publish-npm-package](../publish-npm-package/README.md)

- [Node Version Manager](https://github.com/nvm-sh/nvm)

- [pnpm](https://pnpm.io/)

- [aurora-github](../../README.md)
