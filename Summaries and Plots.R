#Using sqldf as it brings the results in tabular format by default
library(sqldf)
library(lubridate)
# A new date column added for futher processing
df$DATE<- as.Date( as.character( df$BGN_DATE  ) ,"%m/%d/%Y" )

#The property damage and crop damage COSTS need further processing. 
df$CROP_DOL<- as.numeric( 0)
df$PROP_DOL<- as.numeric( 0)
    #Now give them values accordingly, B, M and K 

df[df$CROPDMGEXP %in% c("B","b"),]$CROP_DOL <- df[df$CROPDMGEXP %in% c("B","b"),]$CROPDMG*1000000000
df[df$CROPDMGEXP %in% c("M","m"),]$CROP_DOL <- df[df$CROPDMGEXP %in% c("M","m"),]$CROPDMG*1000000
df[df$CROPDMGEXP %in% c("K","k"),]$CROP_DOL <- df[df$CROPDMGEXP %in% c("K","k"),]$CROPDMG*1000
df[df$CROPDMGEXP %in% c("H","h"),]$CROP_DOL <- df[df$CROPDMGEXP %in% c("H","h"),]$CROPDMG*100
df[ !(df$CROPDMGEXP %in% c("H","h","M","m","K","k","B","b") ),]$CROP_DOL <- df[!(df$CROPDMGEXP %in% c("H","h","M","m","K","k","B","b") ),]$CROPDMG

df[df$PROPDMGEXP %in% c("B","b"),]$PROP_DOL <- df[df$PROPDMGEXP %in% c("B","b"),]$PROPDMG*1000000000
df[df$PROPDMGEXP %in% c("M","m"),]$PROP_DOL <- df[df$PROPDMGEXP %in% c("M","m"),]$PROPDMG*1000000
df[df$PROPDMGEXP %in% c("K","k"),]$PROP_DOL <- df[df$PROPDMGEXP %in% c("K","k"),]$PROPDMG*1000
df[df$PROPDMGEXP %in% c("H","h"),]$PROP_DOL <- df[df$PROPDMGEXP %in% c("H","h"),]$PROPDMG*100
df[ !(df$PROPDMGEXP %in% c("H","h","M","m","K","k","B","b") ),]$PROP_DOL <- df[!(df$PROPDMGEXP %in% c("H","h","M","m","K","k","B","b") ),]$PROPDMG

#Now we can summarise in dollar amount by event type and event date
sum_date<-sqldf("select DATE,EVTYPE
                ,sum(FATALITIES) as FATALITIES
                ,sum(INJURIES) as INJURIES 
                , sum(PROP_DOL) as PROP_DOL
                , sum(CROP_DOL)  as CROP_DOL
                from df group by 1,2")
sum_date$YEAR<- year(sum_date$DATE)
sum_year<-sqldf("select YEAR ,EVTYPE
                ,sum(FATALITIES) as FATALITIES
                ,sum(INJURIES) as INJURIES 
                , sum(PROP_DOL) as PROP_DOL
                , sum(CROP_DOL)  as CROP_DOL
                from sum_date group by 1,2")
sum_year$EVTYPE<- tolower(trimws(sum_year$EVTYPE, which="both"  ) )
sum_evtype<- sqldf("select EVTYPE
                ,sum(FATALITIES) as FATALITIES
                   ,sum(INJURIES) as INJURIES 
                   , sum(PROP_DOL) as PROP_DOL
                   , sum(CROP_DOL)  as CROP_DOL
                   from sum_year group by 1  ")


