library(shiny)
library(shinydashboard)
library(DT)
library(ggplot2)
library(dplyr)

# ---------------------------
# Generate Traffic Dataset
# ---------------------------

# ---------------------------
# Generate Traffic Dataset (10 Parameters)
# ---------------------------

set.seed(123)

traffic <- data.frame(
  
  Vehicle_ID = 1:5000,
  
  
  Vehicle_Type = sample(
    c("Car","Bus","Truck","Bike","Auto","Van"),
    5000,
    replace = TRUE
  ),
  
  
  Road = sample(
    c("Highway","City Road","Bridge",
      "Expressway","Main Road",
      "Street","Rural Road","Junction"),
    5000,
    replace = TRUE
  ),
  
  
  Speed = round(
    runif(5000,20,120),
    2
  ),
  
  
  Waiting_Time = round(
    runif(5000,1,30),
    2
  ),
  
  
  Traffic_Level = sample(
    c("Low","Medium","High"),
    5000,
    replace = TRUE
  ),
  
  
  Vehicle_Count = sample(
    10:200,
    5000,
    replace = TRUE
  ),
  
  
  Weather_Condition = sample(
    c("Sunny","Rainy","Foggy","Cloudy"),
    5000,
    replace = TRUE
  ),
  
  
  Accident_Status = sample(
    c("Yes","No"),
    5000,
    replace = TRUE,
    prob=c(0.1,0.9)
  ),
  
  
  Signal_Delay = round(
    runif(5000,0,60),
    2
  )
  
)
# ---------------------------
# UI
# ---------------------------

ui <- dashboardPage(
  
  dashboardHeader(
    title="Traffic Analysis Dashboard"
  ),
  
  
  dashboardSidebar(
    
    sidebarMenu(
      
      menuItem(
        "Dashboard",
        tabName="dashboard",
        icon=icon("home")
      ),
      
      
      menuItem(
        "Olympus Traffic Dataset",
        tabName="dataset",
        icon=icon("table")
      ),
      
      
      menuItem(
        "Traffic Analytics",
        tabName="analytics",
        icon=icon("chart-bar")
      ),
      
      
      menuItem(
        "Traffic Distribution",
        tabName="distribution",
        icon=icon("pie-chart")
      ),
      
      
      menuItem(
        "Vehicle Analysis",
        tabName="vehicle",
        icon=icon("car")
      ),
      
      
      menuItem(
        "Summary Table",
        tabName="summary",
        icon=icon("clipboard")
      ),
      
      
      menuItem(
        "Download Dataset",
        tabName="download",
        icon=icon("download")
      )
      
    )
    
  ),
  
  
  
  dashboardBody(
    
    
    tabItems(
      
      
      # ---------------- Dashboard ----------------
      
      tabItem(
        
        tabName="dashboard",
        
        fluidRow(
          
          box(
            title="Total Traffic Records",
            value=5000,
            width=4,
            status="primary"
          ),
          
          
          box(
            title="Average Speed",
            value=paste(
              round(mean(traffic$Speed),2),
              "km/h"
            ),
            width=4,
            status="success"
          ),
          
          
          box(
            title="Average Waiting Time",
            value=paste(
              round(mean(traffic$Waiting_Time),2),
              "sec"
            ),
            width=4,
            status="warning"
          )
          
        )
        
      ),
      
      
      
      # ---------------- Dataset ----------------
      
      
      tabItem(
        
        tabName="dataset",
        
        box(
          
          title="Olympus Traffic Dataset",
          
          width=12,
          
          status="primary",
          
          solidHeader=TRUE,
          
          
          DTOutput("dataTable")
          
        )
        
      ),
      
      
      
      # ---------------- Analytics ----------------
      
      
      tabItem(
        
        tabName="analytics",
        
        box(
          
          title="Speed Analysis",
          
          width=12,
          
          plotOutput("speedPlot")
          
        )
        
      ),
      
      
      
      # ---------------- Distribution ----------------
      
      
      tabItem(
        
        tabName="distribution",
        
        box(
          
          title="Traffic Level Distribution",
          
          width=12,
          
          plotOutput("trafficPlot")
          
        )
        
      ),
      
      
      
      # ---------------- Vehicle ----------------
      
      
      tabItem(
        
        tabName="vehicle",
        
        box(
          
          title="Vehicle Type Analysis",
          
          width=12,
          
          plotOutput("vehiclePlot")
          
        )
        
      ),
      
      
      
      # ---------------- Summary ----------------
      
      
      tabItem(
        
        tabName="summary",
        
        box(
          
          title="Traffic Dataset Summary",
          
          width=12,
          
          status="primary",
          
          solidHeader=TRUE,
          
          
          DTOutput("summaryTable")
          
        )
        
      ),
      
      
      
      # ---------------- Download ----------------
      
      
      tabItem(
        
        tabName="download",
        
        box(
          
          title="Download Traffic Dataset",
          
          width=12,
          
          
          downloadButton(
            "downloadData",
            "Download CSV"
          )
          
        )
        
      )
      
      
    )
    
  )
  
)



# ---------------------------
# SERVER
# ---------------------------


server <- function(input,output){
  
  
  
  # Dataset Table
  
  output$dataTable <- renderDT({
    
    datatable(
      
      traffic,
      
      options=list(
        
        pageLength=10,
        
        scrollX=TRUE
        
      ),
      
      rownames=FALSE
      
    ) %>%
      
      
      formatStyle(
        
        columns=names(traffic),
        
        backgroundColor=
          styleEqual(
            
            unique(traffic$Traffic_Level),
            
            c(
              "#E3F2FD",
              "#E8F5E9",
              "#FFF3E0"
            )
            
          )
        
      )
    
    
  })
  
  
  
  
  # Summary Table
  
  output$summaryTable <- renderDT({
    
    
    summary_data <- data.frame(
      
      Metric=c(
        
        "Total Traffic Records",
        
        "Number of Features",
        
        "Missing Values",
        
        "Duplicate Records",
        
        "Average Speed (km/h)",
        
        "Maximum Speed (km/h)",
        
        "Minimum Speed (km/h)",
        
        "Road Types",
        
        "Vehicle Types"
        
      ),
      
      
      Value=c(
        
        nrow(traffic),
        
        ncol(traffic),
        
        sum(is.na(traffic)),
        
        sum(duplicated(traffic)),
        
        round(mean(traffic$Speed),2),
        
        max(traffic$Speed),
        
        min(traffic$Speed),
        
        length(unique(traffic$Road)),
        
        length(unique(traffic$Vehicle_Type))
        
      )
      
      
    )
    
    
    
    datatable(
      
      summary_data,
      
      rownames=FALSE,
      
      options=list(
        
        dom='t',
        
        pageLength=10
        
      )
      
    )
    
    
  })
  
  
  
  
  # Speed Plot
  
  output$speedPlot <- renderPlot({
    
    
    ggplot(
      traffic,
      aes(
        x=Speed
      )
    )+
      
      geom_histogram(
        bins=30,
        fill="steelblue"
      )+
      
      theme_minimal()+
      
      labs(
        title="Vehicle Speed Distribution",
        x="Speed km/h",
        y="Count"
      )
    
    
  })
  
  
  
  
  # Traffic Distribution
  
  output$trafficPlot <- renderPlot({
    
    
    ggplot(
      
      traffic,
      
      aes(
        x=Traffic_Level
      )
      
    )+
      
      geom_bar(
        fill="orange"
      )+
      
      theme_minimal()+
      
      labs(
        title="Traffic Level Distribution"
      )
    
    
  })
  
  
  
  
  # Vehicle Analysis
  
  output$vehiclePlot <- renderPlot({
    
    
    traffic %>%
      
      count(Vehicle_Type) %>%
      
      ggplot(
        
        aes(
          
          x=Vehicle_Type,
          
          y=n
          
        )
        
      )+
      
      geom_bar(
        
        stat="identity",
        
        fill="green"
        
      )+
      
      theme_minimal()+
      
      labs(
        
        title="Vehicle Type Count"
        
      )
    
    
  })
  
  
  
  
  # Download
  
  output$downloadData <- downloadHandler(
    
    filename=function(){
      
      "traffic_dataset.csv"
      
    },
    
    
    content=function(file){
      
      write.csv(
        traffic,
        file,
        row.names=FALSE
      )
      
    }
    
    
  )
  
  
}



shinyApp(ui,server)