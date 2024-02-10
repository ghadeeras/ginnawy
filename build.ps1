[CmdletBinding()]
param (
    [Parameter(Mandatory=$true)][string]$Game
)
Remove-Item -Force -Recurse -Path "$Game\.out"
New-Item -ItemType Directory -Force -Path "$Game\.out\dsk"
Copy-Item -Path "$Game\.lib\*" -Destination "$Game\.out\dsk"
Copy-Item -Path "$Game\assets\*.bin" -Destination "$Game\.out\dsk"
python.exe .\openmsx\tokenize_bas.py "$Game\.out\dsk" "$Game\src"
python.exe .\openmsx\gen_assets.py "$Game\.out\dsk" "$Game\assets"
python.exe .\openmsx\disk_image.py "$Game\.out\dsk" "$Game\.out\floppy.dsk"
