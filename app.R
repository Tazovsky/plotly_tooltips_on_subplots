library(plotly)
library(shinydashboard)
library(shinyjs)

header <- dashboardHeader(
  title = "Render tooltips on plotly subplots"
)

body <- dashboardBody(
  shinyjs::useShinyjs(),
  includeScript(path = "www/renderTooltipsOnSubplots.js"),
  fluidRow(
    column(width = 9,
           box(width = NULL, solidHeader = TRUE,
               plotly::plotlyOutput('subplot_js_plot')
           )
    )
  )
)

ui <- dashboardPage(
  header,
  dashboardSidebar(disable = TRUE),
  body
)

server <- function(input, output, session) {
  
  output$subplot_js_plot <- plotly::renderPlotly({
    p1 <- plot_ly(economics, x = ~date, y = ~unemploy) %>%
      add_lines(name = ~"unemploy")
    p2 <- plot_ly(economics, x = ~date, y = ~uempmed) %>%
      add_lines(name = ~"uempmed")
    p <- subplot(p1, p2)
    
    
    # js hook to render tooltips on sublots
    hook <- list()
    hook$render[[1]]$code <- "renderTooltipsOnSubplots('subplot_js_plot')"
    
    p$jsHooks <- hook
    p
  })
  
}

shinyApp(ui = ui, server = server)
