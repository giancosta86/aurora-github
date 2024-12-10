# setup-nodejs-context

Conditionally installs a specific **NodeJS** version, **pnpm**, as well as the dependencies listed in **package.json**.

## Example

```yaml
steps:
  - uses: actions/checkout@v4

  - uses: giancosta86/aurora-github/actions/setup-nodejs-context@v8
```

**Please, note**: this action is automatically run by [verify-npm-package](../verify-npm-package/README.md) and [publish-npm-package](../publish-npm-package/README.md).

## How it works

1. If **package.json** declares a NodeJS version via the following field:

   ```json
   {
     "engines": {
       "node": "..."
     }
   }
   ```

   an entire NodeJS toolchain will be set up; in particular:

   1. **NodeJS** will be installed via [actions/setup-node](https://github.com/actions/setup-node), asking for the given version - which could have a variety of formats, as explained in the related documentation

   1. **pnpm** will be downloaded via [pnpm/action-setup](https://github.com/pnpm/action-setup).

      As for the version:

      - if **package.json** explicitly requests a specific version:

        ```json
        {
          "packageManager": "pnpm@..."
        }
        ```

        it will be used

      - otherwise, the **latest** version will be installed

1. No matter whether the toolchain was installed, retrieve the dependencies - as follows:

   - 🧊 if **pnpm-lock.yaml** exists, it is considered _frozen_ via the `--frozen-lockfile` flag

   - 🌞 otherwise, `--no-frozen-lockfile` is passed explicitly

## Requirements

- The **package.json** descriptor must exist

- If the **pnpm-lock.yaml** file exists, it must be up-to-date - because it's considered _frozen_.

## Inputs 📥

|        Name         |    Type    |              Description               | Default value |
| :-----------------: | :--------: | :------------------------------------: | :-----------: |
| `project-directory` | **string** | Directory containing the project files |     **.**     |

## Further references

- [verify-npm-package](../verify-npm-package/README.md)

- [publish-npm-package](../publish-npm-package/README.md)

- [Node Version Manager](https://github.com/nvm-sh/nvm)

- [pnpm](https://pnpm.io/)

- [aurora-github](../../README.md)
