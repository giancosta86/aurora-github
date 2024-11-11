# setup-nodejs-context

Conditionally installs a specific **NodeJS** version, **pnpm**, as well as the dependencies listed in **package.json**.

## Example

```yaml
steps:
  - uses: actions/checkout@v4

  - uses: giancosta86/aurora-github/actions/setup-nodejs-context@v6
```

**Please, note:** this action is automatically run by [verify-npm-package](../verify-npm-package/README.md) and [publish-npm-package](../publish-npm-package/README.md).

## How it works

1. If a `.nvmrc` file exists, install NodeJS and pnpm.

1. If a `package.json` file exists, install the dependencies, with the `--frozen-lockfile` flag enabled only if the `pnpm-lock.yaml` file is present.

## Requirements

- if the `.nvmrc` file exists, it must contain the NodeJS version, as expected by [nvm](https://github.com/nvm-sh/nvm).

- if the `pnpm-lock.yaml` file exists, it must be up-to-date.

## Inputs 📥

|        Name         |    Type    |               Description               | Default value |
| :-----------------: | :--------: | :-------------------------------------: | :-----------: |
|   `pnpm-version`    | **string** |       The version of pnpm to use        |     **9**     |
| `project-directory` | **string** | The directory containing `package.json` |     **.**     |
|       `shell`       | **string** |     The shell used to run commands      |   **bash**    |

## Further references

- [verify-npm-package](../verify-npm-package/README.md)

- [publish-npm-package](../publish-npm-package/README.md)

- [Node Version Manager](https://github.com/nvm-sh/nvm)

- [pnpm](https://pnpm.io/)

- [aurora-github](../../README.md)
