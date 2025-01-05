import re
from os import getenv
from typing import Callable, Optional, get_type_hints

from .exceptions import AuroraException

UNDERSCORE_REPLACEMENT_REGEX = re.compile(r"_([^_])")


class OutputDto:
    def write_to_github_output(self, source_fields: Optional[list[str]] = None) -> None:
        self._write_to_github_context(
            "GITHUB_OUTPUT",
            lambda source_field: source_field.replace("_", "-"),
            source_fields,
        )

    def write_to_github_env(self, source_fields: Optional[list[str]] = None) -> None:
        self._write_to_github_context(
            "GITHUB_ENV",
            lambda source_field: re.sub(
                UNDERSCORE_REPLACEMENT_REGEX, lambda m: m.group(1).upper(), source_field
            ),
            source_fields,
        )

    def _write_to_github_context(
        self,
        context_name: str,
        to_context_field_name_converter: Callable[[str], str],
        source_fields: Optional[list[str]],
    ) -> None:
        actual_source_fields = (
            source_fields if source_fields else get_type_hints(type(self)).keys()
        )
        print(f"🔎Actual source fields: {actual_source_fields}")

        env_file = getenv(context_name)
        if not env_file:
            raise AuroraException(
                f"Cannot find a file associated with the '{context_name}' context"
            )

        print(f"✒️Writing fields in the '{context_name}' context...")
        with open(env_file, "a") as github_context:
            for source_field in actual_source_fields:
                context_field_name = to_context_field_name_converter(source_field)
                context_field_value = getattr(self, source_field)

                print(
                    f"📤Setting context name '{context_field_name}' = '{context_field_value}'"
                )

                github_context.write(f"{context_field_name}={context_field_value}\n")
        print(f"✒️✒️✒️")
