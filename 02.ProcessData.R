library(tm)
options(java.parameters = '-Xmx15g')
library(RWeka)
options(mc.cores = 1)
library(stringr)


## Load Corpus
load('data_source/Corpus.RData')


## Load profanity.csv and make custom functions for data cleansing
# https://github.com/shutterstock/List-of-Dirty-Naughty-Obscene-and-Otherwise-Bad-Words/
profanity <- readLines('data_source/profanity.csv', encoding = 'UTF-8')
nonASCII <- function(x) iconv(x, 'latin1', 'ASCII', '')
removeURL <- function(x) gsub('www[[:alnum:]]*.*|htt[[:alnum:]]*.*', '', x)


## Data cleansing
Corpus <- tm_map(Corpus, content_transformer(nonASCII))
Corpus <- tm_map(Corpus, content_transformer(tolower))
Corpus <- tm_map(Corpus, content_transformer(removeURL))
Corpus <- tm_map(Corpus, removePunctuation) 
Corpus <- tm_map(Corpus, removeNumbers)
Corpus <- tm_map(Corpus, removeWords, profanity)
Corpus <- tm_map(Corpus, stripWhitespace)

rm(profanity, nonASCII, removeURL)


## Create Ngrams
Tokenizer <- function(x) NGramTokenizer(x, Weka_control(min = 2, max = 2))
Bigram <- removeSparseTerms(DocumentTermMatrix(Corpus,
                control = list(weighting = weightSMART, tokenize = Tokenizer)), .1)

Tokenizer <- function(x) NGramTokenizer(x, Weka_control(min = 3, max = 3))
Trigram <- removeSparseTerms(DocumentTermMatrix(Corpus,
                control = list(weighting = weightSMART, tokenize = Tokenizer)), .1)

Tokenizer <- function(x) NGramTokenizer(x, Weka_control(min = 4, max = 4))
Quadrigram <- removeSparseTerms(DocumentTermMatrix(Corpus,
                control = list(weighting = weightSMART, tokenize = Tokenizer)), .1)

rm(Tokenizer)


## Convert Ngrams to data frames sorted descending
freq2 <- colSums(as.matrix(Bigram))
Bigram <- data.frame(sentence = names(freq2), freq = freq2)
Bigram <- Bigram[order(Bigram$freq, decreasing = TRUE),]
rownames(Bigram) <- NULL
rm(freq2)

freq3 <- colSums(as.matrix(Trigram))
Trigram <- data.frame(sentence = names(freq3), freq = freq3)
Trigram <- Trigram[order(Trigram$freq, decreasing = TRUE),]
rownames(Trigram) <- NULL
rm(freq3)

freq4 <-  colSums(as.matrix(Quadrigram))
Quadrigram <- data.frame(sentence = names(freq4), freq = freq4)
Quadrigram <- Quadrigram[order(Quadrigram$freq, decreasing = TRUE),]
rownames(Quadrigram) <- NULL
rm(freq4)


## Prepare Ngrams for text prediction
Bigram$x1 <- word(Bigram$sentence, 1)
Bigram$y <- word(Bigram$sentence, -1)

Trigram$x1x2 <- word(Trigram$sentence, 1, 2)
Trigram$y <- word(Trigram$sentence, -1)

Quadrigram$x1x2x3 <- word(Quadrigram$sentence, 1, 3)
Quadrigram$y <- word(Quadrigram$sentence, -1)


## Save and remove objects
save(Bigram, Trigram, Quadrigram, file = 'data_source/Dataset.RData')
rm(Corpus, Bigram, Trigram, Quadrigram)