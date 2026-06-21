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

1. Run [check-project-license](../check-project-license/README.md) to verify the **LICENSE** file.

1. 1. Run [inject-branch-version](../inject-branch-version/README.md).

1. Run [setup-nodejs-context](../setup-nodejs-context/README.md)

1. Run the `verify` script from **package.json** _if_ such script is present

1. Run the `build` script from **package.json** - _if_ such script is present

1. By default, run [check-subpath-exports](../check-subpath-exports/README.md) .

## ☑️ Requirements

- **package.json** must exists - and it must contain the following scripts:
  - `verify`

  - `build`

## 📥 Inputs

|          Name           |    Type     |                       Description                       |                     Default value                     |
| :---------------------: | :---------: | :-----------------------------------------------------: | :---------------------------------------------------: |
|      `todo-files`       | **string**  |   File patterns potentially containing critical TODOs   | **{src tests}/\*\*[nomatch-ok].{'' c m}{j t}s{'' x}** |
| `check-subpath-exports` | **boolean** | Run `check-subpath-exports` after the **verify** script |                       **true**                        |
|   `working-directory`   | **string**  |         The directory containing `package.json`         |                         **.**                         |

## 🌐 Further references

- [setup-nodejs-context](../setup-nodejs-context/README.md)

- [check-subpath-exports](../check-subpath-exports/README.md)

- [check-project-license](../check-project-license/README.md)

- [inject-branch-version](../inject-branch-version/README.md)

- [find-critical-todos](../find-critical-todos/README.md)

- [aurora-github](../../README.md)
