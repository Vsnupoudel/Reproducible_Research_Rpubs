tm_wc <- function(charcol){
library(tm)
library(stringi)
library(wordcloud)
col<- SimpleCorpus( VectorSource(charcol) )
#run cleaning
source("cleancorpus.R")
col<- cleancorpus(col)
dtm <- DocumentTermMatrix(col)
dtm2 <- as.matrix(dtm)
frequency <- colSums(dtm2)
frequency <- sort(frequency, decreasing=TRUE)
##names(frequency)

#Now use the frequency to make a WORDCLOUD
freqdf<- data.frame( occur=frequency , word= names(frequency))
rownames(freqdf)<-NULL
wordcloud(word=freqdf$word, freq=freqdf$occur, max.words=50 )

}