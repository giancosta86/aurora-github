import json
import sys
from subprocess import run
from typing import Optional

from .base import Project


class NodeJsProject(Project):
    @property
    def technology(self) -> str:
        return "NodeJS"

    @property
    def emoji(self) -> str:
        return "📦"

    @property
    def descriptor_name(self) -> str:
        return "package.json"

    def _read_version(self) -> Optional[str]:
        descriptor_json = json.loads(self.descriptor_path.read_text())

        return descriptor_json["version"]

    def _print_descriptor_content(self):
        sys.stdout.flush()
        sys.stderr.flush()
        run(["jq", "-C", ".", self.descriptor_path])

    @property
    def build_tool(self) -> str:
        return "pnpm"
