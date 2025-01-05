import re
from pathlib import Path
from typing import Optional

from .base import Project


class GradleProject(Project):
    _version_regex = re.compile(r"""^version\s*=\s*["'](.*)["']""")

    def __init__(self, directory: Path, descriptor_name: str):
        super().__init__(directory)
        self._descriptor_name = descriptor_name

    @property
    def technology(self) -> str:
        return "Gradle"

    @property
    def emoji(self) -> str:
        return "🐘"

    @property
    def descriptor_name(self) -> str:
        return self._descriptor_name

    @property
    def build_tool(self) -> str:
        return "gradle"

    def _read_version(self) -> Optional[str]:
        with self.descriptor_path.open() as descriptor:
            for line in descriptor:
                matcher = self._version_regex.match(line)

                if matcher:
                    return matcher.group(1)

        return None
