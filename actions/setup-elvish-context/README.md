# setup-elvish-context

Installs an **Elvish** version and optional startup packages, caching everything between multiple jobs of the same workflow execution.

## 🃏Example

```yaml
steps:
  - uses: actions/checkout@v4

  - uses: giancosta86/aurora-github/actions/setup-elvish-context@v10
```

## 💡How it works

1. If the `elvish` command is already available in the system and the `skip-if-existing` input is set to **true** (the default), the action will do just nothing

1. - If the requested `Elvish` version was already installed by an execution of this action _during the running workflow_ (maybe in another job), use the cached version

   - Otherwise, install the **Elvish** shell, making the `elvish` command available along the system **PATH**

1. If at least one package was specified in the `packages` input (which **MUST** be either empty or a comma/space-separated list):

   - If the exact set of packages was already requested by a previous execution of this action during the current workflow, use the cached version

   - Otherwise, install them via `epm:install`, then cache the entire `$epm:managed-dir` directory

### Notes

1. The cache spans over the lifetime of a specific **workflow execution** - so every new workflow run will not see the previously cached entries.

1. The `aurora-github` package - contained in the [lib](../../lib/) directory - will also be available to any Elvish shell retrieved via this action; however, such library is to be considered **unstable** even between patch versions, so it should be used in custom script steps _only_ when your workflow references this action from a _specific release_ of aurora-github.

## ☑️Requirements

The requested Elvish version **must** include an `epm` module having a `$managed-dir` variable.

Also, if the `packages` input is non-empty, `epm` must provide the following functions:

- `install`

- `installed`

All the above features must follow the protocol described in the documentation for Elvish v0.21.

## 📥Inputs

|        Name        |                    Type                     |                      Description                      | Default value |
| :----------------: | :-----------------------------------------: | :---------------------------------------------------: | :-----------: |
|     `version`      |                 **string**                  |       The Elvish version to download and cache        |  **0.21.0**   |
|     `packages`     | **string** - empty or space/comma-separated |       Packages to install and cache with Elvish       |               |
| `skip-if-existing` |                 **boolean**                 | If the `elvish` command is available, just do nothing |   **true**    |

## 🌐Further references

- [Elvish](https://elv.sh/)

- [aurora-github](../../README.md)
