# setup-nodejs-context

Sets up a specific **NodeJS** version and installs [pnpm](https://pnpm.io/) as well as the dependencies listed in **package.json**; any of these steps can be skipped by disabling the related flag.

## Example

```yaml
steps:
  - uses: actions/checkout@v4

  - uses: giancosta86/aurora-github/actions/setup-nodejs-context@v6
```

**Please, note:** this action is automatically run by [verify-npm-package](../verify-npm-package/README.md) and [publish-npm-package](../publish-npm-package/README.md).

## Requirements

The project directory must contain:

- the `.nvmrc` file, containing the expected NodeJS version, as expected by [nvm](https://github.com/nvm-sh/nvm) - if `setup-nodejs` is set to **true**

- the **package.json** descriptor, if `install-dependencies` is set to **true**

- an updated `pnpm-lock.yaml` file, if both `install-dependencies` and `frozen-lockfile` are enabled

## Inputs 📥

|          Name          |    Type     |                   Description                    | Default value |
| :--------------------: | :---------: | :----------------------------------------------: | :-----------: |
|     `setup-nodejs`     | **boolean** |       Set up the requested NodeJS version        |   **true**    |
|     `install-pnpm`     | **boolean** |        Install the requested pnpm version        |   **true**    |
| `install-dependencies` | **boolean** | Install the dependencies for the current package |   **true**    |
|     `pnpm-version`     | **string**  |            The version of pnpm to use            |     **9**     |
|   `frozen-lockfile`    | **boolean** | Fail if "pnpm-lock.yaml" is missing or outdated  |   **true**    |
|  `project-directory`   | **string**  |     The directory containing `package.json`      |     **.**     |
|        `shell`         | **string**  |          The shell used to run commands          |   **bash**    |

## Further references

- [verify-npm-package](../verify-npm-package/README.md)

- [publish-npm-package](../publish-npm-package/README.md)

- [Node Version Manager](https://github.com/nvm-sh/nvm)

- [pnpm](https://pnpm.io/)

- [aurora-github](../../README.md)
