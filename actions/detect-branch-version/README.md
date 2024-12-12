# detect-branch-version

Extracts the version from the name of the current **Git** branch, returning both.

## 🃏Example

```yaml
steps:
  - id: detector
    uses: giancosta86/aurora-github/actions/detect-branch-version@v8

  - run: |
      branch="${{ steps.detector.outputs.branch }}"
      version="${{ steps.detector.outputs.version }}"
      escapedVersion="${{ steps.detector.outputs.escaped-version }}"
      major="${{ steps.detector.outputs.major }}"

      echo "🔎Detected version '$version' (escaped: '${escapedVersion}') from branch '$branch'"
      echo "🔎Major component: '${major}'"
```

## ☑️Requirements

- **Essential**: the branch name must have a [semantic version](https://semver.org/) format, optionally preceded by `v`. For example: `v1.0.2`.

- the branch name is read from `github.head_ref` if such variable is available - because the action is especially designed for pull-request workflows - and from `github.ref` otherwise.

## 📥Inputs

_No inputs required._

## 📤Outputs

|       Name        |    Type    |                         Description                          |   Example   |
| :---------------: | :--------: | :----------------------------------------------------------: | :---------: |
|     `branch`      | **string** |                    The current Git branch                    | **v2.4.8**  |
|     `version`     | **string** | The version detected from the branch - always without prefix |  **2.4.8**  |
| `escaped-version` | **string** |        The escaped version - for regular expressions         | **2\.4\.8** |
|      `major`      | **string** |             The `major` component of the version             |    **2**    |

## 🌐Further references

- [semantic version](https://semver.org/)

- [aurora-github](../../README.md)
