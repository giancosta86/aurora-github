# setup-nodejs-context

Installs and configures a **NodeJS** environment.

## 🃏 Example

```yaml
steps:
  - uses: giancosta86/aurora-github/actions/setup-nodejs-context@v11
```

**Please, note**: this action is automatically run by [verify-npm-package](../verify-npm-package/README.md) and [publish-npm-package](../publish-npm-package/README.md).

## 💡 How it works

1. Detect if a specific **NodeJS** version was requested for this project. In particular, in one of these cases:
   1. If the **.nvmrc** file exists in the project directory - containing the requested NodeJS version, as expected by `nvm`.

   1. If **package.json** declares the following field:

      ```json
      {
        "engines": {
          "node": "..."
        }
      }
      ```

1. If a specific **NodeJS** version was requested:
   1. If the `nvm` command is not available in the **Bash** shell, install a convenient version.

   1. Run `nvm install <requested NodeJS version>`

   Otherwise, consider whether the `node` command is accessible from PATH:
   - if the command is available, just proceed to the next major step

   - otherwise:
     1. if the `nvm` command is not available in the **Bash** shell, install a convenient version.

     1. install the **latest** NodeJS version

1. Setup **corepack**:
   1. if the `corepack-version` input is non-empty, run `npm install --global corepack@<corepack-version>`

   1. if the `corepack` command is available:
      1. display its version

      1. call `corepack:setup` from [astral-bridge](https://github.com/giancosta86/astral-bridge).

1. Use the `packagemanager:exec` command from [astral-bridge](https://github.com/giancosta86/astral-bridge) to run the `--version` command for the package manager required by the project. In particular, it is detected from:
   1. the `packageManager` field in **package.json**

   1. the following field in **package.json**:

      ```json
      {
        "devEngines": {
          "packageManager": {
            "name": "..."
          }
        }
      }
      ```

   1. a recognized _lockfile_ in the project directory

1. Run again the package manager, passing the `install` command - provided that `install-dependencies` is not set to **false**.

## ☑️ Requirements

- The **package.json** descriptor must exist in `working-directory`.

## 📥 Inputs

|          Name          |    Type     |                  Description                   | Default value |
| :--------------------: | :---------: | :--------------------------------------------: | :-----------: |
|   `corepack-version`   | **string**  | **corepack** version to install, empty to skip |  **latest**   |
| `install-dependencies` | **boolean** |  Run the package manager's `install` command   |   **true**    |
|  `working-directory`   | **string**  |      Directory containing `package.json`       |     **.**     |

## 🌐 Further references

- [astral-bridge](https://github.com/giancosta86/astral-bridge)

- [verify-npm-package](../verify-npm-package/README.md)

- [publish-npm-package](../publish-npm-package/README.md)

- [aurora-github](../../README.md)
