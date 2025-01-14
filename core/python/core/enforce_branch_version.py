from pathlib import Path
from typing import Optional

from .detect_branch_version import detect_branch_version_info
from .exceptions import AuroraException
from .inputs import InputDto
from .projects import Project, UnknownProject, detect_project


class Inputs(InputDto):
    mode: str
    artifact_descriptor: Optional[str]
    project_directory: str


def _detect_project(inputs: Inputs) -> Project:
    project = detect_project(Path(inputs.project_directory), inputs.artifact_descriptor)
    print(f"🔮Detected project: {project}")

    return project


def enforce_branch_version(inputs: Inputs) -> None:
    match inputs.mode:
        case "inject":
            project = _detect_project(inputs)
            strategy = lambda: _inject(project)

        case "check":
            project = _detect_project(inputs)
            strategy = lambda: _check(project)

        case "skip":
            strategy = _skip

        case _:
            raise AuroraException(f"Invalid value for 'mode' input: '{inputs.mode}'!")

    strategy()


def _inject(project: Project) -> None:
    version = detect_branch_version_info().version

    print(f"🧬Injecting the branch version into {project}...")

    descriptor_file_content = project.descriptor_path.read_text()

    updated_content = descriptor_file_content.replace("0.0.0", version)

    project.descriptor_path.write_text(updated_content)

    print("✅Version injected!")

    project.print_descriptor()


def _check(project: Project) -> None:
    project.print_descriptor()

    branch_version = detect_branch_version_info().version

    if isinstance(project, UnknownProject):
        print(f"🌲Branch version: '{branch_version}'")

        print(f"🔎Ensuring the branch version exists in {project}...")

        version_found = branch_version in project.descriptor_path.read_text()

        if version_found:
            print("✅Version found in the descriptor!")
        else:
            raise AuroraException(
                "The branch version cannot be found in the artifact descriptor!"
            )
    else:
        artifact_version = project.read_version()

        print(f"🌲Branch version: '{branch_version}'")
        print(f"🔎Artifact version: '{artifact_version}'")

        if branch_version == artifact_version:
            print("✅The descriptor version matches the branch version!")
        else:
            raise AuroraException(
                "The descriptor version and the branch version do not match!"
            )


def _skip() -> None:
    print("💭Skipping branch version enforcement, as requested...")
