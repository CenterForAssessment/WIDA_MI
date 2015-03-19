##########################################################################################
###
### Script for calculating SGPs for 2010-2011, 2011-2012, 2012-2013 for MI-ELPA
###
##########################################################################################

### Load SGP package

require(SGP)
options(error=recover)
options(warn=2)


### Load Data

load("Data/WIDA_MI_Data_LONG.Rdata")


### NULL out SGPstateData stuff associated with 2014 data and assessment transition (hasn't happened yet when these analyses would have originally happened)

SGPstateData[["WIDA_MI"]][["Assessment_Program_Information"]][["Scale_Change"]] <- NULL
SGPstateData[["WIDA_MI"]][["Achievement"]][["Cutscores"]][["READING.2014"]] <- NULL
SGPstateData[["WIDA_MI"]][["Achievement"]][["Knots_Boundaries"]][["READING.2014"]] <- NULL
SGPstateData[["WIDA_MI"]][["Assessment_Program_Information"]][["Assessment_Transition"]] <- NULL
SGPstateData[["WIDA_MI"]][["Assessment_Program_Information"]][["Assessment_Abbreviation"]] <- "MI-ELPA"
SGPstateData[["WIDA_MI"]][["Achievement"]][["Levels"]] <- list(
        Labels=c("MI-ELPA Level 1", "MI-ELPA Level 2", "MI-ELPA Level 3", "MI-ELPA Level 4", "MI-ELPA Level 5", "NO SCORE"),
        Proficient=c("Not Proficient","Not Proficient","Not Proficient","Proficient","Proficient",NA))
SGPstateData[["WIDA_MI"]][["Student_Report_Information"]][["Achievement_Level_Labels"]] <- list(
	"MI-ELPA Level 1"="MI-ELPA L1",
	"MI-ELPA Level 2"="MI-ELPA L2",
	"MI-ELPA Level 3"="MI-ELPA L3",
	"MI-ELPA Level 4"="MI-ELPA L4",
	"MI-ELPA Level 5"="MI-ELPA L5")
SGPstateData[["WIDA_MI"]][["SGP_Configuration"]][["sgPlot.fan.condition"]] <- "head(Achievement_Levels, 1) %in% paste('Level', 1:3)"


### Run analyses

WIDA_MI_SGP <- abcSGP(
		WIDA_MI_Data_LONG,
		steps=c("prepareSGP", "analyzeSGP", "combineSGP", "visualizeSGP", "outputSGP"),
		sgp.percentiles=TRUE,
		sgp.projections=TRUE,
		sgp.projections.lagged=TRUE,
		sgp.percentiles.baseline=FALSE,
		sgp.projections.baseline=FALSE,
		sgp.projections.lagged.baseline=FALSE,
		save.intermediate.results=TRUE,
		sgp.target.scale.scores=TRUE,
		plot.types=c("growthAchievementPlot", "studentGrowthPlot"),
		sgPlot.demo.report=TRUE,
		parallel.config=list(BACKEND="PARALLEL", WORKERS=list(PERCENTILES=4, PROJECTIONS=4, LAGGED_PROJECTIONS=4, SGP_SCALE_SCORE_TARGETS=4, GA_PLOTS=1, SG_PLOTS=1)))


### Save results

save(WIDA_MI_SGP, file="Data/WIDA_MI_SGP.Rdata")
