############################################################
###
### Data prep for 2021
###
############################################################

### Load packages
require(data.table)

### Load data
load("Data/Base_Files/all_wida.Rdata")

### Subset and prep data 
WIDA_MI_Data_LONG_2021 <- all_wida[YEAR == "2021"]
WIDA_MI_Data_LONG_2021[,ID:=as.character(ID)]
WIDA_MI_Data_LONG_2021[,GRADE:=as.character(GRADE)]
WIDA_MI_Data_LONG_2021[,SCALE_SCORE:=as.numeric(SCALE_SCORE)]

### setkey and save results
setkey(WIDA_MI_Data_LONG_2021, VALID_CASE, CONTENT_AREA, YEAR, GRADE, ID)
save(WIDA_MI_Data_LONG_2021, file="Data/WIDA_MI_Data_LONG_2021.Rdata")


