from dataclasses import dataclass

from .inputs import InputDto
from .outputs import OutputDto


class Inputs(InputDto):
    scope: str


@dataclass(frozen=True)
class ScopeResult(OutputDto):
    actual_scope: str


def parse_npm_scope(inputs: Inputs) -> ScopeResult:
    if inputs.scope == "<ROOT>":
        print("🫚Root npm scope detected!")
        return ScopeResult(actual_scope="")

    actual_scope = inputs.scope.lstrip("@")

    print(f"🖌️Custom npm scope detected: '{actual_scope}'")

    return ScopeResult(actual_scope=actual_scope)
