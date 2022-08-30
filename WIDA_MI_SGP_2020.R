#################################################################################
###                                                                           ###
###   WIDA_MI Learning Loss Analyses -- 2020 Baseline Growth Percentiles      ###
###                                                                           ###
#################################################################################

###   Load packages
require(SGP)
require(data.table)

###   Load data
load("Data/WIDA_MI_SGP.Rdata")
load("Data/WIDA_MI_Data_LONG_2020.Rdata")

###   Add baseline matrices to SGPstateData
SGPstateData <- SGPmatrices::addBaselineMatrices("WIDA_MI", "2020")

### Parameters
parallel.config <- list(BACKEND="PARALLEL", WORKERS=list(PERCENTILES=12, BASELINE_PERCENTILES=12, PROJECTIONS=12, LAGGED_PROJECTIONS=12, SGP_SCALE_SCORE_TARGETS=12))

###   Read in BASELINE percentiles configuration scripts and combine
source("SGP_CONFIG/2020/READING.R")

WIDA_MI_2020_Baseline_Config <- READING.2020.config


#####
###   Run BASELINE SGP analysis for consecutive year
###   create new WIDA_MI_SGP object with historical data
#####

WIDA_MI_SGP <- updateSGP(
        what_sgp_object = WIDA_MI_SGP,
        with_sgp_data_LONG = WIDA_MI_Data_LONG_2020,
        steps = c("prepareSGP", "analyzeSGP", "combineSGP", "outputSGP"),
        sgp.config = WIDA_MI_2020_Baseline_Config,
        sgp.percentiles = TRUE,
        sgp.projections = TRUE,
        sgp.projections.lagged = TRUE,
        sgp.percentiles.baseline = TRUE,
        sgp.projections.baseline = TRUE,
        sgp.projections.lagged.baseline = TRUE,
        save.intermediate.results = FALSE,
        parallel.config = parallel.config
)

###   Save results
#save(WIDA_MI_SGP, file="Data/WIDA_MI_SGP.Rdata")
