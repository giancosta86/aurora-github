import re
from pathlib import Path
from sys import exit

from .directories import switch_to
from .exceptions import AuroraException
from .inputs import InputDto

_snippet_pattern = re.compile(r"``rust\s*(.*?)\s*```", re.DOTALL)

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
    with switch_to(inputs.project_directory):
        markdown_path = Path(inputs.markdown_file)

        _check_markdown_file(
            markdown_path=markdown_path, optional=inputs.optional == "true"
        )

        _extract_snippets_to_files(
            markdown_path=markdown_path,
            test_filename_prefix=inputs.test_filename_prefix,
        )


def _check_markdown_file(markdown_path: Path, optional: bool) -> None:
    if markdown_path.is_file():
        print(f"🗒️{markdown_path} found!")
        return

    if optional:
        print(f"💭{markdown_path} not found - cannot extract snippets.")
        exit(0)

    raise AuroraException(f"Missing source Markdown file: '{markdown_path}'!")


def _extract_snippets_to_files(markdown_path: Path, test_filename_prefix: str) -> None:
    test_directory_path = Path(test_filename_prefix).parent
    print(f"📁Ensuring test directory: '{test_directory_path}'")
    test_directory_path.mkdir(parents=True)
    print("✅Test directory ready!")

    generated_test_paths = []

    print("🔁Trying to extract tests from Rust snippets in Markdown...")
    for index, matcher in enumerate(
        re.finditer(_snippet_pattern, markdown_path.read_text())
    ):
        snippet = matcher.group(1)
        updated_snippet = snippet + _test_bootstrap_code

        snippet_path = Path(f"{test_filename_prefix}{index + 1}.rs")

        snippet_path.write_text(updated_snippet)

        generated_test_paths.append(snippet_path)

    if generated_test_paths:
        print("🎩Process completed! Generated test files:")

        for test_path in generated_test_paths:
            print(test_path)

        print("🎩🎩🎩")
    else:
        print("💭No snippets found in the source Markdown file...")
