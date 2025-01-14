import re
from dataclasses import dataclass
from os import getenv
from pathlib import Path

from .exceptions import AuroraException
from .outputs import OutputDto

leading_v = re.compile("^v")


@dataclass(frozen=True)
class BranchVersionInfo(OutputDto):
    branch: str
    version: str
    escaped_version: str
    major: str


def detect_branch_version_info() -> BranchVersionInfo:
    head_ref = getenv("GITHUB_HEAD_REF")
    ref = getenv("GITHUB_REF")

    branch = head_ref if head_ref else ref
    if not branch:
        raise AuroraException("Cannot detect the branch!")

    print(f"🌲Current Git branch: '{branch}'")

    version = leading_v.sub("", Path(branch).name)
    print(f"🦋Detected version: '{version}'")

    escaped_version = re.escape(version)
    print(f"🧵Escaped version: '{escaped_version}'")

    major = version.split(".")[0].split("-")[0].split("+")[0]

    return BranchVersionInfo(
        branch=branch, version=version, escaped_version=escaped_version, major=major
    )
