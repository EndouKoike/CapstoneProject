library(tm)

load('data_source/dataset.RData')

## Count frequency of worlds
freq <- colSums(as.matrix(dtm))
wordCount <- data.frame(word = names(freq), freq = freq)
wordCount <- wordCount[order(wordCount$freq, decreasing=TRUE),]
rownames(wordCount) <- NULL
rm(freq)


freq1 <-  colSums(as.matrix(Token1))
one_word <- data.frame(word = names(freq1), freq = freq1)
one_word <- one_word[order(one_word$freq, decreasing=TRUE),]
rownames(one_word) <- NULL
rm(freq1)

freq2 <-  colSums(as.matrix(Token2))
two_word <- data.frame(word = names(freq2), freq = freq2)
two_word <- two_word[order(two_word$freq, decreasing=TRUE),]
rownames(two_word) <- NULL
rm(freq2)


freq3 <-  colSums(as.matrix(Token3))
three_word <- data.frame(word = names(freq3), freq = freq3)
three_word <- three_word[order(three_word$freq, decreasing=TRUE),]
rownames(three_word) <- NULL
rm(freq3)


library('ggplot2')

top20 <- head(three_word, 20)
                
p <- ggplot(top20, aes(reorder(word, -freq), freq))
p <- p + geom_bar(stat = 'identity')
p <- p + xlab('Word')
p <- p + ylab('Frequnecy')
p <- p + ggtitle('Top 20 Most Frequent Word')
p <- p + theme(axis.text.x=element_text(angle=45, hjust=1))
p

library('wordcloud')
comparison <- as.matrix(tdm)
colnames(comparison) <- c('blogs', 'news', 'twitter')
comparison.cloud(comparison,max.words=300,random.order=FALSE)

cloud_temp <- as.matrix(tdm)
cloud_temp1 <- sort(rowSums(cloud_temp), decreasing = TRUE)
cloud_temp2 <- data.frame(word = names(cloud_temp1), freq = cloud_temp1)
set.seed(1986)
wordcloud(words = cloud_temp2$word, freq = cloud_temp2$freq, min.freq = 1,
          max.words=300, random.order = FALSE, rot.per = 0.35,
          colors = brewer.pal(8, 'Dark2'))

rm(comparison, cloud_temp, cloud_temp1, cloud_temp2)