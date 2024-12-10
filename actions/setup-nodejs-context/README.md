# setup-nodejs-context

Conditionally installs **NodeJS** along with **pnpm**, as well as the dependencies listed in **package.json**.

## Example

```yaml
steps:
  - uses: actions/checkout@v4

  - uses: giancosta86/aurora-github/actions/setup-nodejs-context@v8
```

**Please, note**: this action is automatically run by [verify-npm-package](../verify-npm-package/README.md) and [publish-npm-package](../publish-npm-package/README.md).

## How it works

1. If **package.json** - which must exist - declares the following field:

   ```json
   {
     "engines": {
       "node": "..."
     }
   }
   ```

   an entire NodeJS toolchain will be set up; in particular:

   1. The requested **NodeJS** version - or a compatible one, if a range is passed - will be installed via [actions/setup-node](https://github.com/actions/setup-node)

   1. **pnpm** will be downloaded via [pnpm/action-setup](https://github.com/pnpm/action-setup).

      As for the version:

      - if **package.json** explicitly provides a `packageManager` reference:

        ```json
        {
          "packageManager": "pnpm@..."
        }
        ```

        it will be resolved

      - otherwise, the **latest** version will be installed

1. No matter whether the toolchain was installed, retrieve the dependencies - as follows:

   - 🧊 if **pnpm-lock.yaml** exists, it is considered _frozen_ via the `--frozen-lockfile` flag

   - 🌞 otherwise, `--no-frozen-lockfile` is passed explicitly

## Requirements

- The **package.json** descriptor must exist in `project-directory`.

- The `packageManager` field can be missing, but it can't reference another package manager.

- If the **pnpm-lock.yaml** file exists, it must be up-to-date - because it's considered _frozen_.

## Inputs 📥

|        Name         |    Type    |               Description               | Default value |
| :-----------------: | :--------: | :-------------------------------------: | :-----------: |
| `project-directory` | **string** | The directory containing `package.json` |     **.**     |

## Further references

- [verify-npm-package](../verify-npm-package/README.md)

- [publish-npm-package](../publish-npm-package/README.md)

- [actions/setup-node](https://github.com/actions/setup-node)

- [pnpm/action-setup](https://github.com/pnpm/action-setup)

- [pnpm](https://pnpm.io/)

- [aurora-github](../../README.md)
