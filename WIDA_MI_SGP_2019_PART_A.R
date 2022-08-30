#################################################################################
###                                                                           ###
###       WIDA_MI -- Create Baseline Matrices                                 ###
###                                                                           ###
#################################################################################

### Load necessary packages
require(SGP)
require(data.table)

###   Load the results data from the 'official' 2019 SGP analyses
load("Data/WIDA_MI_Data_LONG.Rdata")

###   Read in Baseline SGP Configuration Scripts and Combine
source("SGP_CONFIG/2019/BASELINE/Matrices/READING.R")

WIDA_MI_BASELINE_CONFIG <- READING_BASELINE.config

###
###   Create Baseline Matrices

WIDA_MI_SGP <- prepareSGP(WIDA_MI_Data_LONG, create.additional.variables=FALSE)

WIDA_MI_Baseline_Matrices <- baselineSGP(
				WIDA_MI_SGP,
				sgp.baseline.config=WIDA_MI_BASELINE_CONFIG,
				return.matrices.only=TRUE,
				calculate.baseline.sgps=FALSE,
				goodness.of.fit.print=FALSE,
				parallel.config = list(
					BACKEND="PARALLEL", WORKERS=list(TAUS=8))
)

###   Save results
save(WIDA_MI_Baseline_Matrices, file="Data/WIDA_MI_Baseline_Matrices.Rdata")