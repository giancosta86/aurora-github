import re
from typing import Optional

from .toml import TomlProject


class RustProject(TomlProject):
    @property
    def technology(self) -> str:
        return "Rust"

    @property
    def emoji(self) -> str:
        return "🦀"

    @property
    def descriptor_name(self) -> str:
        return "Cargo.toml"

    @property
    def build_tool(self) -> str:
        return "cargo"
