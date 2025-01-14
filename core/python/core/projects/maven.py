import xml.etree.ElementTree as ET
from typing import Optional

from ..exceptions import AuroraException
from .base import Project


class MavenProject(Project):
    @property
    def technology(self) -> str:
        return "Maven"

    @property
    def emoji(self) -> str:
        return "🪶"

    @property
    def descriptor_name(self) -> str:
        return "pom.xml"

    @property
    def build_tool(self) -> str:
        return "mvn"

    def _read_version(self) -> Optional[str]:
        tree = ET.parse(self.descriptor_path)
        root = tree.getroot()
        namespaces = {"mvn": root.tag.split("}")[0].strip("{}")}

        version_tag = root.find(".//mvn:version", namespaces)
        if version_tag is None:
            raise AuroraException("Cannot find the <version> tag!")

        return version_tag.text
