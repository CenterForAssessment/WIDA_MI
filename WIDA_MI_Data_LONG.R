############################################################
###
### Data prep for 2019
###
############################################################

### Load packages
require(data.table)

### Load data
load("Data/Base_Files/all_wida.Rdata")

### Subset and prep data 
WIDA_MI_Data_LONG <- all_wida[YEAR <= "2019"]
WIDA_MI_Data_LONG[,ID:=as.character(ID)]
WIDA_MI_Data_LONG[,GRADE:=as.character(GRADE)]
WIDA_MI_Data_LONG[,SCALE_SCORE:=as.numeric(SCALE_SCORE)]

### setkey and save results
setkey(WIDA_MI_Data_LONG, VALID_CASE, CONTENT_AREA, YEAR, GRADE, ID)
save(WIDA_MI_Data_LONG, file="Data/WIDA_MI_Data_LONG.Rdata")


