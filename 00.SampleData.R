options(java.parameters = '-Xmx15g')
## Reading three source txt files
blogs <- readLines('data_source/en_US.blogs.txt', encoding = 'UTF-8')
news <- readLines('data_source/en_US.news.txt', encoding = 'UTF-8')
twitter <- readLines('data_source/en_US.twitter.txt', encoding = 'UTF-8')


## Using rbinom() for creating sampling and save new sample txt files
# set.seed(1986)
size <- 300000

blogs <- blogs[rbinom(size, length(blogs), 0.5)]
news <- news[rbinom(size, length(news), 0.5)]
twitter <- twitter[rbinom(size, length(twitter), 0.5)]


writeLines(blogs, con = 'data_source/sample/blogs.txt', sep = "\n", useBytes = FALSE)
writeLines(news, con = 'data_source/sample/news.txt', sep = "\n", useBytes = FALSE)
writeLines(twitter, con = 'data_source/sample/twitter.txt', sep = "\n", useBytes = FALSE)

rm(blogs, news, twitter, size)