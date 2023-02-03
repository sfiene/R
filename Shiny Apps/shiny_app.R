# Deploying to production
library(shiny)
library(tree)

# test shiny
ui <- fluidPage('HelloWorld')
server <- function(input, output) {}
shinyApp(
  ui = ui,
  server = server
)

# create ui
ui <- fluidPage(
  titlePanel('Input and Output'),
  sidebarLayout(
    sidebarPanel(
      sliderInput(
        inputId = 'num',
        label = 'Choose a Number',
        min = 0,
        max = 100,
        value = 25
      )
    ),
    mainPanel(
      textOutput(
        outputId = 'text'
      )
    )
  )
)

# create server to map input to output
server <- function(input, output) {
  output$text <- renderText({
    paste('You selected ', input$num)
  })
}

# create shiny app
shinyApp(
  ui = ui,
  server = server
)

# load model
load('Tree.RData')

library(RColorBrewer)
palette <- brewer.pal(3, 'Set2')

# create user interface code
ui <- fluidPage(
  titlePanel('Iris Species Predictor'),
  sidebarLayout(
    sidebarPanel(
      sliderInput(
        inputId = 'petal.length',
        label = 'Petal Length (cm)',
        min = 1,
        max = 7,
        value = 4
      ),
      sliderInput(
        inputId = 'petal.width',
        label = 'Petal Width (cm)',
        min = 0.0,
        max = 2.5,
        step = 0.5,
        value = 1.5
      )
    ),
    mainPanel(
      textOutput(
        outputId = 'text'
      ),
      plotOutput(
        outputId = 'plot'
      )
    )
  )
)

# creater server code
server <- function(input, output){
  output$text = renderText({
    
    # Create predictors
    predictors <- data.frame(
      Petal.Length = input$petal.length,
      Petal.Width = input$petal.width,
      Sepal.Length = 0,
      Sepal.Widtt = 0
    )
    
    # Make prediction
    prediction = predict(
      object = model,
      newdata = predictors,
      type = 'class'
    )
    
    # Create prediction text
    paste(
      'The predicted species is ',
      as.character(prediction)
    )
  })
  
  output$plot = renderPlot({
    
    # Create a scatter plot colored by species
    plot(
      x = iris$Petal.Length,
      y = iris$Petal.Width,
      pch = 19,
      col = palette[as.numeric(iris$Species)],
      main = 'Iris Petal Length vs. Width',
      xlab = 'Petal Length (cm)',
      ylab = 'Petal Width (cm)'
    )
    
    # Plot decision tree boundaries
    partition.tree(
      snip.tree(
        model,
        nodes = c(12, 7)),
      label = 'Species',
      add = TRUE
    )
    
    # draw predictor on plot
    points(
      x = input$petal.length,
      y = input$petal.width,
      col = 'red',
      pch = 4,
      cex = 2,
      lwd = 2
    )
  })
}

# create shiny app
shinyApp(
  ui = ui,
  server = server
)
