import sys
import xml.etree.ElementTree as ET

descriptor_path = sys.argv[1]

tree = ET.parse(descriptor_path)

root = tree.getroot()

namespaces = {"mvn": root.tag.split("}")[0].strip("{}")}

version_tag = root.find(".//mvn:version", namespaces)

if version_tag is None:
    raise Exception("Cannot find the <version> tag!")

version = version_tag.text

print(version)