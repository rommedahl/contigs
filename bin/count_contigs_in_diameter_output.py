import os

l = os.listdir('/Users/walter/TestPartitioner') #ooops beware file directory

total_diameter = 0
total_size = 0
for f in l:
    if f != '.DS_Store':
        try:
            f = open(f)
            d = int(f.readline())
            s = int(f.readline())
            f.close()
            total_diameter += d
            total_size += s
        except ValueError:
            pass

print(total_diameter, total_size)

