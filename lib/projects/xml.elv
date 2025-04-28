use str

fn read-version { |descriptor-path|
  var python-version-script = (
    str:join "\n" [
      'import xml.etree.ElementTree as ET'

      'tree = ET.parse("'$descriptor-path'")'
      'root = tree.getroot()'

      'namespaces = {"mvn": root.tag.split("}")[0].strip("{}")}'

      'version_tag = root.find(".//mvn:version", namespaces)'
      'if version_tag is None:'
      '  raise Exception("Cannot find the <version> tag!")'

      'print(version_tag.text)'
    ]
  )

  put ( echo $python-version-script | python3)
}