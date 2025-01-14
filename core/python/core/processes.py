import subprocess
import sys
from typing import Union


def shell_run(command: Union[str, list[str]], **kwargs) -> subprocess.CompletedProcess:
    print(f"🚀Running shell command: {command}")

    kwargs["shell"] = True

    if not kwargs.get("capture_output"):
        sys.stdout.flush()
        sys.stderr.flush()

    return subprocess.run(command, **kwargs)


def text_run(command: Union[str, list[str]], **kwargs) -> subprocess.CompletedProcess:
    kwargs["text"] = True
    kwargs["capture_output"] = True

    return shell_run(command, **kwargs)
