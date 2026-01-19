#!/usr/bin/env python3
import subprocess
import sys

BUILTIN = "89217536-D72C-4C55-2AF0-E3700A4C818B"
ASUS    = "893CE3C0-1BC3-2ABB-B06C-7E22437CCE35"
HP      = "7903AC22-077A-1D7D-7972-58B353D615EB"

CMD = [
    "displayplacer",
    f"id:{BUILTIN}+{ASUS}+{HP} res:1792x1120 hz:59 color_depth:8 scaling:on origin:(0,0) degree:0",
]

p = subprocess.run(CMD, text=True, capture_output=True)
if p.returncode != 0:
    print(p.stderr.strip() or p.stdout.strip())
    sys.exit(p.returncode)
