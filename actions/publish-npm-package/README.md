# npm

The **npm** action executes a [pnpm](https://pnpm.io/)-based pipeline designed to publish a package to the [npm](https://www.npmjs.com/) registry.

## Requirements

- The project's package manager must be **pnpm**.

- The `pnpm-lock.yaml` file must be committed into the repository.

- The root directory of the project must contain a `.nvmrc` file - declaring the required Node.js version - whose format must be compatible with the `actions/setup-node` action (for example: `vX.Y.Z`).

- The entire build process for the package must be triggered by the `prepack` script in `package.json` (see the example below).

## Inputs

- `npm-token` (**REQUIRED**): the token for publishing to npm.

- `project-directory`: the directory containing the `package.json` file. **Defaults to:** the repository's directory.

- `pnpm-version`: the required **pnpm** version. **Defaults to:** a sensible, modern version.

- `shell`: the interpreter running the commands. **Defaults to:** `bash`.

## Example

The action can be placed right after checking out the source code:

```yaml
steps:
  - uses: actions/checkout@v4

  - uses: giancosta86/aurora-github/actions/npm@v1
    with:
      npm-token: ${{ secrets.NPM_TOKEN }}
```

**IMPORTANT**: please, remember to declare your build process in the `prepack` script within `package.json`! For example:

```json
"scripts": {
  "build": "tsc",
  "test": "vitest",
  "prepack": "pnpm test && pnpm build"
}
```

## Further references

- [aurora-github](../../README.md)
