import re
from typing import Optional

from .base import Project


class TomlProject(Project):
    _version_regex = re.compile(r"""^version\s*=\s*["'](.*)["']""")

    def _read_version(self) -> Optional[str]:
        with self.descriptor_path.open() as descriptor:
            for line in descriptor:
                matcher = self._version_regex.match(line)

                if matcher:
                    return matcher.group(1)

        return None
