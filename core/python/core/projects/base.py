from abc import ABCMeta, abstractmethod
from pathlib import Path
from typing import Optional

from ..exceptions import AuroraException


class Project(metaclass=ABCMeta):
    def __init__(self, directory: Path):
        self._directory = directory

    @property
    def directory(self) -> Path:
        return self._directory

    @property
    @abstractmethod
    def technology(self) -> str:
        pass

    @property
    @abstractmethod
    def emoji(self) -> str:
        pass

    @property
    @abstractmethod
    def descriptor_name(self) -> str:
        pass

    @property
    def descriptor_path(self) -> Path:
        return self.directory / self.descriptor_name

    def print_descriptor(self) -> None:
        print(f"{self.emoji}{self.descriptor_name} content:")
        self._print_descriptor_content()
        print(self.emoji * 3)

    def _print_descriptor_content(self) -> None:
        descriptor_content = self.descriptor_path.read_text()
        print(descriptor_content)

    def read_version(self) -> str:
        version = self._read_version()

        if not version:
            raise AuroraException(f"Cannot detect version for {self}")

        return version

    @abstractmethod
    def _read_version(self) -> Optional[str]:
        pass

    @property
    @abstractmethod
    def build_tool(self) -> str:
        pass

    def __str__(self):
        return f"{self.emoji}{self.technology}({self.descriptor_name})"
