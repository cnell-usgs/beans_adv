
library(shinydashboard)
library(rhandsontable)
##need to figure out how to have conditional messages if there is not enough data yet to fill blank boxes

sidebar <- dashboardSidebar(
  sidebarMenu(
    menuItem("Example",tabName="example",icon=icon("stats",lib="glyphicon")),
    textInput("treat1","Treatment 1:",value="Treatment 1"),
    textInput("treat2","Treatment 2:", value="Treatment 2"),
    textInput("var1","Variable 1:", value= "A"),
    textInput("var2","Variable 2:",value= "B")
  
  ) 
)

body <- dashboardBody(
  tabItems(
    tabItem(tabName="example",
      fluidRow(
        box(title = "Comparing and plotting means",width=3,solidHeader=TRUE,status="primary",collapsible = TRUE,
            p("Use the text boxes on the left to name the treatments and variables. Enter data in the respective tables."),br(),
            p("Pressing 'Run Data' initiates a one-way ANOVA test on the data entered in the tables. 
              This test evaluates whether the variable of interest differs between the two treatment groups. Change the variable of interest to re-run results."),br(),
            p("Summary statistics will also be calculated and plotted. Use the controls to select which variables are plotted."),br(),
            p("Note: data must be entered for both treatments in order for the outputs to work."),br(),
            actionButton("getdata","Run Data"),br(),br(),
            p("To replicate these analyses in R, use download the data and code that produces these outputs."),
            downloadButton("downloadData","Download Data"),
            downloadButton("downloadplotr","Get code")
        ),
        box(title = "Data Entry", width=5,solidHeader = TRUE,status="primary",
            column(width=5,textOutput("tr1"), rHandsontableOutput("table1")),
            column(width=5,textOutput("tr2"),rHandsontableOutput("table2"))
        ),
        tabBox(id = "plots",width = 4,
            tabPanel("Plotting means",plotOutput("plot1"),
              radioButtons("errortype", "Error bars:", 
                           choices=c("95% Confidence interval"="ci","Standard error (SE)"="se","Standard deviation (S)"="sd")),
              htmlOutput("selectUI")
              ),
            tabPanel("Histogram",plotOutput("histo"),
              checkboxInput("showmean","Show means", value=FALSE))
        )
      ),
      fluidRow(
        box(title="Data Summary", width = 6,status="primary",
            textOutput("vartext"),
            rHandsontableOutput("summary_table"), br(),br()
        ),
        box(title="One-way ANOVA", width=6, status="primary",
            verbatimTextOutput("anovatable"))
      )
    )
  )
)

# Put them together into a dashboardPage
dashboardPage(skin = "red",
  dashboardHeader(title = "beans"),
  sidebar,
  body
)