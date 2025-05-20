# setup-elvish-context

Installs the **Elvish** shell, caching it between multiple jobs of the same workflow execution.

## 🃏 Example

```yaml
steps:
  - uses: giancosta86/aurora-github/actions/setup-elvish-context@v11
```

## 💡 How it works

1. If the `elvish` command is already available in the system and the `skip-if-existing` input is set to **true** (the default), the action will do just nothing

1. - If the requested `Elvish` version was already installed by an execution of this action _during the running workflow_ (maybe in another job), use the cached version

   - Otherwise, install the **Elvish** shell, making the `elvish` command available along the system **PATH**

## 💬 Remarks

- The cache spans over the lifetime of a specific **workflow execution** - so every new workflow run will not see the previously cached entries.

- The following packages will also be available:

  - `aurora-github` - contained in the [core](../../core/) directory - however, such library is to be considered **unstable** even between patch versions, so it should be used in custom script steps _only_ when your workflow references this action from a _specific release_ of aurora-github.

  - [aurora-elvish](https://github.com/giancosta86/aurora-elvish) - at branch **v1**

- You need this action only to run your custom Elvish scripts - because it is automatically called by almost every action in aurora-github.

## ☑️ Requirements

The requested Elvish version **must** include an `epm` module having a `$managed-dir` variable - for example, Elvish v0.21.

## 📥 Inputs

|        Name        |    Type     |                      Description                      | Default value |
| :----------------: | :---------: | :---------------------------------------------------: | :-----------: |
|     `version`      | **string**  |       The Elvish version to download and cache        |  **0.21.0**   |
| `skip-if-existing` | **boolean** | If the `elvish` command is available, just do nothing |   **true**    |
|      `quiet`       | **boolean** |            Only print warnings and errors             |   **true**    |

## 🌐 Further references

- [Elvish](https://elv.sh/)

- [aurora-github](../../README.md)
