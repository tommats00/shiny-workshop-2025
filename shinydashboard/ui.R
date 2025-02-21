# dashboard header ----
header <- dashboardHeader(
  
  # title ----
  title = "Fish Creek Watershed Lake Monitoring",
  titleWidth = 400
  
) # END dashboardHeader

# dashboard siderbar ----
sidebar <- dashboardSidebar(
  
  # sidebarMenu ----
  sidebarMenu(
    
    menuItem(text = "Welcome", tabName = "welcome", icon = icon("star")),
    menuItem(text = "Dashboard", tabName = "dashboard", icon = icon("gauge"))
    
  ) # END sidebarMenu
  
) # END dashboardSidebar

# dashboard body ----
body <- dashboardBody(
  
  # set theme ----
  use_theme("dashboard-fresh-theme.css"),
  
  # tabItems ----
  tabItems(
    
    # welcome tabItem ----
    tabItem(tabName = 'welcome',
            
            # lefthand columns ----
            column(width = 6,
                   
                   # background info box
                   box(width = NULL,
                       
                       includeMarkdown("text/intro.md"),
                       
                       title = tagList(icon("water"),
                                       tags$strong("Monitoring Fish Creek Watershed")),
                       
                       # add static image
                       tags$img(src = "map.jpg",
                                alt = "A map of Northern Alaska, showing Fish Creek Watershed location within the National Petroleum Reserve.",
                                style = "max-width: 100%;"),
                       tags$h6("Map Source:", tags$a(href = "http://www.fishcreekwatershed.org/",
                                                     "FCWO"),
                               style = "text-align: center;")
                       
                   ) # END background info box
                   
            ), # END lefthand column
            
            # righthand column ----
            column(width = 6,
                   
                   # first fluidRow ----
                   fluidRow(
                     
                     # citation box ----
                     box(width = NULL,
                         
                         includeMarkdown("text/citation.md"),
                         
                         title = tagList(icon("table"),
                                         tags$strong("Data Source"))
                         
                     ) # END citation box
                     
                   ), # END first fluidRow
                   
                   # second fluidRow ----
                   fluidRow(
                     
                     # disclaimer box
                     box(width = NULL,
                         
                         includeMarkdown("text/disclaimer.md"),
                         
                         title = tagList(icon("triangle-exclamation"),
                                         tags$strong("Disclaimer"))
                         
                     ) # END disclaimer box
                     
                   ) # END second fluidRow
                   
            ) # END righthand column
            
            
    ), # END welcome tabItem
    
    # dashboard tabItem ----
    tabItem(tabName = "dashboard",
            
            # fluidRow ----
            fluidRow(
              
              # input box ----
              box(width = 4,
                  
                  title = tags$strong("Adjust lake parameter ranges:"),
                  
                  # sliderInputs ----
                  sliderInput(inputId = "elevation_slider_input",
                              label = "Elevation (meters above SL)",
                              min = min(lake_data$Elevation),
                              max = max(lake_data$Elevation),
                              value = c(min(lake_data$Elevation),
                                        max(lake_data$Elevation))),
                  
                  sliderInput(inputId = "depth_slider_input",
                              label = "Average depth (meters)",
                              min = min(lake_data$AvgDepth),
                              max = max(lake_data$AvgDepth),
                              value = c(min(lake_data$AvgDepth),
                                        max(lake_data$AvgDepth))),
                  
                  sliderInput(inputId = "temp_slider_input",
                              label = "Average temperature (C°)",
                              min = min(lake_data$AvgTemp),
                              max = max(lake_data$AvgTemp),
                              value = c(min(lake_data$AvgTemp),
                                        max(lake_data$AvgTemp)))
                  
              ), #END input box
              
              # leaflet box ----
              box(width = 8,
                  
                  title = tags$strong("Monitored lakes within Fish Creek Watershed"),
                  
                  # leafletOutput ----
                  leafletOutput(outputId = "lake_map_output") %>% 
                    withSpinner(type = 1, color = "hotpink")
                  
              ) # END leaflet box
              
            ) # END fluidRow
            
    ) # END dashboard tabItem
  ) # END tabItems
  
) # END dashboardBody

# combine all into dashboardPage ----
dashboardPage(header, sidebar, body
)