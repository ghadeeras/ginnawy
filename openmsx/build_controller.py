import os
import sys
from controller import Controller

def controller() -> Controller: 
    return Controller(
        open_msx_path=os.environ["OPENMSX_PATH"],
        macros={
            "setup": [
                "machine $machine",
                "diska insert $disk",
            ],
            "on": [
                "@setup",
                "set default_type_proc type_via_keybuf",
                "set throttle off",
                "set power on",
            ],
            "off": [
                "debug set_watchpoint -once write_mem 0xFFFE {[debug read \"memory\" 0xFFFE] == 0} {exit}",
                "type \\rpoke&amp;HFFFE,0\\r",
            ],
            "tokenize": [
                "type \\rnew\\r",
                "type_from_file $srcFile",
                "type \\rsave\"$basFile\"\\r"
            ],
            "generate": [
                "type \\rnew\\r",
                "type_from_file $asset",
                "type \\rrun\\r",
                "type y"
            ],
            "create_image": [
                "@setup",
                "diskmanipulator savedsk diska $image",
                "exit"
            ]
        },
        variables={
            "machine": "Sanyo_PHC-70FD",
        }
    )
