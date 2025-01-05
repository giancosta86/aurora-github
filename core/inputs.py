from os import getenv
from typing import Union, get_args, get_origin, get_type_hints

from .exceptions import AuroraException


class Input:
    @staticmethod
    def to_snake_case(input_name: str) -> str:
        return input_name.replace("-", "_")

    @staticmethod
    def to_env_var_name(input_name: str) -> str:
        return f"INPUT_{input_name.upper().replace('-', '_')}"

    @staticmethod
    def get(input_name: str) -> str:
        env_var_name = Input.to_env_var_name(input_name)

        input_value = getenv(env_var_name, "")

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
        for input_name, input_type in get_type_hints(type(self)).items():
            optional = get_origin(input_type) == Union and type(None) in get_args(
                input_type
            )

            value_retriever = Input.get if optional else Input.require

            input_value = value_retriever(input_name)

            field_name = Input.to_snake_case(input_name)

            setattr(self, field_name, input_value)
