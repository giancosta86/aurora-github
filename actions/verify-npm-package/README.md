# verify-npm-package

Verifies the source files of a **NodeJS** package - by running its `verify` script within the `scripts` section of `package.json`.

It is worth noting this action can support any technology - as long as you comply with the requirements described below.

## Example

The action can be placed right after checking out the source code:

```yaml
steps:
  - uses: actions/checkout@v4

  - uses: giancosta86/aurora-github/actions/verify-npm-package@v4
```

**IMPORTANT**: please, remember to declare your verification process in the `verify` script within `package.json`! For example:

```json
"scripts": {
  "test": "vitest",
  "build": "tsc",
  "verify": "pnpm test && pnpm build"
}
```

## How it works

1. Optionally run [check-artifact-version](../check-artifact-version/README.md), to ensure that the artifact version in `package.json` matches the version detected from the name of the current Git branch.

1. Ensure that the package is based on **ESM** - via the `"type": "module"` attribute in `package.json`; this default behaviour can be disabled.

1. Find [critical TODOs](../find-critical-todos/README.md) in the source code - which crash the workflow by default.

1. Install the required NodeJS version, **pnpm** and the dependencies, via [setup-nodejs-context](../setup-nodejs-context/README.md)

1. Run `pnpm verify` - so that the related script in `package.json` can decide what to do.

1. By default, run [check-subpath-exports](../check-subpath-exports/README.md) to verify that the `exports` field in `package.json` actually references existing files.

## Requirements

- The package manager for the project must be [pnpm](https://pnpm.io/) - version `9` or later compatible.

- The entire verification process for the package must be triggered by the `verify` script in `package.json` (see the example).

- The root directory of the project must contain a `.nvmrc` file - declaring the required Node.js version - whose format must be compatible with the `actions/setup-node` action (for example: `vX.Y.Z`).

- The requirements for [check-artifact-version](../check-artifact-version/README.md), if `check-artifact-version` is enabled.

## Inputs 📥

|           Name            |    Type     |                             Description                             |      Default value       |
| :-----------------------: | :---------: | :-----------------------------------------------------------------: | :----------------------: |
|      `registry-url`       | **string**  |                     The URL of the npm registry                     | _Official npm registry_  |
|     `frozen-lockfile`     | **boolean** |          Fails if `pnpm-lock.yaml` is missing or outdated           |         **true**         |
| `crash-on-critical-todos` | **boolean** |           Crash the workflow if critical TODOs are found            |         **true**         |
|    `source-file-regex`    | **string**  |              PCRE pattern describing the source files               | **\\.(c\|m)?(j\|t)sx?$** |
| `check-artifact-version`  | **boolean** |    Ensure the version in `package.json` matches the branch name     |         **true**         |
|       `enforce-esm`       | **boolean** | Verify that the `type` field is `module` - to create an ESM package |         **true**         |
|  `check-subpath-exports`  | **boolean** |    Run `check-subpath-exports` after the `verify` package script    |         **true**         |
|    `project-directory`    | **string**  |               The directory containing `package.json`               |          **.**           |
|          `shell`          | **string**  |                   The shell used to run commands                    |         **bash**         |

## Further references

- [setup-nodejs-context](../setup-nodejs-context/README.md)

- [check-subpath-exports](../check-subpath-exports/README.md)

- [check-artifact-version](../check-artifact-version/README.md)

- [find-critical-todos](../find-critical-todos/README.md)

- [aurora-github](../../README.md)
