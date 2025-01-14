from os import getenv

from .detect_branch_version import detect_branch_version_info
from .exceptions import AuroraException
from .inputs import InputDto
from .processes import shell_run


class Inputs(InputDto):
    actions_directory: str


def check_action_references(inputs: Inputs) -> None:
    branch = detect_branch_version_info().branch
    if not branch:
        raise AuroraException("Cannot detect the branch!")

    print(f"🌲Current branch: '{branch}'")

    full_repo = getenv("GITHUB_REPOSITORY")
    if not full_repo:
        raise AuroraException("Cannot detect the full repository name!")

    print(f"🧭Full repository name: '{full_repo}'")

    reference_to_another_branch_regex = rf"uses:\s*{full_repo}[^@]+@(?!{branch})"

    grep_result = shell_run(
        f"grep --color=always -P '{reference_to_another_branch_regex}' **/*.yml",
        check=False,
        cwd=inputs.actions_directory,
    )

    match grep_result.returncode:
        case 0:
            raise AuroraException(
                f"There are references to actions within '{ inputs.actions_directory }' residing in other branches!"
            )

        case 1:
            print("✅No cross-branch action references detected!")

        case _:
            raise AuroraException("Error while invoking grep!")
