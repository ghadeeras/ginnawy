import os
import sys

import build_controller

if __name__ == "__main__":
    controller = build_controller.controller()

    disk = sys.argv[1]
    image = sys.argv[2]

    msxDisk = disk.replace("\\", "/")
    msxImage = image.replace("\\", "/")

    controller.communicate(f"$disk={msxDisk}")
    controller.communicate(f"$image={msxImage}")
    controller.communicate("@create_image")
    controller.wait()