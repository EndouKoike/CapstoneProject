library(shiny)
library(ggplot2)


shinyServer(function(input, output, session) {
        
       
        output$text <- reactive({
                validate(need(trimws(input$text) != '', '... nothing!'))
                input$text})
        
        
        output$pred <- renderPrint({
                validate(need(trimws(input$text) != '', 'Please write something to predict next word'))
                withProgress(message = 'Processing prediction...', value = 0.1, {
                Sys.sleep(0.25)
                predictions <- nextword(input$text)
                validate({need(predictions != 'No Predictions', 'Not available predictions')})
                names(predictions) <- c('', '')
                head(predictions[1], 3)
               })
        })
        
        
        output$plot <- renderPlot({
                predictions <- nextword(input$text)
                validate(if (trimws(input$text) == ''){need(trimws(input$text) != '', 'Predictions need for plotting')
                }else{need(predictions != 'No Predictions', 'Not available predictions for ploting!')})
                p <- ggplot(predictions, aes(reorder(Prediction, +Frequence), Frequence))
                p <- p + geom_bar(stat = 'identity')
                p <- p + xlab('Predictions')
                p <- p + ylab('Frequnecy')
                p <- p + theme(axis.text.x=element_text(angle = 45, hjust = 1))
                p <- p + coord_flip() 
                return(p)
        })
        
        
})