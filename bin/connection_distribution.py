import sys
import numpy as np
import bokeh.plotting as bp


#sys.argv is a list of arguments passed via the terminal to the script
#sys.stdin takes input from standard in




if __name__ == '__main__': #ensures that the main run isn't run when this file is importet

    p1 = bp.figure(title="Overlap frequencies",
                background_fill_color="#E8DDCB")

    # mu, sigma = 0, 0.5
    # measured = np.random.normal(mu, sigma, 1000)

    under_limit = 0
    over_limit = 0
    data_list = []
    with open('overlaps.freq.txt') as oft:
        for line in oft:
            line_list = line.split(' ')
            value = int(line_list[0])
            print(value)
            if value < 20:
                under_limit += 1
                data_list += [int(line_list[0])]
            else:
                over_limit += 1

    percentage_filtered = over_limit / (under_limit + over_limit)
    print('% filtered {}'.format(percentage_filtered))

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