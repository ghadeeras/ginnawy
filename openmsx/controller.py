import subprocess as sp
import time

class Controller:

    def __init__(
        self,
        open_msx_path: str,
        macros: dict[str, list[str]] | None = None,
        variables: dict[str, str] | None = None
    ):
        self.process = sp.Popen(
            args=[f"{open_msx_path}\\openmsx", "-control", "stdio"],
            stdin=sp.PIPE, stdout=sp.PIPE, stderr=sp.PIPE,
            text=True
        )
        self.macros = macros if macros is not None else {}
        self.variables = variables if vars is not None else {}

    def terminate(self):
        self.process.terminate()

    def wait(self):
        self.process.stdin.close()
        self.process.wait()

    def send(self, message: str):
        command = f"<command>{message}</command>\n"
        self.process.stdin.write(command)
        self.process.stdin.flush()

    def receive(self) -> str:
        message = self.process.stdout.readline().strip()
        return message

    def communicate(self, message: str) -> str:
        if message.startswith("@") and message[1:] in self.macros:
            messages = self.macros[message[1:]]
            responses = [m + " => " + self.communicate(m) for m in messages]
            return " | ".join(responses)
        elif message.startswith("$") and "=" in message:
            [var, val] = [s.strip() for s in message[1:].split("=", 1)]
            self.variables[var] = val
            return f"set {var}={val}"
        else:
            for var in self.variables:
                message = message.replace("$" + var, self.variables[var])
            self.send(message)
            return self.receive()

    def interact(self):
        print("Session Start")
        response = ""
        message = input()
        while message != ".":
            response = self.communicate(message).strip()
            print("Response: ", response)
            if response == "</openmsx-output>":
                break
            message = input()
        print("Session End")
