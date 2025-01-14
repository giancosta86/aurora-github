from pathlib import Path
from typing import Optional

from ..exceptions import AuroraException
from .base import Project


class UnknownProject(Project):
    def __init__(self, directory: Path, descriptor_name: str):
        super().__init__(directory)

        self._descriptor_name = descriptor_name

    @property
    def technology(self) -> str:
        return "Unknown"

    @property
    def emoji(self) -> str:
        return "🎁"

    @property
    def descriptor_name(self) -> str:
        return self._descriptor_name

    def _read_version(self) -> Optional[str]:
        return None

    @property
    def build_tool(self) -> str:
        raise AuroraException("No build tool for unknown project")
