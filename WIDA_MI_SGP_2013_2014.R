############################################################################
###
### Script for calculating SGPs for 2014 for WIDA/ACCESS/MI
###
############################################################################

### Load SGP package

require(SGP)


### Load Data

load("Data/WIDA_MI_SGP.Rdata")
load("Data/WIDA_MI_Data_LONG_2013_2014.Rdata")


### Run analyses

WIDA_MI_SGP <- updateSGP(
		WIDA_MI_SGP,
		WIDA_MI_Data_LONG_2013_2014,
		steps=c("prepareSGP", "analyzeSGP", "combineSGP", "outputSGP"),
		sgp.percentiles=TRUE,
		sgp.projections=FALSE,
		sgp.projections.lagged=FALSE,
		sgp.percentiles.baseline=FALSE,
		sgp.projections.baseline=FALSE,
		sgp.projections.lagged.baseline=FALSE)


### Save results

#save(WIDA_MI_SGP, file="Data/WIDA_MI_SGP.Rdata")
