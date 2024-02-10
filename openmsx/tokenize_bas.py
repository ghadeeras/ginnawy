import os
import sys

import build_controller

if __name__ == "__main__":
    controller = build_controller.controller()

    disk = sys.argv[1]
    src = sys.argv[2]

    msxDisk = disk.replace("\\", "/")
    msxSrc = src.replace("\\", "/")
    bas_files = [f for f in os.listdir(src) if f.upper().endswith(".BAS")]

    controller.communicate(f"$disk={msxDisk}")
    controller.communicate("@on")
    for file in bas_files:
        controller.communicate(f"$srcFile={msxSrc}/{file}")
        controller.communicate(f"$basFile={file}")
        controller.communicate("@tokenize")
    controller.communicate("@off")
    controller.wait()