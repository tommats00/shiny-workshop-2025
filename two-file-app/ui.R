# user interface ----
ui <- navbarPage(
  
  title = "LTER Animal Data Explorer",
  
  # (Page 1) intro tabPanel ----
  tabPanel(title = "About this App",
           
           # intro text fluidRow ----
           fluidRow(
             
             column(1),
             column(10, includeMarkdown("text/about.md")), # 12 represents the entire width of the webpage
             column(1)
             
           ), # END intro text fluidRow
           tags$hr(),
           
           # footer text ----
           includeMarkdown("text/footer.md")
           
           
  ), # END (Page 1) intro tabPanel
  
  
  # (Page 2) data viz tabPanel ----
  tabPanel(title = "Explore the Data",
           
           # tabsetPanel to contain tabs for data viz ----
           tabsetPanel(
             
             # trout tabPanel ----
             tabPanel(title = "Trout",
                      
                      # trout sidebarLayout ----
                      sidebarLayout(
                        
                        # trout sidebarPanel ----
                        sidebarPanel(
                          
                          # channel type pickerInput ----
                          pickerInput(inputId = "channel_type_input",
                                      label = "Select channel type(s):",
                                      choices = unique(clean_trout$channel_type),
                                      selected = c("cascade", "pool"),
                                      multiple = TRUE,
                                      options = pickerOptions(actionsBox = TRUE)),
                          
                          # section checkboxGroupButtons ----
                          checkboxGroupButtons(inputId = "section_input",
                                               label = "Select a sampling section(s):",
                                               choices = c("Clear Cut" = "clear cut forest",
                                                           "Old Growth" = "old growth forest"),
                                               selected = c("clear cut forest",
                                                            "old growth forest"),
                                               justified = TRUE,
                                               checkIcon = list(
                                                 yes = icon("check", lib = "font-awesome"),
                                                 no = icon("xmark", lib = "font-awesome")
                                               ))
                          
                        ), # END trout sidebarPanel()
                        
                        # trout mainPanel ----
                        mainPanel(
                          
                          # trout scatterplot output ----
                          plotOutput(outputId = "trout_scatterplot_output") %>% 
                            withSpinner(color = "limegreen", type = 1, size = 2)
                          
                        ), # END trout mainPanel
                        
                      ) # END trout sidebarLayout
                      
             ), # END trout tabPanel
             
             # Penguin tabPanel ----
             tabPanel(title = "Penguins",
                      
                      # penguin sidebarLayout ----
                      sidebarLayout(
                        
                        # penguin sidebarpanel ----
                        sidebarPanel(
                          
                          # island picker
                          pickerInput(inputId = "island_input",
                                      label = "Select island(s)",
                                      choices = unique(penguins$island),
                                      selected = c("Dream"),
                                      multiple = TRUE,
                                      options = pickerOptions(actionsBox = TRUE)),
                          
                          # number of bins slider
                          sliderInput(inputId = "bin_input",
                                      label = "Select number of bins",
                                      min = 1, max = 100,
                                      value = 25)
                          
                        ), # END penguin sidebarPanel()
                        
                        # penguin mainPanel()
                        mainPanel(
                          
                          plotOutput(outputId = "penguin_hist_output") %>% 
                            withSpinner(color = "limegreen", type = 1, size = 2) # loading spinner when switching between data
                          
                        ) # END penguin mainPanel()
                        
                      ) # END penguin sidebarLayout
                      
             ) # END penguin tabPanel
             
             
           ) # END tabsetPanel
           
  ) # END (Page 2) data viz tabPanel 
  
  
) # END ui

