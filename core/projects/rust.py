import re
from typing import Optional

from .base import Project


class RustProject(Project):
    _version_regex = re.compile(r"""^version\s*=\s*["'](.*)["']""")

    @property
    def technology(self) -> str:
        return "Rust"

    @property
    def emoji(self) -> str:
        return "🦀"

    @property
    def descriptor_name(self) -> str:
        return "Cargo.toml"

    def _read_version(self) -> Optional[str]:
        with self.descriptor_path.open() as descriptor:
            for line in descriptor:
                matcher = self._version_regex.match(line)

                if matcher:
                    return matcher.group(1)

        return None

    @property
    def build_tool(self) -> str:
        return "cargo"
