
<!-- README.md is generated from README.Rmd. Please edit that file -->

# bayescomb

Data and code for the paper

> Bryant J, Rittirong J, Aekplakorn W, Mo-suwan L, Nitnara P, [A
> Bayesian approach to combining multiple information sources:
> Estimating and forecasting childhood obesity in
> Thailand](https://doi.org/10.1371/journal.pone.0262047). *PLOS-ONE*.
> 21 January 2022.

| Folder     | Contents                                                                |
|:-----------|:------------------------------------------------------------------------|
| data       | All the data used in the analysis (in the form of tabulations)          |
| shared     | Construction of objects shared by all analyses                          |
| natnhes    | National-level analysis using on the National Health Examination Survey |
| natall     | National-level analysis using multiple data sources                     |
| subnat     | Subnational analysis using multiple data sources                        |
| paper      | Construction of the paper                                               |
| submission | Files submitted to PLOS-ONE                                             |

Within each folder, the R code for doing the analysis is in a folder
called ‘src’ and outputs are in a folder called ‘out’.

The analysis is controlled by makefiles - most folders have their own
makefile, and the makefile in the main directory coordinates everything.
Running

    make

at the command line recreates the entire analysis from the paper,
provided all the required dependencies, such as R packages, are
installed. Running the whole analysis is, however, likely to take
several days.

The main makefile has a parameter called MULT, which controls the number
of iterations. Running

    make MULT=0.001

at the command line recreates the analysis without running the models to
convergence, and should only take a few minutes.

The most reliable way to make sure all the dependencies for the analysis
are present is to use the Dockerfile in combination with an application
called docker.

The parameters for the informative prior described in the paper are
based on a separate analysis of WHO data. The data and code for the WHO
analysis are available in the repository
[bayescombwho](https://github.com/johnrbryant/bayescombwho).
