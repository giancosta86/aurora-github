# publish-npm-package

The **npm** action executes a [pnpm](https://pnpm.io/)-based pipeline designed to publish a package to the [npm](https://www.npmjs.com/) registry.

## Example

The action can be placed right after checking out the source code:

```yaml
steps:
  - uses: actions/checkout@v4

  - uses: giancosta86/aurora-github/actions/publish-npm-package
    with:
      npm-token: ${{ secrets.NPM_TOKEN }}
```

**IMPORTANT**: please, remember to declare your build process in the `prepack` script within `package.json`! For example:

```json
"scripts": {
  "build": "tsc",
  "prepack": "pnpm build"
}
```

## Requirements

- The project's package manager must be **pnpm**.

- The `pnpm-lock.yaml` file must be committed into the repository.

- The root directory of the project must contain a `.nvmrc` file - declaring the required Node.js version - whose format must be compatible with the `actions/setup-node` action (for example: `vX.Y.Z`).

- The entire build process for the package must be triggered by the `prepack` script in `package.json` (see the example below).

## Inputs

|        Name         |    Type     |              Description              | Default value |
| :-----------------: | :---------: | :-----------------------------------: | :-----------: |
|     `npm-token`     | **string**  |   The secret token provided by npm    |     **9**     |
|   `pnpm-version`    | **boolean** |    The version of **pnpm** to use     |     **9**     |
| `project-directory` | **string**  | The directory containing `Cargo.toml` |     **.**     |
|       `shell`       | **string**  |    The shell used to run commands     |   **bash**    |

## Further references

- [aurora-github](../../README.md)
