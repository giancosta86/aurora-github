from os import getenv
from typing import Union, get_args, get_origin, get_type_hints

from .exceptions import AuroraException


class Input:
    @staticmethod
    def get(input_name: str) -> str:
        source_env_var = f"INPUT_{input_name.upper().replace('-', '_')}"

        input_value = getenv(source_env_var, "")

        print(f"📥{input_name}: '{input_value}'")

        return input_value

    @staticmethod
    def require(input_name: str) -> str:
        value = Input.get(input_name)

        if not value:
            raise AuroraException(f"Missing action input: '{input_name}'!")

        return value


class InputDto:
    @classmethod
    def from_env(cls):
        instance = cls()
        instance.set_fields_from_env()
        return instance

    def set_fields_from_env(self) -> None:
        for field_name, field_type in get_type_hints(type(self)).items():
            optional = get_origin(field_type) == Union and type(None) in get_args(
                field_type
            )

            value_retriever = Input.get if optional else Input.require

            input_value = value_retriever(field_name)

            setattr(self, field_name, input_value)
