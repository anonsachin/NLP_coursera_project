library(dplyr)
library(tidyr)
library(tidytext)
data("stop_words")
setwd("~/coursera/Coursera-SwiftKey/final/en_US")
# Reading the blog data
b<-file("./en_US.blogs.txt",open = "r")
blog <- readLines(b)
close(b)
# Reading news data
b<-file("./en_US.news.txt",open = "r")
news<- readLines(b)
close(b)
#Reading twitter data
b<-file("./en_US.twitter.txt",open = "r")
tweet<- readLines(b)
close(b)
tweet_tbl<-tibble(source = rep("tweet",length(tweet)),text = tweet)
news_tbl<-tibble(source = rep("news",length(news)),text = news)
blog_tbl<-tibble(source = rep("blog",length(blog)),text = blog)
comb<-bind_rows(blog_tbl,tweet_tbl,news_tbl)
remove(blog_tbl,tweet_tbl,news_tbl)
remove(b,tweet,blog,news)
combinedtri <- comb %>% unnest_tokens(trigram,text,token="ngrams",n=3)
write.csv(combinedtri,file = "fulltri.csv")
a<-dim(combinedtri)
rm(combinedtri)
# test read algorithm
a<- data.frame()
b<- seq(0,123000,by = 10000)
for (i in b) {
  c<- read.table("testread.csv",nrows = 10000,skip = i)
  a<- rbind(a,c)
}
a<- a[-1,]