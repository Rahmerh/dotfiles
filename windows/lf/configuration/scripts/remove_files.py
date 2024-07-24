import sys
import os
import sys
import shutil

def remove_files(paths):
    for path in paths:
        if os.path.isdir(path):
            shutil.rmtree(path)
        else:
            os.remove(path)

if __name__ == '__main__':
    remove_files(sys.argv[1:])
