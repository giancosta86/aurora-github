import re
from pathlib import Path
from sys import exit

from .directories import switch_to
from .exceptions import AuroraException
from .inputs import InputDto

_snippet_regex = r"```rust\s*([^`]+?)\s*```"

_test_bootstrap_code = """

#[test]
fn run_code_snippet() {
    main().unwrap();
}
"""


class Inputs(InputDto):
    markdown_file: str
    optional: str
    test_filename_prefix: str
    project_directory: str


def extract_rust_snippets(inputs: Inputs) -> None:
    def check_markdown_file() -> None:
        if markdown_path.is_file():
            print(f"🗒️{markdown_path} found!")
            return

        if inputs.optional == "true":
            print("💭README.md not found - cannot extract snippets.")
            exit(0)

        raise AuroraException("Missing source Markdown file: '$markdownFile'!")

    def extract_snippets_to_files():
        print(f"📁Ensuring test directory: '{test_directory_path}'")
        test_directory_path.mkdir(parents=True)
        print("✅Test directory ready!")

        generated_test_files = []

        print("🔁Trying to extract tests from Rust snippets in Markdown...")
        for index, matcher in enumerate(
            re.finditer(_snippet_regex, markdown_path.read_text())
        ):
            snippet = matcher.group(1)
            updated_snippet = snippet + _test_bootstrap_code

            snippet_file_path = Path(f"{inputs.test_filename_prefix}{index + 1}.rs")

            snippet_file_path.write_text(updated_snippet)

            generated_test_files.append(snippet_file_path.name)

        if generated_test_files:
            print("🎩Process completed! Generated test files:")

            for test_file in generated_test_files:
                print(test_file)

            print("🎩🎩🎩")
        else:
            print("💭No snippets found in the source file...")

    with switch_to(inputs.project_directory):
        markdown_path = Path(inputs.markdown_file)

        test_directory_path = Path(inputs.test_filename_prefix).parent
        print(f"🔎Test directory: '{test_directory_path}'")

        check_markdown_file()
        extract_snippets_to_files()
