#################################################################################
###                                                                           ###
###   WIDA_MI Learning Loss Analyses -- 2019 Baseline Growth Percentiles      ###
###                                                                           ###
#################################################################################

###   Load packages
require(SGP)
require(data.table)

###   Load data
load("Data/WIDA_MI_Data_LONG.Rdata")

###   Add baseline matrices to SGPstateData
SGPstateData <- SGPmatrices::addBaselineMatrices("WIDA_MI", "2020")

### Parameters
parallel.config <- list(BACKEND="PARALLEL", WORKERS=list(PERCENTILES=12, BASELINE_PERCENTILES=12, PROJECTIONS=12, LAGGED_PROJECTIONS=12, SGP_SCALE_SCORE_TARGETS=12))

###   Read in BASELINE percentiles configuration scripts and combine
source("SGP_CONFIG/2019/BASELINE/Percentiles/READING.R")

WIDA_MI_2019_Baseline_Config <- READING.2019.config
WIDA_MI_2019_Baseline_Config_SKIP_YEAR <-READING.2019_SKIP_YEAR.config
WIDA_MI_2019_Baseline_Config_SKIP_2_YEAR <-READING.2019_SKIP_2_YEAR.config


#####
###   Run BASELINE SGP analysis for SKIP_2_YEAR (two-year skip) 
###   create new WIDA_MI_SGP object with historical data
#####

WIDA_MI_SGP <- abcSGP(
        sgp_object = WIDA_MI_Data_LONG,
        steps = c("prepareSGP", "analyzeSGP", "combineSGP"),
        sgp.config = WIDA_MI_2019_Baseline_Config_SKIP_2_YEAR,
        sgp.percentiles = FALSE,
        sgp.projections = FALSE,
        sgp.projections.lagged = FALSE,
        sgp.percentiles.baseline = TRUE,  #  Skip 2 year SGPs for 2022 comparisons
        sgp.projections.baseline = FALSE, #  Calculated in last step
        sgp.projections.lagged.baseline = FALSE,
        save.intermediate.results = FALSE,
        parallel.config = parallel.config
)

baseline.names <- grep("BASELINE", names(WIDA_MI_SGP@Data), value = TRUE)
setnames(WIDA_MI_SGP@Data, baseline.names, paste0(baseline.names, "_SKIP_2_YEAR"))

sgps.2019 <- grep(".2019.BASELINE", names(WIDA_MI_SGP@SGP[["SGPercentiles"]]))
names(WIDA_MI_SGP@SGP[["SGPercentiles"]])[sgps.2019] <- gsub(".2019.BASELINE", ".2019.BASELINE.SKIP_2_YEAR", names(WIDA_MI_SGP@SGP[["SGPercentiles"]])[sgps.2019])

#####
###   Run BASELINE SGP analysis for SKIP_YEAR (one-year skip) 
###   create new WIDA_MI_SGP object with historical data
#####

WIDA_MI_SGP <- abcSGP(
        sgp_object = WIDA_MI_SGP,
        steps = c("prepareSGP", "analyzeSGP", "combineSGP"),
        sgp.config = WIDA_MI_2019_Baseline_Config_SKIP_YEAR,
        sgp.percentiles = FALSE,
        sgp.projections = FALSE,
        sgp.projections.lagged = FALSE,
        sgp.percentiles.baseline = TRUE,  #  Skip year SGPs for 2021 comparisons
        sgp.projections.baseline = FALSE, #  Calculated in last step
        sgp.projections.lagged.baseline = FALSE,
        save.intermediate.results = FALSE,
        parallel.config = parallel.config 
)

baseline.names <- setdiff(grep("BASELINE", names(WIDA_MI_SGP@Data), value = TRUE), grep("SKIP_2_YEAR", names(WIDA_MI_SGP@Data), value = TRUE))
setnames(WIDA_MI_SGP@Data, baseline.names, paste0(baseline.names, "_SKIP_YEAR"))

sgps.2019 <- grep(".2019.BASELINE", names(WIDA_MI_SGP@SGP[["SGPercentiles"]]))
names(WIDA_MI_SGP@SGP[["SGPercentiles"]])[sgps.2019] <- gsub(".2019.BASELINE", ".2019.BASELINE.SKIP_YEAR", names(WIDA_MI_SGP@SGP[["SGPercentiles"]])[sgps.2019])

#####
###   Run BASELINE SGP analysis for consecutive year
###   create new WIDA_MI_SGP object with historical data
#####

WIDA_MI_SGP <- abcSGP(
        sgp_object = WIDA_MI_SGP,
        steps = c("prepareSGP", "analyzeSGP", "combineSGP", "outputSGP"),
        sgp.config = WIDA_MI_2019_Baseline_Config,
        sgp.percentiles = FALSE,
        sgp.projections = FALSE,
        sgp.projections.lagged = FALSE,
        sgp.percentiles.baseline = TRUE,  #  Consecutive year SGPs for 2021 comparisons
        sgp.projections.baseline = TRUE, # 
        sgp.projections.lagged.baseline = TRUE,
        save.intermediate.results = FALSE,
        parallel.config = parallel.config
)

###   Save results
save(WIDA_MI_SGP, file="Data/WIDA_MI_SGP.Rdata")
