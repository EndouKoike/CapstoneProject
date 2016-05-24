library(stringr)
load('data_source/Dataset.RData')


nextword <- function(x){
        input <- x
        inputLen <- length(strsplit(input, ' ')[[1]])
        if (inputLen >= 4){search <- word(input, inputLen-2, inputLen)
        }else if(inputLen > 1){search <- input
        }else{search <- ''} 
        searchLen <- length(strsplit(search,' ')[[1]])
        lookup <- search
        
        if(searchLen == 3){
                ctr3 <- sum(as.numeric(which(!nzchar(gsub(lookup, '', Quadrigram$x1x2x3)))))
                lookup <- word(lookup, searchLen-1, searchLen)
                ctr2 <- sum(as.numeric(which(!nzchar(gsub(lookup, '', Trigram$x1x2)))))
                lookup <- word(lookup, -1)
                ctr1 <- sum(as.numeric(which(!nzchar(gsub(lookup, '', Bigram$x1)))))
        }else if(searchLen == 2){
                ctr3 <- 0
                ctr2 <- sum(as.numeric(which(!nzchar(gsub(lookup, '', Trigram$x1x2)))))
                lookup <- word(lookup, -1)
                ctr1 <- sum(as.numeric(which(!nzchar(gsub(lookup, '', Bigram$x1)))))
        }else{ctr <- 0}
        
        
        
        if(searchLen == 3 && ctr3 != 0){
                predictions <- data.frame(x = which(!nzchar(gsub(search, '', Quadrigram$x1x2x3))))
                row.names(predictions) <- predictions$x
                predictions <- merge(predictions, Quadrigram, by = 'row.names' ,all.x=TRUE)
                predictions <- predictions[c('y', 'freq')]
                colnames(predictions) <- c('Prediction', 'Frequence') 
                predictions <- predictions[order(predictions$Frequence, decreasing = TRUE),]
                predictions <- subset(predictions, Frequence >= mean(predictions$Frequence))
                rownames(predictions) <- NULL      
        }else if(searchLen == 3 && ctr2 != 0){
                search <- word(search, searchLen-1, searchLen)
                predictions <- data.frame(x = which(!nzchar(gsub(search, '', Trigram$x1x2))))
                row.names(predictions) <- predictions$x
                predictions <- merge(predictions, Trigram, by = 'row.names' ,all.x=TRUE)
                predictions <- predictions[c('y', 'freq')]
                colnames(predictions) <- c('Prediction', 'Frequence') 
                predictions <- predictions[order(predictions$Frequence, decreasing = TRUE),]
                predictions <- subset(predictions, Frequence >= mean(predictions$Frequence))
                rownames(predictions) <- NULL 
        }else if(searchLen == 3 && ctr1 != 0){
                search <- word(search, -1)
                predictions <- data.frame(x = which(!nzchar(gsub(search, '', Bigram$x1))))
                row.names(predictions) <- predictions$x
                predictions <- merge(predictions, Bigram, by = 'row.names' ,all.x=TRUE)
                predictions <- predictions[c('y', 'freq')]
                colnames(predictions) <- c('Prediction', 'Frequence') 
                predictions <- predictions[order(predictions$Frequence, decreasing = TRUE),]
                predictions <- subset(predictions, Frequence >= mean(predictions$Frequence))
                rownames(predictions) <- NULL
        }else if(searchLen == 2 && ctr2 != 0){
                predictions <- data.frame(x = which(!nzchar(gsub(search, '', Trigram$x1x2))))
                row.names(predictions) <- predictions$x
                predictions <- merge(predictions, Trigram, by = 'row.names' ,all.x=TRUE)
                predictions <- predictions[c('y', 'freq')]
                colnames(predictions) <- c('Prediction', 'Frequence') 
                predictions <- predictions[order(predictions$Frequence, decreasing = TRUE),]
                predictions <- subset(predictions, Frequence >= mean(predictions$Frequence))
                rownames(predictions) <- NULL 
        }else if(searchLen == 2 && ctr1 != 0){
                search <- word(search, -1)
                predictions <- data.frame(x = which(!nzchar(gsub(search, '', Bigram$x1))))
                row.names(predictions) <- predictions$x
                predictions <- merge(predictions, Bigram, by = 'row.names' ,all.x=TRUE)
                predictions <- predictions[c('y', 'freq')]
                colnames(predictions) <- c('Prediction', 'Frequence') 
                predictions <- predictions[order(predictions$Frequence, decreasing = TRUE),]
                predictions <- subset(predictions, Frequence >= mean(predictions$Frequence))
                rownames(predictions) <- NULL
        }else{predictions <- 'No Predictions'}
        head(predictions, 5)
}

nextword('i want to')
