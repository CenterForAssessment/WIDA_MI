#################################################################################
###                                                                           ###
###     WIDA Michigan Learning Loss Analyses -- Create Baseline Matrices      ###
###                                                                           ###
#################################################################################

### Load necessary packages
setwd("/home/ec2-user/SGP/WIDA/GAC10")
#update.packages(ask=FALSE) 
devtools::install_github("centerforassessment/SGP")
#devtools::install_github("centerforassessment/SGPmatrices")
require(SGP)
#require(SGPmatrices)
require(data.table)

###   Load the results data from the 2022 Baseline 2019 SGP analyses 
load("all_wida.Rdata") 

WIDA_MI_SGP_LONG_Data=data.table(all_wida)
head(WIDA_MI_SGP_LONG_Data)

### NULL out existing baseline matrices (that never get used anyway)
SGPstateData[["WIDA_MI"]][["Baseline_splineMatrix"]] <- NULL

#NULL out from grade issues during transition in 2014
SGPstateData[['WIDA_MI']][['Assessment_Program_Information']][['Scale_Change']] <- NULL

###   Read in Baseline SGP Configuration Scripts and Combine
source("/home/ec2-user/SGP/WIDA/SGP_CONFIG/2018_2019/Baseline/Matrices/READING.R")

WIDA_MI_BASELINE_CONFIG <- READING_BASELINE.config

###   Create Baseline Matrices
WIDA_MI_SGP <- prepareSGP(WIDA_MI_SGP_LONG_Data, create.additional.variables=FALSE)

WIDA_MI_Baseline_Matrices <- baselineSGP(
  sgp_object = WIDA_MI_SGP,
  sgp.baseline.config=WIDA_MI_BASELINE_CONFIG,
  return.matrices.only=TRUE,
  calculate.baseline.sgps=FALSE,
  goodness.of.fit.print=FALSE,
  parallel.config = list(
    BACKEND="PARALLEL", WORKERS=list(TAUS=4))
)

###   Save results
save(WIDA_MI_Baseline_Matrices, file="Data/WIDA_MI_Baseline_Matrices.Rdata", compress="xz")
