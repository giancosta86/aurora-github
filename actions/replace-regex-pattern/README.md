# replace-regex-pattern

Replaces the _given regex_ with the _given replacement_ in all the requested files.

## 🃏 Example

```yaml
steps:
  - uses: giancosta86/aurora-github/actions/replace-regex-pattern@v11
    with:
      files: alpha.txt, **.md
      regex: "([ae])"
      replacement: "--$1--"
```

## 💡 How it works

1. The _comma-separated_ items in the `files` input are evaluated as _path patterns_ with **wildcards**; _non-file paths_ are ignored, so you don't need `[type:regular]`.

1. For **every** regular file emitted from the above point:
   1. The file content is read.

   1. All the occurrences of `regex` are replaced with `replacement` via Elvish's `re:replace`.

   1. The updated content is saved back to the file.

## 📥 Inputs

|        Name         |    Type    |                    Description                    | Default value |
| :-----------------: | :--------: | :-----------------------------------------------: | :-----------: |
|       `files`       | **string** |          _Comma-separated_ file patterns          |     `**`      |
|       `regex`       | **string** |          The regular expression pattern           |               |
|    `replacement`    | **string** | The replacement string - supporting `$<X>` groups |               |
| `working-directory` | **string** |     The directory where the action should run     |      `.`      |

## 🌐 Further references

- [Elvish - re module](https://elv.sh/ref/re.html)

- [Elvish - wildcard expansion](https://elv.sh/ref/language.html#wildcard-expansion)

- [aurora-github](../../README.md)
