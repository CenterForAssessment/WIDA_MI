###########################################################################
###                                                                     ###
###     SGP STRAIGHT projections for skip year SGP analyses for 2022    ###
###                                                                     ###
###########################################################################

###   Load packages
require(SGP)
require(SGPmatrices)
require(data.table)

###   Load data
load("Data/WIDA_MI_SGP.Rdata")

###   Load configurations
source("SGP_CONFIG/2022/PART_B/READING.R")

WIDA_MI_2022.config <- READING_2022.config

### Parameters
parallel.config <- list(BACKEND="PARALLEL", WORKERS=list(PERCENTILES=8, BASELINE_PERCENTILES=8, PROJECTIONS=8, LAGGED_PROJECTIONS=8, SGP_SCALE_SCORE_TARGETS=8))

###   Add Baseline matrices to SGPstateData
SGPstateData <- addBaselineMatrices("WIDA_MI", "2020")

#  Establish required meta-data for STRAIGHT projection sequences
SGPstateData[["WIDA_MI"]][["SGP_Configuration"]][["grade.projection.sequence"]] <- list(
    READING=c(0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12))
SGPstateData[["WIDA_MI"]][["SGP_Configuration"]][["content_area.projection.sequence"]] <- list(
    READING=rep("READING", 13))
SGPstateData[["WIDA_MI"]][["SGP_Configuration"]][["max.forward.projection.sequence"]] <- list(
    READING=7)

SGPstateData[["WIDA_MI"]][["SGP_Configuration"]][["sgp.target.scale.scores.merge"]] <- NULL ## Merge targets in next step

###   Run analysis
WIDA_MI_SGP <- abcSGP(
        WIDA_MI_SGP,
        years = "2022",
        steps=c("prepareSGP", "analyzeSGP", "combineSGP"),
        sgp.config=WIDA_MI_2022.config,
        sgp.percentiles=FALSE,
        sgp.projections=FALSE,
        sgp.projections.lagged=FALSE,
        sgp.percentiles.baseline=FALSE,
        sgp.projections.baseline=TRUE,
        sgp.projections.lagged.baseline=FALSE,
        sgp.target.scale.scores=TRUE,
        parallel.config=parallel.config
)

###   Save results
save(WIDA_MI_SGP, file="Data/WIDA_MI_SGP.Rdata")
