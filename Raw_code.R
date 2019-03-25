# #Download file -- Uncomments
# download.file("https://d396qusza40orc.cloudfront.net/repdata%2Fdata%2FStormData.csv.bz2"
#               , destfile="Stormdata.csv.dz2", method="libcurl")
# data<- read.csv("Stormdata.csv")
# 
# #Strip out unnecessay columns and write to to different .csv if needed
# #I've under 2GB ram in my system.
# names_loc_out<- c("COUNTY","COUNTYNAME","STATE","LATITUDE","LONGITUDE","LATITUDE_E","LONGITUDE_","REFNUM")
# names_rem_out<-  c( "STATEOFFIC","ZONENAMES", "REMARKS","REFNUM" )
# names_loc_del<- c("COUNTYNAME","STATE","LATITUDE","LONGITUDE"
#                   ,"LATITUDE_E","LONGITUDE_", "STATEOFFIC","ZONENAMES", "REMARKS")
# addressdim<- data[names_loc_out]
# remarks<-data[names_rem_out]
# df<- data[, !(colnames(data) %in% names_loc_del)  ]
# write.csv(addressdim, file="AddressDim.csv")
# write.csv(remarks, file="Remarks.csv")
# rm(data)
