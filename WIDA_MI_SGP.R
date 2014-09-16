############################################################################
###
### Script for calculating SGPs for 2014 for WIDA/ACCESS/MI
###
############################################################################

### Load SGP package

require(SGP)


### Load Data

load("Data/WIDA_MI_Data_LONG_2014.Rdata")


### Run analyses

WIDA_MI_SGP <- abcSGP(WIDA_MI_Data_LONG_2014
