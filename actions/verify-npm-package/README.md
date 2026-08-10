# verify-npm-package

Verifies the source files of a **NodeJS** package.

It is worth noting this action can support any related technology - as long as you comply with the requirements described below.

## 🃏 Example

```yaml
steps:
  - uses: giancosta86/aurora-github/actions/verify-npm-package@v11
```

**IMPORTANT**: please, remember to declare your verification process in the `verify` script within `package.json`! For example:

```json
"scripts": {
  "test": "vitest",
  "build": "tsc",
  "verify": "pnpm test && pnpm build"
}
```

## 💡 How it works

1. Run [check-project-license](../check-project-license/README.md) to verify the **LICENSE** file, unless `check-license` is set to **false**.

1. 1. Run [inject-branch-version](../inject-branch-version/README.md) on **package.json**.

1. Run [setup-nodejs-context](../setup-nodejs-context/README.md), forwarding `corepack-version` and installing the dependencies.

1. Run each of the following scripts from **package.json** - provided that it's declared:
   1. `verify`

   1. `build`

1. Run [check-subpath-exports](../check-subpath-exports/README.md), unless prevented by the related input.

1. Ensure there are no [critical TODOs](../find-critical-todos/README.md).

## ☑️ Requirements

- **package.json** must exist.

## 📥 Inputs

|          Name           |    Type     |                      Description                      |                     Default value                     |
| :---------------------: | :---------: | :---------------------------------------------------: | :---------------------------------------------------: |
|   `corepack-version`    | **string**  |    **corepack** version to install, empty to skip     |                      **latest**                       |
|     `check-license`     | **boolean** |           Run checks on the project license           |                       **true**                        |
|      `todo-files`       | **string**  |  File patterns potentially containing critical TODOs  | **{src tests}/\*\*[nomatch-ok].{'' c m}{j t}s{'' x}** |
| `check-subpath-exports` | **boolean** | Run `check-subpath-exports` after the package scripts |                       **true**                        |
|   `working-directory`   | **string**  |          Directory containing `package.json`          |                         **.**                         |

## 🌐 Further references

- [setup-nodejs-context](../setup-nodejs-context/README.md)

- [check-subpath-exports](../check-subpath-exports/README.md)

- [check-project-license](../check-project-license/README.md)

- [inject-branch-version](../inject-branch-version/README.md)

- [find-critical-todos](../find-critical-todos/README.md)

- [aurora-github](../../README.md)
