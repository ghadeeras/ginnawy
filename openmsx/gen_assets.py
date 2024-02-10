import os
import sys

import build_controller

if __name__ == "__main__":
    controller = build_controller.controller()

    disk = sys.argv[1]
    assets = sys.argv[2]

    msxDisk = disk.replace("\\", "/")
    msxAssets = assets.replace("\\", "/") 
    bas_assets = [f for f in os.listdir(assets) if f.upper().endswith(".BAS")]

    controller.communicate(f"$disk={msxDisk}")
    controller.communicate("@on")
    for asset in bas_assets:
        controller.communicate(f"$asset={msxAssets}/{asset}")
        controller.communicate("@generate")
    controller.communicate("@off")
    controller.wait()    