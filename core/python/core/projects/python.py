import re
from typing import Optional

from .toml import TomlProject


class PythonProject(TomlProject):
    @property
    def technology(self) -> str:
        return "Python"

    @property
    def emoji(self) -> str:
        return "🐍"

    @property
    def descriptor_name(self) -> str:
        return "pyproject.toml"

    @property
    def build_tool(self) -> str:
        return "pdm"
