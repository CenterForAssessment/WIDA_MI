############################################################################
###
### R script for creating LONG data from data provided by MDE
###
############################################################################

### Load packages

require(data.table)


### Load data
load("Data/Base_Files/all`

WIDA_MI_Data_LONG <- as.data.table(read.delim("Data/Base_Files/ELPAtoWIDA2.txt", sep="|", colClasses=rep("character", 8)))


### Tidy up data

WIDA_MI_Data_LONG <- WIDA_MI_Data_LONG[GRADE!=""]
WIDA_MI_Data_LONG[,Assessment:=NULL]
WIDA_MI_Data_LONG[,CONTENT_AREA:="READING"]
WIDA_MI_Data_LONG[YEAR=="2008-2009",YEAR:="2009"]
WIDA_MI_Data_LONG[YEAR=="2009-2010",YEAR:="2010"]
WIDA_MI_Data_LONG[YEAR=="2010-2011",YEAR:="2011"]
WIDA_MI_Data_LONG[YEAR=="2011-2012",YEAR:="2012"]
WIDA_MI_Data_LONG[YEAR=="2012-2013",YEAR:="2013"]
WIDA_MI_Data_LONG[YEAR=="2013-2014",YEAR:="2014"]
WIDA_MI_Data_LONG[,SCALE_SCORE:=as.numeric(SCALE_SCORE)]
WIDA_MI_Data_LONG[,GRADE:=as.character(as.numeric(GRADE))]
WIDA_MI_Data_LONG[YEAR!=2014, ACHIEVEMENT_LEVEL:=paste("MI-ELPA Level", ACHIEVEMENT_LEVEL)]
WIDA_MI_Data_LONG[YEAR==2014, ACHIEVEMENT_LEVEL:=paste("WIDA Level", ACHIEVEMENT_LEVEL)]
WIDA_MI_Data_LONG[ACHIEVEMENT_LEVEL=="MI-ELPA Level " | ACHIEVEMENT_LEVEL=="WIDA Level ", ACHIEVEMENT_LEVEL:="NO SCORE"]
WIDA_MI_Data_LONG[,ACHIEVEMENT_LEVEL:=as.character(ACHIEVEMENT_LEVEL)]

### Create two data sets

WIDA_MI_Data_LONG_2014 <- subset(WIDA_MI_Data_LONG, YEAR=="2014")
WIDA_MI_Data_LONG <- subset(WIDA_MI_Data_LONG, YEAR!="2014")

### Set key

setkey(WIDA_MI_Data_LONG, VALID_CASE, CONTENT_AREA, YEAR, ID)
setkey(WIDA_MI_Data_LONG_2014, VALID_CASE, CONTENT_AREA, YEAR, ID)


### Save results

save(WIDA_MI_Data_LONG, file="Data/WIDA_MI_Data_LONG.Rdata")
save(WIDA_MI_Data_LONG_2014, file="Data/WIDA_MI_Data_LONG_2014.Rdata")
