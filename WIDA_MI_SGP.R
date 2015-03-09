##########################################################################################
###
### Script for calculating SGPs for 2010-2011, 2011-2012, 2012-2013 for WIDA/ACCESS/MI
###
##########################################################################################

### Load SGP package

require(SGP)
options(error=recover)
options(warn=2)


### Load Data

load("Data/WIDA_MI_Data_LONG.Rdata")


### NULL out SGPstateData

SGPstateData[["WIDA_MI"]][["Assessment_Program_Information"]][["Scale_Change"]] <- NULL
SGPstateData[["WIDA_MI"]][["Achievement"]][["Cutscores"]][["READING.2014"]] <- NULL
SGPstateData[["WIDA_MI"]][["Achievement"]][["Knots_Boundaries"]][["READING.2014"]] <- NULL

### Run analyses

WIDA_MI_SGP <- abcSGP(
		WIDA_MI_Data_LONG,
		steps=c("prepareSGP", "analyzeSGP", "combineSGP", "outputSGP"),
		sgp.percentiles=TRUE,
		sgp.projections=TRUE,
		sgp.projections.lagged=TRUE,
		sgp.percentiles.baseline=FALSE,
		sgp.projections.baseline=FALSE,
		sgp.projections.lagged.baseline=FALSE,
		save.intermediate.results=TRUE,
		parallel.config=list(BACKEND="PARALLEL", WORKERS=list(PERCENTILES=4, PROJECTIONS=4, LAGGED_PROJECTIONS=4, SGP_SCALE_SCORE_TARGETS=4)))


### Save results

save(WIDA_MI_SGP, file="Data/WIDA_MI_SGP.Rdata")
