class AuroraException(Exception):
    def __init__(self, message):
        super().__init__(f"❌{message}")
