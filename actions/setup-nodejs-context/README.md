# setup-nodejs-context

Installs and configures a **NodeJS** environment.

## 🃏 Example

```yaml
steps:
  - uses: giancosta86/aurora-github/actions/setup-nodejs-context@v13
```

**Please, note**: this action is automatically run by [verify-npm-package](../verify-npm-package/README.md) and [publish-npm-package](../publish-npm-package/README.md).

## 💡 How it works

1. Check the overall directory structure, according with the _requirements_ described below.

1. Check that **package.json** exists and complies with the _requirements_ described below.

1. If **nvm** is not installed, run its installation script; anyway, display its version.

1. Run `nvm install <NodeJS version declared in engines/node>`

1. Configure **corepack**:
   1. run `npm install --global corepack@<corepack-version>`

   1. display its version

   1. run `corepack enable`

1. Use the `packagemanager:exec` command from [astral-bridge](https://github.com/giancosta86/astral-bridge) to run the `--version` command for the package manager required by the project; in particular, it will run `corepack install` if needed.

1. Run the package manager again, passing the `install` command - **freezing** the dependency list - provided that `install-dependencies` is not set to **false**.

## ☑️ Requirements

- The **.nvmrc** file **must not** exist; instead, use _shell hooks_ based on the `engines/node` field in **package.json** - like the ones in [astral-bridge](https://github.com/giancosta86/astral-bridge).

- The **package.json** descriptor must exist in `working-directory`, with the following fields:
  - `engines/nodes`

  - `packageManager` **or** `devEngines/packageManager`, as described by [corepack](https://www.npmjs.com/package/corepack)

## 📥 Inputs

|          Name          |    Type     |                 Description                 | Default value |
| :--------------------: | :---------: | :-----------------------------------------: | :-----------: |
|   `corepack-version`   | **string**  |       **corepack** version to install       |  **0.36.x**   |
| `install-dependencies` | **boolean** | Run the package manager's `install` command |   **true**    |
|  `working-directory`   | **string**  |     Directory containing `package.json`     |     **.**     |

## 🌐 Further references

- [astral-bridge](https://github.com/giancosta86/astral-bridge)

- [verify-npm-package](../verify-npm-package/README.md)

- [publish-npm-package](../publish-npm-package/README.md)

- [aurora-github](../../README.md)
