# upload-release-assets

Uploads one or more asset files to a **GitHub** release.

## 🃏 Example

```yaml
steps:
  - uses: giancosta86/aurora-github/actions/upload-release-assets@v11
    with:
      release-tag: v3.0.2
      working-directory: dist
      files: logo.png data.zip
```

## 💡 How it works

This action calls the [gh release upload](https://cli.github.com/manual/gh_release_upload) command to upload the given files.

## ☑️ Requirements

- The `release-tag` input must be the tag of an existing release.

## 📥 Inputs

|        Name         |            Type             |                     Description                      | Default value |
| :-----------------: | :-------------------------: | :--------------------------------------------------: | :-----------: |
|    `release-tag`    |         **string**          |              Tag of the target release               |               |
|       `files`       | **string**, comma-separated | Paths - even relative - of the asset files to upload |               |
|     `overwrite`     |         **boolean**         |       Overwrite existing assets in the release       |   **true**    |
| `working-directory` |         **string**          |           Directory containing the `files`           |     **.**     |

## 🌐 Further references

- [tag-and-release](../tag-and-release/README.md)

- [aurora-github](../../README.md)
