import sys
import numpy as np
import bokeh.plotting as bp


#sys.argv is a list of arguments passed via the terminal to the script





if __name__ == '__main__': #ensures that the main run isn't run when this file is importet

    p1 = bp.figure(title="Overlap frequencies",
                background_fill_color="#E8DDCB")

    # mu, sigma = 0, 0.5
    # measured = np.random.normal(mu, sigma, 1000)

    data_list = []
    with open('overlaps.freq.txt') as oft:
        for line in oft:
            line_list = line.split(' ')
            value = int(line_list[0])
            if value > 100:
                data_list += [int(line_list[0])]

    measured = np.array(data_list)
    print(measured)

    hist, edges = np.histogram(measured, density=True, bins=100)

    # x = np.linspace(-2, 2, 1000)
    # pdf = 1/(sigma * np.sqrt(2*np.pi)) * np.exp(-(x-mu)**2 / (2*sigma**2))
    # cdf = (1+scipy.special.erf((x-mu)/np.sqrt(2*sigma**2)))/2

    p1.quad(top=hist, bottom=0, left=edges[:-1], right=edges[1:],
            fill_color="#036564", line_color="#033649")
    # p1.line(x, pdf, line_color="#D95B43", line_width=8, alpha=0.7, legend="PDF")
    # p1.line(x, cdf, line_color="white", line_width=2, alpha=0.7, legend="CDF")


    p1.legend.location = "top_left"
    p1.xaxis.axis_label = 'x'
    p1.yaxis.axis_label = 'Pr(x)'

    # show(gridplot(p1, ncols=2, plot_width=400, plot_height=400, toolbar_location=None))

    bp.show(p1)