from dataclasses import dataclass
from pathlib import Path

from .exceptions import AuroraException
from .inputs import InputDto
from .outputs import OutputDto
from .projects import Project, detect_project


class Inputs(InputDto):
    project_directory: str


@dataclass(frozen=True)
class Outputs(OutputDto):
    build_tool: str
    descriptor: str


def get_jvm_build_tool(inputs: Inputs) -> Outputs:
    project = detect_project(Path(inputs.project_directory))

    build_tool = project.build_tool

    if build_tool not in ["mvn", "gradle"]:
        raise AuroraException("No available JVM build tool for this project!")

    return Outputs(build_tool=build_tool, descriptor=project.descriptor_name)
