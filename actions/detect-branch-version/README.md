# detect-branch-version

Extracts the current version from the Git branch name, returning both.

## Example

```yaml
steps:
  - id: detector
    uses: giancosta86/aurora-github/actions/detect-branch-version

  - run: |
      branch="${{ steps.detector.outputs.branch }}"
      version="${{ steps.detector.outputs.version }}"

      echo "Detected version '$version' from branch '$branch'"
```

## Requirements

- the branch name must be a [semantic version](https://semver.org/), optionally (and preferably) preceded by `b`. For example: `b1.0.2`.

## Inputs

|  Name   |    Type    |          Description           | Default value |
| :-----: | :--------: | :----------------------------: | :-----------: |
| `shell` | **string** | The shell used to run commands |   **bash**    |

## Outputs

|   Name    |    Type    |              Description              |  Example   |
| :-------: | :--------: | :-----------------------------------: | :--------: |
| `branch`  | **string** |        The current Git branch         | **b2.4.8** |
| `version` | **string** | The extracted version, without prefix | **2.4.8**  |

## Further references

- [aurora-github](../../README.md)
