############################################################################
###
### R script for creating LONG data from data provided by MDE
###
############################################################################

### Load packages

require(data.table)
require(SGP)


### Load data

WIDA_MI_Data_LONG <- as.data.table(read.delim("/Users/damian/Documents/Github/WIDA_MI/Data/Base_Files/ELPAtoWIDA.txt", sep="|", colClasses=rep("character", 8)))


### Tidy up data

WIDA_MI_Data_LONG <- WIDA_MI_Data_LONG[GRADE!=""]
WIDA_MI_Data_LONG[,Assessment:=NULL]
WIDA_MI_Data_LONG[,CONTENT_AREA:="READING"]
WIDA_MI_Data_LONG[YEAR=="2011-2012",YEAR:="2011_2012"]
WIDA_MI_Data_LONG[YEAR=="2012-2013",YEAR:="2012_2013"]
WIDA_MI_Data_LONG[YEAR=="2013-2014",YEAR:="2013_2014"]
WIDA_MI_Data_LONG[,SCALE_SCORE:=as.numeric(SCALE_SCORE)]


### Set key

setkey(WIDA_MI_Data_LONG, VALID_CASE, CONTENT_AREA, YEAR, ID)


### Save results

save(WIDA_MI_Data_LONG, file="Data/WIDA_MI_Data_LONG.Rdata")
