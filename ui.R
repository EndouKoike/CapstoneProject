library(shiny)
source('helpers.R')

shinyUI(navbarPage('Menu',
                   
                   tabPanel('About',
                            sidebarPanel(
                                    h2('Information'),
                                    p('This application is the final Capstone Project of Data Science Specialization 
                                         provided by Johns Hopkins University /coursera'),
                                    br(),
                                    img(src = 'jhu-logo-thumb.png', height = 125, width = 220),
                                    br(),
                                    a('Data Science Specialization Info', href = 'https://www.coursera.org/specializations/jhu-data-science', 
                                      target = '_blanck')
                                    ), 
                            
                            mainPanel( 
                                    titlePanel('JHU/SwifKey Capstone Project -next word prediction'),
                                    br(),
                                    p('The scope of application is to predict next word. In the Application Page user has a text input object to write
                                      anything he wants. The Application will predict the next word (of users entry) providing a table with the top three predictions
                                      and a plot with all possible predictions by frequency (including top three).',
                                    br(),
                                    p('Dataset is downloaded from coursera in collaboration with', a('SwiftKey', href = 'https://swiftkey.com/en'),'and contains three text files for English -UTF8 
                                         language provided by three different sources (blogs, news & twitter). 
                                         Because of corpus (data) big size, for the Application is used only a random sample from these files (900.000 words for corpus creation).'),
                                    br(),
                                    h4('Features'),
                                    p('The application consists of a basic horizontal Menu with two options:'),
                                    br(),
                                    p(h4('About'),
                                         p('Current page with users documentation for application.'),
                                      br(),
                                      h4('Application'),
                                         p('The Page of the Application of next word prediction separated in two side view, 
                                           left (input) and right (output).'),
                                         p('* The',
                                           span('left side'),
                                           'of screen is the "input" side that has one input box for text user entry (a text -sentence) and a Submit Button
                                                for input text verification and next word prediction.'),
                                         p('* The',
                                           span('right side'),
                                           'of screen is the "output" side that has the results for predictions, only three predictions (maximum) at top and a plot with the rest below.'))
                                         ))
                                    
                                    
                   
                                    ),
                   
                   
                   tabPanel('Application', fluidPage(
                           
                           titlePanel('Next Word Prediction'),
                           sidebarLayout(
                                   sidebarPanel(
                                           textInput('text', label = h3('Text input'), value = ''),
                                           submitButton('Submit'),
                                           br(),
                                           h3('You have written'),
                                           verbatimTextOutput('text')
                                           
                                           
                                   ),
                                   
                                   
                                   mainPanel( 
                                           h4('Results of predictions (only top 3)'),
                                           verbatimTextOutput('pred'),
                                           br(),
                                           h4('All possible predictions by frequency'),
                                           plotOutput('plot')
                                           
                                        
                                           
                                   )
                           )
                   ))
                   
                  
                   )
                            )