############################################################
###
### Data prep for 2020
###
############################################################

### Load packages
require(data.table)

### Load data
load("Data/Base_Files/all_wida.Rdata")

### Subset and prep data 
WIDA_MI_Data_LONG_2020 <- all_wida[YEAR == "2020"]
WIDA_MI_Data_LONG_2020[,ID:=as.character(ID)]
WIDA_MI_Data_LONG_2020[,GRADE:=as.character(GRADE)]
WIDA_MI_Data_LONG_2020[,SCALE_SCORE:=as.numeric(SCALE_SCORE)]

### setkey and save results
setkey(WIDA_MI_Data_LONG_2020, VALID_CASE, CONTENT_AREA, YEAR, GRADE, ID)
save(WIDA_MI_Data_LONG_2020, file="Data/WIDA_MI_Data_LONG_2020.Rdata")


