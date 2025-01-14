from pathlib import Path
from typing import Optional

from ..exceptions import AuroraException
from .base import Project

NODEJS_DESCRIPTOR_NAME = "package.json"

RUST_DESCRIPTOR_NAME = "Cargo.toml"

MAVEN_DESCRIPTOR_NAME = "pom.xml"

GRADLE_DESCRIPTOR_NAMES = ["build.gradle", "build.gradle.kts"]

PYTHON_DESCRIPTOR_NAME = "pyproject.toml"


def detect_project(
    project_directory: Path, descriptor_name: Optional[str] = None
) -> Project:
    if (
        descriptor_name == NODEJS_DESCRIPTOR_NAME
        or (project_directory / NODEJS_DESCRIPTOR_NAME).is_file()
    ):
        from .nodejs import NodeJsProject

        return NodeJsProject(project_directory)

    if (
        descriptor_name == RUST_DESCRIPTOR_NAME
        or (project_directory / RUST_DESCRIPTOR_NAME).is_file()
    ):
        from .rust import RustProject

        return RustProject(project_directory)

    if (
        descriptor_name == MAVEN_DESCRIPTOR_NAME
        or (project_directory / MAVEN_DESCRIPTOR_NAME).is_file()
    ):
        from .maven import MavenProject

        return MavenProject(project_directory)

    for gradle_descriptor_name in GRADLE_DESCRIPTOR_NAMES:
        if (
            descriptor_name == gradle_descriptor_name
            or (project_directory / gradle_descriptor_name).is_file()
        ):
            from .gradle import GradleProject

            return GradleProject(project_directory, gradle_descriptor_name)

    if (
        descriptor_name == PYTHON_DESCRIPTOR_NAME
        or (project_directory / PYTHON_DESCRIPTOR_NAME).is_file()
    ):
        from .python import PythonProject

        return PythonProject(project_directory)

    from .unknown import UnknownProject

    if not descriptor_name:
        raise AuroraException(
            "Descriptor file name must be specified for unknown technology!"
        )

    return UnknownProject(project_directory, descriptor_name)
