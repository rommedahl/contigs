import os
import sys

x, dir = sys.argv
l = os.listdir(dir) #ooops beware file directory

total_diameter = 0
total_size = 0
for f in l:
    if f != '.DS_Store':
        try:
            f = open(f)
            f.readline()
            d = int(f.readline())
            s = int(f.readline())
            f.close()
            total_diameter += d
            total_size += s
        except ValueError:
            pass

print(total_diameter, total_size)

