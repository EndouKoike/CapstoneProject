library(tm)   
options(java.parameters = '-Xmx15g')

## Create Corpus
repo <- 'data_source'
reposample <- 'data_source/sample'

Corpus <- VCorpus(DirSource(reposample, pattern = '.txt', encoding = 'UTF-8'),
                   readerControl = list(language = 'en'))

## Save corpus and remove objects
save(Corpus, file = 'data_source/Corpus.RData')
rm(repo,reposample, Corpus)