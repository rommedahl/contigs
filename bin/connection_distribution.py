import sys
import numpy as np
import bokeh.plotting as bp


#sys.argv is a list of arguments passed via the terminal to the script
#sys.stdin takes input from standard in


def file_reader(filename, limit=0):
    under_limit = 0
    over_limit = 0
    data_list = []
    with open(filename) as file:
        for line in file:
            line_list = line.split(' ')
            value = int(line_list[0])
            print(value)
            if limit and value < limit:
                under_limit += 1
                data_list += [int(line_list[0])]
            elif limit and value >= limit:
                over_limit += 1
    if limit:
        percentage_filtered = over_limit / (under_limit + over_limit)
        print('% filtered {}'.format(percentage_filtered))
    return data_list


if __name__ == '__main__': #ensures that the main run isn't run when this file is importet

    print(sys.argv)
    p1 = bp.figure(title="Overlap frequencies",
                background_fill_color="#E8DDCB")

    # mu, sigma = 0, 0.5
    # measured = np.random.normal(mu, sigma, 1000)

    if '-stdin' in sys.argv:
        data_list = file_reader(sys.stdin, sys.argv[2])
    else:
        data_list = file_reader(sys.argv[1], sys.argv[2])


    measured = np.array(data_list)
    print(measured)



    hist, edges = np.histogram(measured, density=False, bins=100)
    print(hist)
    print(edges)

    #x = np.logspace(0, 4000, 1000)
    p1.quad(top=hist, bottom=0, left=edges[:-1], right=edges[1:],
            fill_color="#036564", line_color="#033649")


    p1.legend.location = "top_left"
    p1.xaxis.axis_label = 'x'
    p1.yaxis.axis_label = 'n.o. vertices'

    bp.show(p1)