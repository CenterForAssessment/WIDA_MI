#############################################################################################
###                                                                                       ###
###            Skip-year SGP Configurations for 2018_2019 READING subjects                ###
###                                                                                       ###
#############################################################################################

READING.2018_2019.config <- list(
	READING.2018_2019 = list(
		sgp.content.areas=rep("READING", 3),
		sgp.panel.years=c("2017", "2018", "2019"),
		sgp.grade.sequences=list(c(0:1),c(0:2),c(1:3),c(2:4), c(3:5),c(4:6),c(5:7),c(6:8),c(7:9), c(8:10), c(9:11), c(10:12))),
		sgp.norm.group.preference=1)

READING.2018_2019_SKIP_YEAR.config <- list(
	READING.2018_2019 = list(
		sgp.content.areas=rep("READING", 3),
		sgp.panel.years=c("2016", "2017", "2019"),
  	sgp.grade.sequences=list(c(0,2),c(0,1,3),c(1,2,4), c(2,3,5),c(3,4,6),c(4,5,7),c(5,6,8),c(6,7,9), c(7,8,10), c(8,9,11), c(9,10,12)))
)

READING.2018_2019_SKIP_2_YEAR.config <- list(
	READING.2018_2019 = list(
		sgp.content.areas=rep("READING", 3),
		sgp.panel.years=c("2015", "2016", "2019"),
		sgp.grade.sequences=list(c(0,3),c(0,1,4), c(1,2,5),c(2,3,6),c(3,4,7),c(4,5,8),c(5,6,9), c(6,7,10), c(7,8,11), c(8,9,12)))
)