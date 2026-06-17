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

1. Run [enforce-branch-version](../enforce-branch-version/README.md), forwarding the `enforce-branch-version` input to its `mode` input.

1. Install the required NodeJS version, **pnpm** and the dependencies, via [setup-nodejs-context](../setup-nodejs-context/README.md)

1. Run `pnpm verify` - so that the related script in **package.json** can decide what to do.

1. Run `pnpm build` - if the **build** script is defined in **package.json**.

1. By default, run [check-subpath-exports](../check-subpath-exports/README.md) to verify that the `exports` field in `package.json` actually references existing files.

1. If a **tests** directory exists within `working-directory`, execute the tests.

   💡The rationale for this step is a parallelism with Rust's **tests** directory - dedicated to verify the crate under test from a _client_ perspective; however, in `verify-npm-package` you have even more fine-grained control over the test process: for example, you can automatically launch _a shell script_ to test the system, while still relying on the **tests** directory to host utility modules imported by different tests in the **src** directory tree.

   **Please, note**: should you need to execute a shell script for testing, a `verify.elv` / `verify.sh` script, run by Elvish or Bash, is required.

1. Find [critical TODOs](../find-critical-todos/README.md) in the source code - which crash the workflow by default.

## ☑️ Requirements

- The entire verification process for the package must be triggered by the `verify` script in `package.json` (see the example).

- The requirements for [setup-nodejs-context](../setup-nodejs-context/README.md).

## 📥 Inputs

|          Name           |    Type     |                       Description                       |              Default value               |
| :---------------------: | :---------: | :-----------------------------------------------------: | :--------------------------------------: |
|      `todo-files`       | **string**  |   File patterns potentially containing critical TODOs   | **src/\*\*[nomatch-ok].{js jsx ts tsx}** |
| `check-subpath-exports` | **boolean** | Run `check-subpath-exports` after the **verify** script |                 **true**                 |
|   `working-directory`   | **string**  |         The directory containing `package.json`         |                  **.**                   |

## 🌐 Further references

- [check-project-license](../check-project-license/README.md)

- [setup-nodejs-context](../setup-nodejs-context/README.md)

- [check-subpath-exports](../check-subpath-exports/README.md)

- [enforce-branch-version](../enforce-branch-version/README.md)

- [find-critical-todos](../find-critical-todos/README.md)

- [aurora-github](../../README.md)
