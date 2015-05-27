############################################################################
###
### Script for calculating SGPs for 2014 for WIDA/ACCESS/MI
###
############################################################################

### Load SGP package

require(SGP)


### Load Data

load("Data/WIDA_MI_SGP.Rdata")
load("Data/WIDA_MI_Data_LONG_2014.Rdata")


### Create config for percentiles and 1 projections

READING_2014.config <- list(
        READING.2014 = list(
                sgp.content.areas=rep('READING', 3),
                sgp.projection.baseline.content.areas='READING',
                sgp.panel.years=c('2012', '2013', '2014'),
                sgp.projection.baseline.panel.years='2014',
                sgp.grade.sequences=list(c('0', '1'), c('0', '1', '2'), c('1', '2', '3'), c('2', '3', '4'), c('3', '4', '5'), c('4', '5', '6'), c('5', '6', '7'), c('6', '7', '8'), c('7', '8', '9'), c('8', '9', '10'), c('9', '10', '11'), c('10', '11', '12')),
                sgp.projection.baseline.grade.sequences=list('0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11')))


### Run analyses

WIDA_MI_SGP <- updateSGP(
		WIDA_MI_SGP,
		WIDA_MI_Data_LONG_2014,
		steps=c("prepareSGP", "analyzeSGP", "combineSGP", "outputSGP", "visualizeSGP"),
		sgp.percentiles=TRUE,
		sgp.projections=TRUE,
		sgp.projections.lagged=TRUE,
		sgp.percentiles.baseline=FALSE,
		sgp.projections.baseline=TRUE,
		sgp.projections.lagged.baseline=FALSE,
		sgp.config=READING_2014.config,
		save.intermediate.results=FALSE,
		sgp.target.scale.scores=TRUE,
		plot.types=c("studentGrowthPlot"),
#		plot.types=c("studentGrowthPlot", "growthAchievementPlot"),
		parallel.config=list(BACKEND="PARALLEL", WORKERS=list(PERCENTILES=4, PROJECTIONS=4, LAGGED_PROJECTIONS=4, SGP_SCALE_SCORE_TARGETS=4, GA_PLOTS=1, SG_PLOTS=1)))


### Save results

save(WIDA_MI_SGP, file="Data/WIDA_MI_SGP.Rdata")
