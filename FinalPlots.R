#It seems we have 985 different event types
#Which was unexpected. Need to do some text mining to 
#put these into the same category
#1. Remove the rows with 'summary' in them in the EVTYPE column
valid_ev<- sum_evtype[ which( !grepl("summary", sum_evtype$EVTYPE) ) , ]
#2.get the character collection in a character vector; formulae is repeatition
charcol<- rep(valid_ev$EVTYPE, valid_ev$FATALITIES +( valid_ev$INJURIES*0.5 )   )
tm_wc(charcol)

#3. get the same for Property and Crop damage
charcol<- rep(valid_ev$EVTYPE, valid_ev$CROP_DOL + valid_ev$PROP_DOL   )
tm_wc(charcol)

