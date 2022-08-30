#####################################################################################
###                                                                               ###
###           SGP LAGGED projections for skip year SGP analyses for 2022          ###
###                                                                               ###
#####################################################################################

###   Load packages
require(SGP)
require(SGPmatrices)
require(data.table)

###   Load data
load("Data/WIDA_MI_SGP.Rdata")

###   Load configurations
source("SGP_CONFIG/2022/PART_C/READING.R")

WIDA_MI_2022.config <- READING_2022.config

### Parameters
parallel.config <- list(BACKEND="PARALLEL", WORKERS=list(PERCENTILES=4, BASELINE_PERCENTILES=4, PROJECTIONS=4, LAGGED_PROJECTIONS=4, SGP_SCALE_SCORE_TARGETS=4))

###   Setup SGPstateData with baseline coefficient matrices grade specific projection sequences

###   Add Baseline matrices to SGPstateData and update SGPstateData
SGPstateData <- addBaselineMatrices("WIDA_MI", "2020")
SGPstateData[["WIDA_MI"]][["Growth"]][["System_Type"]] <- "Baseline Referenced"

#  Establish required meta-data for LAGGED projection sequences
SGPstateData[["WIDA_MI"]][["SGP_Configuration"]][["grade.projection.sequence"]] <- list(
    READING_GRADE_0=c(0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12),
    READING_GRADE_1=c(0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12),
    READING_GRADE_2=c(0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12),
    READING_GRADE_3=c(0, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12),
    READING_GRADE_4=c(0, 1, 4, 5, 6, 7, 8, 9, 10, 11, 12),
    READING_GRADE_5=c(0, 1, 2, 5, 6, 7, 8, 9, 10, 11, 12),
    READING_GRADE_6=c(0, 1, 2, 3, 6, 7, 8, 9, 10, 11, 12),
    READING_GRADE_7=c(0, 1, 2, 3, 4, 7, 8, 9, 10, 11, 12),
    READING_GRADE_8=c(0, 1, 2, 3, 4, 5, 8, 9, 10, 11, 12),
    READING_GRADE_9=c(0, 1, 2,  3, 4, 5, 6, 9, 10, 11, 12),
    READING_GRADE_10=c(0, 1, 2, 3, 4, 5, 6, 7, 10, 11, 12),
    READING_GRADE_11=c(0, 1, 2, 3, 4, 5, 6, 7, 8, 11, 12),
    READING_GRADE_12=c(0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 12))
SGPstateData[["WIDA_MI"]][["SGP_Configuration"]][["content_area.projection.sequence"]] <- list(
    READING_GRADE_0=rep("READING", 13),
    READING_GRADE_1=rep("READING", 13),
    READING_GRADE_2=rep("READING", 13),
    READING_GRADE_3=rep("READING", 11),
    READING_GRADE_4=rep("READING", 11),
    READING_GRADE_5=rep("READING", 11),
    READING_GRADE_6=rep("READING", 11),
    READING_GRADE_7=rep("READING", 11),
    READING_GRADE_8=rep("READING", 11),
    READING_GRADE_9=rep("READING", 11),
    READING_GRADE_10=rep("READING", 11),
    READING_GRADE_11=rep("READING", 11),
    READING_GRADE_12=rep("READING", 11))
SGPstateData[["WIDA_MI"]][["SGP_Configuration"]][["max.forward.projection.sequence"]] <- list(
    READING_GRADE_0=7,
    READING_GRADE_1=7,
    READING_GRADE_2=7,
    READING_GRADE_3=7,
    READING_GRADE_4=7,
    READING_GRADE_5=7,
    READING_GRADE_6=7,
    READING_GRADE_7=7,
    READING_GRADE_8=7,
    READING_GRADE_9=7,
    READING_GRADE_10=7,
    READING_GRADE_11=7,
    READING_GRADE_12=7)

### Run analysis
WIDA_MI_SGP <- abcSGP(
        WIDA_MI_SGP,
        years="2022",
        steps=c("prepareSGP", "analyzeSGP", "combineSGP", "outputSGP"),
        sgp.config=WIDA_MI_2022.config,
        sgp.percentiles=FALSE,
        sgp.projections=FALSE,
        sgp.projections.lagged=FALSE,
        sgp.percentiles.baseline=FALSE,
        sgp.projections.baseline=FALSE,
        sgp.projections.lagged.baseline=TRUE,
        sgp.target.scale.scores=TRUE,
        parallel.config=parallel.config
)

###  Save results
save(WIDA_MI_SGP, file="Data/WIDA_MI_SGP.Rdata")
