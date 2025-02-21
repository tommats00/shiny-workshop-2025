# server ----
server <- function(input, output){
  
  ##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  ##                                                                            --
  ##----------------------------- TROUT PANEL DATA--------------------------------
  ##                                                                            --
  ##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  
  
  # filter trout data ----
  trout_filtered_df <- reactive({
    
    validate(
      need(length(input$channel_type_input) > 0, 
           "Please select at least one channel type to visualize data for."),
      need(length(input$section_input) > 0,
           "Please select at least one sampling section input to visualize data for")
    ) # when no input for these, messages will appear 
    
    clean_trout |> 
      filter(channel_type %in% c(input$channel_type_input)) |> 
      filter(section %in% c(input$section_input))
    
  })
  
  
  
  # trout scatterplot ----
  output$trout_scatterplot_output <- renderPlot({
    
    ggplot(trout_filtered_df(), aes(x = length_mm, y = weight_g, 
                                  color = channel_type, shape = channel_type)) +
      geom_point(alpha = 0.7, size = 5) +
      scale_color_manual(values = c("cascade" = "#2E2585", 
                                    "riffle" = "#337538", 
                                    "isolated pool" = "#DCCD7D", 
                                    "pool" = "#5DA899", 
                                    "rapid" = "#C16A77", 
                                    "step (small falls)" = "#9F4A96", 
                                    "side channel" = "#94CBEC")) +
      scale_shape_manual(values = c("cascade" = 15, 
                                    "riffle" = 17, 
                                    "isolated pool" = 19, 
                                    "pool" = 18, 
                                    "rapid" = 8, 
                                    "step (small falls)" = 23, 
                                    "side channel" = 25)) +
      labs(x = "Trout Length (mm)", 
           y = "Trout Weight (g)", 
           color = "Channel Type", 
           shape = "Channel Type") +
      myCustomTheme()
    
    
  },
  
  alt = "This is my alt text."
  
  )
  
  ##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  ##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  ##                                                                            ~~
  ##                            PENGUINS PANEL DATA                           ----
  ##                                                                            ~~
  ##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  ##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  
  
  # reactive penguin dataframe
  island_df <- reactive({
    
    validate(
      need(length(input$island_input) > 0,
           "Please select at least one island input to visualize data for") 
    ) # When no island input, message will appear 
    
    penguins |> 
      filter(island %in% c(input$island_input)) 
             
             }) # END Penguin Dataframe
  
  
  
  # penguin histogram
  output$penguin_hist_output <- renderPlot({
    
    #........................plot penguin data.......................
    ggplot(na.omit(island_df()), aes(x = flipper_length_mm, fill = species)) +
      geom_histogram(alpha = 0.6, position = "identity", bins = input$bin_input) +
      scale_fill_manual(values = c("Adelie" = "#FEA346", "Chinstrap" = "#B251F1", "Gentoo" = "#4BA4A4")) +
      labs(x = "Flipper length (mm)", y = "Frequency",
           fill = "Penguin species") +
      myCustomTheme()
    
  },
  
  alt = "This is my penguin alt text"
  
  )
  
  
  
  
  
  
  ##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  ##                                                                            --
  ##------------------------------- END OF SCRIPT---------------------------------
  ##                                                                            --
  ##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
}