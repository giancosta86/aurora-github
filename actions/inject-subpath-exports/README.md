# inject-subpath-exports

Appends [subpath exports](https://nodejs.org/api/packages.html#subpath-exports) to **package.json** according to the directory tree.

## Example

```yaml
steps:
  - uses: giancosta86/aurora-github/actions/inject-subpath-exports@v6
```

## How it works

Appends keys to the `exports` field of a `package.json` descriptor - according to the index files in the source directory tree.

## Supported modes

The `mode` input can have the following values:

- `prefer-index`:

  - if a **root index file** ( `<source-directory>/index.ts` or `<source-directory>/index.js`) exists, simply add it, with the following subpath:

    ```json
    ".": {
      "types": "./dist/index.d.ts",
      "import": "./dist/index.js"
    }
    ```

  - otherwise, check each first-level directory below `<source-directory>`: if such directory contains an **index file** (`index.ts` or `index.js`), add an entry for that directory:

    ```json
    "./<ENTRY>": {
      "types": "./dist/<ENTRY>/index.d.ts",
      "import": "./dist/<ENTRY>/index.js"
    }
    ```

- `all`: just like `prefer-index`, but also inspect subdirectories even if the _root index file_ exists.

### Important notes

- Existing `exports` entries are **never** deleted - the action can at most alter existing entries with a colliding key.

- The keys reference directories under `./dist`, **not** under `./<source-directory>`.

## Requirements

- The `jq` command (especially version **1.7**) must be available in the operating system.

- The `source-directory` and the root `package.json` descriptor must exist.

## Inputs 📥

|        Name         |         Type          |               Description               |  Default value   |
| :-----------------: | :-------------------: | :-------------------------------------: | :--------------: |
|       `mode`        | `prefer-index`, `all` |     Subpath exports generation mode     | **prefer-index** |
| `source-directory`  |      **string**       |  Relative path to the source directory  |     **src**      |
| `project-directory` |      **string**       | The directory containing `package.json` |      **.**       |

## Further references

- [subpath exports](https://nodejs.org/api/packages.html#subpath-exports)

- [aurora-github](../../README.md)
