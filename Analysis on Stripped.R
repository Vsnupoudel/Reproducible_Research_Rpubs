 # Important columns giving measurements on damage and fatalities
# FATALITIES, INJURIES, PROPDMG,PROPDMGEXP (k,m,b),CROPDMG,CROPDMGEXP(k,m,b)

# Task 1 - Find what the database is unique on (i.e. primary Key)
# Also exploring data on my Own

dim(df)  # [1] 902297 28
dim( unique( df[c("BGN_DATE","COUNTY","EVTYPE")] ) )   ##[1] 570401  3
dim( unique( df[c("BGN_DATE","BGN_TIME", "COUNTY","EVTYPE")] )) ##871125 4
dim( unique( df[c( "STATEID", "BGN_DATE","BGN_TIME", "COUNTY","EVTYPE")] ) ) ##[1] 873837 5
library(sqldf)
#duplicates on 3 variables
dups<- sqldf(" select BGN_DATE, COUNTY, EVTYPE, count(*) as counts from df group by 1,2,3 having count(*) >1 ")
#max(dups$counts)
#dups[dups$counts==125, ]
dup125<- df[ df$BGN_DATE=="11/11/1995 0:00:00" & df$COUNTY==0 & df$EVTYPE=="HIGH WINDS" , ]
View(head(dup125))

#duplicates on 5 variables
dups<- sqldf(" select STATEID, BGN_DATE,  COUNTY, EVTYPE, count(*) as counts from df group by 1,2,3 having count(*) >1 ")
#max(dups$counts)
#dups[dups$counts==72, ]
dup125<- df[ df$BGN_DATE=="11/11/1995 0:00:00" & df$COUNTY==0 & df$EVTYPE=="HIGH WINDS" & df$STATEID==51 , ]
View(head(dup125))

