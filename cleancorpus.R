

cleancorpus <- function(corpus){
    library(tm)
    library(stringi)
    
    corpus <- tm_map(corpus, removePunctuation)
    corpus <- tm_map(corpus, content_transformer(tolower))
    corpus <- tm_map(corpus, removeWords, stopwords("en"))
    corpus<- tm_map(corpus, function(x) gsub( "/", " ", gsub( "\\\\", " ", x) ) )
    corpus <- tm_map(corpus, stripWhitespace)
    return(corpus)
}