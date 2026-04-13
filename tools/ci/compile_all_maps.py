#!/usr/bin/env python

import os
import sys

folders = ["_maps/templates", "_maps/matthios_tomb", "_maps/kalypso", "_maps/map_files"]

excluded_dirs = [
    "_maps/map_files/kaizoku/stonehamlet",
]

generated = "_maps/templates.dm"

template_filenames = []

def find_dm(path):
    L = []
    for dirpath, dirnames, filenames in os.walk(path):
        normalized_dir = dirpath.replace("\\", "/")
        if any(normalized_dir.startswith(excluded) for excluded in excluded_dirs):
            continue
        for name in filenames:
            if name.endswith(".dmm") and "backup" not in name.lower():
                s = os.path.join(dirpath, name)
                s = s.replace("_maps/","")
                L.append(s)
    return L

for folder in folders:
    template_filenames.extend(find_dm(folder))

with open(generated, 'w') as f:
    for template in template_filenames:
        f.write('''#include "{}"\n'''.format(template))

