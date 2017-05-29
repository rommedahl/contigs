import sys

if __name__ == '__main__':
    arg_list = sys.argv
    filter_by_file = open(arg_list[1])
    filter_by_list = filter_by_file.read().split()
    dataset = open(arg_list[2])
    for line in dataset:
        line = line.rstrip('\n')
        id1, id2, *more = line.split()
        if id1 in filter_by_list and id2 in filter_by_list:
            print(line)
