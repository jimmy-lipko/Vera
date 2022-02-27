# Reporting App

library(shiny)
library(shinythemes)
library(DBI)
library(shinyjs)

# Define UI for application that draws a histogram
ui <- { shinyUI(fluidPage( 
  shinyjs::useShinyjs(),
 
    fluidRow(
      column(8, align="center", offset = 2,
    h1(tags$b("Vera Reporting App")),
    tags$style(type="text/css", "#string { height: 50px; width: 100%; text-align:center; font-size: 30px; display: block;}"))),
    
    
    h2('What are you looking to do?'),
    
    selectInput(
      "filing",
      "",
      c(
        '',
        `Submit Report` = "report",
        `Add Technician` = "tech",
        `Add Product` = 'product',
        `Add Customer` = 'customer'
      ),
      selected = NULL
    ),
    
    conditionalPanel(
      condition = "input.filing == 'tech'",
      h3("Adding a New Technician"),
      div(tags$hr()),
      textOutput('tech_output'),
      tags$style("#tech_output{color: green;
                                 font-size: 20px;
                                 font-style: italic;
                                 }"),
      div(id = 'tech',
      
      fluidRow(
        column(
          3,
          
          textInput(inputId = 'tech_fname',
                    label = 'First Name'),
          
          textInput(inputId = 'tech_lname',
                    label = 'Last Name'),
          
          textInput(inputId = 'tech_address',
                    label = 'Working From Address'),
          
          textInput(inputId = 'tech_city',
                    label = 'City/Town')
        ),
        
        column(
          3,
          offset = 1,
          
          textInput(inputId = 'tech_state',
                    label = 'State - 2 letter code'),
          
          textInput(
            inputId = 'tech_country',
            label = 'Country - 2 letter code',
            value = "US"
          ),
          
          textInput(inputId = 'tech_zip',
                    label = 'Zip Code'),
          
          textInput(inputId = 'tech_phone',
                    label = 'Phone Number'),
          
          selectInput(
            "tech_affiliation",
            "Vera Affiliated?",
            c(True = "True",
              False = "False")
          ),
          br(),
          actionButton(
            inputId = 'submit_tech',
            label = 'Submit New Technician',
            icon = NULL,
            width = NULL
          )
        )
          
        )
      )
    ),
    
    conditionalPanel(
      
      condition = "input.filing == 'customer'",
      h3("Adding a New Customer"),
      
      div(tags$hr()),
      textOutput('cust'),
      tags$style("#cust{color: green;
                                 font-size: 20px;
                                 font-style: italic;
                                 }"),
      div(
        id = 'cust_form',
      fluidRow(
        column(
          3,
          
          textInput(inputId = 'cust_name',
                    label = 'Customer Name'),
          
          textInput(inputId = 'cust_address',
                    label = 'Location'),
          
          textInput(inputId = 'cust_city',
                    label = 'City/Town'),
          
          textInput(inputId = 'cust_state',
                    label = 'State - 2 letter code')
        ),
        
        column(
          3,
          offset = 1,
          
          textInput(
            inputId = 'cust_country',
            label = 'Country - 2 letter code',
            value = "US"
          ),
          
          textInput(inputId = 'cust_zip',
                    label = 'Zip Code'),
          
          textInput(inputId = 'cust_phone',
                    label = 'Phone Number'),
          
          br(),
          actionButton(
            inputId = 'submit_cust',
            label = 'Submit New Customer',
            icon = NULL,
            width = NULL
          )
          
      
        )
      ))
    ),
    
    conditionalPanel(
      condition = "input.filing == 'product'",
      h3("Adding a New Product"),
      div(tags$hr()),
      
      textInput(inputId = 'prod_name', label = 'Product Name'),
      
      textInput(inputId = 'prod_sku', label = 'SKU#'),
      
      textInput('prod_manu', label = 'Manufacturer'),
      
      numericInput(
        inputId = 'prod_price',
        label = 'Price',
        value = NULL
      ),
      
      numericInput(
        inputId = 'prod_cost',
        label = 'Cost',
        value = NULL
      ),
      
      br(),
      actionButton(
        inputId = 'submit_prod',
        label = 'Add New Product',
        icon = NULL,
        width = NULL
      )
    ),
    
    
    conditionalPanel(
      condition = "input.filing == 'report'",
      h3("Filing a Report"),
      selectInput(
        "reportType",
        "Report Type",
        c(
          '',
          `Pre-Installation Report` = "pre",
          `Installation` = "install",
          `Preventative Maintenance` = 'pm',
          `Reactive` = 'reactive',
          `Water Analysis Report` = "water"
        )
      ),
      
      div(tags$hr()),
      
      conditionalPanel(
        condition = "input.reportType == 'water'",
        
        
        textOutput('wq_output'),
        tags$style("#wq_output{color: green;
                                 font-size: 20px;
                                 font-style: italic;
                                 }"),
        div(
          id = 'wq_form',
        
        h3(tags$b(' Water Analysis Report')),
        column(
          3,
          
          dateInput(
            inputId = 'water_analysis_date',
            label = 'Water Analysis Date',
            value = NULL,
            min = NULL,
            max = NULL,
            format = "yyyy-mm-dd",
            startview = "month",
            weekstart = 0,
            language = "en",
            width = NULL,
            autoclose = TRUE,
            datesdisabled = NULL,
            daysofweekdisabled = NULL
          ),
          
          
          uiOutput('water_report_id'),
          
          selectInput("water-filter", "Filtration",
                      c(Post = "Post" , Pre = "Pre")),
          numericInput(
            inputId = 'alk',
            label = 'Alkalinity, Total - Drinking',
            value = NULL
          )
          
        ),
        
        column(
          4,
          offset = 1,
          
          numericInput(
            inputId = 'ammonia',
            label = 'Ammonia',
            value = NULL
          ),
          
          numericInput(
            inputId = 'nacl',
            label = 'Chloride (as NaCl)',
            value = NULL
          ),
          numericInput(
            inputId = 'dpd1',
            label = 'Chlorine, Free (DPD-1)',
            value = NULL
          ),
          
          numericInput(
            inputId = 'dpd4',
            label = 'Chlorine, Total (DPD-4)',
            value = NULL
          ),
          
          numericInput(
            inputId = 'cu2',
            label = 'Copper (Cu+2)',
            value = NULL
          ),
          numericInput(
            inputId = 'caco3',
            label = 'Hardness, Total HR (as CaCO3)',
            value = NULL
          )
        ),
        column(4,
        
          
          numericInput(
            inputId = 'no3',
            label = 'Nitrate (as NO3)',
            value = NULL
          ),
          
          numericInput(
            inputId = 'no2',
            label = 'Nitrite (as NO2)',
            value = NULL
          ),
          
          numericInput(
            inputId = 'ph',
            label = 'pH, BT - Fresh',
            value = NULL
          ),
          
          numericInput(
            inputId = 'phosphate',
            label = 'Phosphate',
            value = NULL
          ),
          
          
          actionButton(
            inputId = 'water_submit',
            label = 'Submit Report',
            icon = NULL,
            width = NULL
            
          )
        )
        )
        
        
      ),
      
      conditionalPanel(condition = "input.reportType == 'pre'",
                       h3(tags$b('Pre-Installation Report')),
                         
                       textOutput("pre_install"),
                       tags$style("#pre_install{color: green;
                                 font-size: 20px;
                                 font-style: italic;
                                 }"),
                       div(
                         id = 'pre-form',
                       
                       fluidRow(
                         column(
                           3,
                           
                           uiOutput('pre_customer_id'),
                           
                           uiOutput('pre_technician_id'),
                           
                           dateInput(
                             inputId = 'pre_on_site_date',
                             label = 'On Site Date',
                             value = NULL,
                             min = NULL,
                             max = NULL,
                             format = "yyyy-mm-dd",
                             startview = "month",
                             weekstart = 0,
                             language = "en",
                             width = NULL,
                             autoclose = TRUE,
                             datesdisabled = NULL,
                             daysofweekdisabled = NULL
                           ),
                           
                           numericInput(
                             inputId = 'pre_duration',
                             label = 'Duration - Hrs',
                             value = NULL
                           ),
                           
                           textInput('pre_notes', 'Notes', NULL),
                           
                           actionButton(
                             inputId = 'pre_submit',
                             label = 'Submit Report',
                             icon = NULL,
                             width = NULL
                           ))
                           
                           
                         )
                       )),
      
      conditionalPanel(condition = "input.reportType == 'install'",
                       h3(tags$b(
                         'Installation Report'
                       )),
                       
                       textOutput("install"),
                       tags$style("#install{color: green;
                                 font-size: 20px;
                                 font-style: italic;
                                 }"),
                       
                       div(
                         id = 'install-form',
                       fluidRow(
                         column(
                           3,
                           
                           dateInput(
                             inputId = 'install_date_entered',
                             label = 'Date',
                             value = NULL,
                             min = NULL,
                             max = NULL,
                             format = "yyyy-mm-dd",
                             startview = "month",
                             weekstart = 0,
                             language = "en",
                             width = NULL,
                             autoclose = TRUE,
                             datesdisabled = NULL,
                             daysofweekdisabled = NULL
                           ),
                           
                           uiOutput('install_customer_id'),
                           
                           uiOutput('install_technician_id'),
                           
                           uiOutput("install_pre_id"),
                           
                           numericInput(
                             inputId = 'install_amps',
                             label = 'Circuit Amperage',
                             value = NULL
                           ),
                           numericInput(
                             inputId = 'install_volts',
                             label = 'Voltage' ,
                             value = NULL
                           )
                         ),
                         
                         column(4, offset = 1,
                                
                                numericInput(
                                  inputId = 'install_psi',
                                  label = 'Guage Reading (PSI)',
                                  value = NULL
                                ),
                                
                                selectInput("install_scale", "Evidence of Scale",
                                            c(Yes = 'True', No = 'False')),
                                
                                textInput(inputId = 'install_gt', label = 'Grouphead Temp'),
                                
                                textInput(inputId = 'install_notes', label = 'Notes'),
                                 
                                uiOutput('install_product'),
                                 
                                 numericInput(
                                   inputId = 'install_quantity',
                                   label = 'Qty',
                                   value = NULL
                                 )
                       ),
                                 
                         
                         column(
                           4,
                           
                           textInput(inputId = 'install_serial', label = 'Serial Number'),
                           
                           dateInput(
                             inputId = 'install_manufacturer_invoice_date',
                             label = 'Manufacturer Invoice Date',
                             value = NULL,
                             min = NULL,
                             max = NULL,
                             format = "yyyy-mm-dd",
                             startview = "month",
                             weekstart = 0,
                             language = "en",
                             width = NULL,
                             autoclose = TRUE,
                             datesdisabled = NULL,
                             daysofweekdisabled = NULL
                           ), 
                           
                           selectInput(
                             "install_pm_schedule",
                             "PM Schedule",
                             c("Quarterly", "Bianunual", "Annual")
                           ),
                           
                           selectInput("install_filter", "Filter Changed?",
                                       c("Yes"= 'True', "No"='False')),
                           
                           dateInput(
                             inputId = 'install_filter_date',
                             label = 'Next Filter Change Date',
                             value = NULL,
                             min = NULL,
                             max = NULL,
                             format = "yyyy-mm-dd",
                             startview = "month",
                             weekstart = 0,
                             language = "en",
                             width = NULL,
                             autoclose = TRUE,
                             datesdisabled = NULL,
                             daysofweekdisabled = NULL
                           ),
                           
                           numericInput(
                             inputId = 'install_duration',
                             label = 'Duration - Hrs',
                             value = NULL
                           ),
                           
                           actionButton(
                             inputId = 'install_submit',
                             label = 'Submit Report',
                             icon = NULL,
                             width = NULL
                           )
                           
                         )
                         
                       )
                       )),
      
      conditionalPanel(condition = "input.reportType == 'pm'",
                       
                       
                       h3(
                         tags$b('Preventative Maintenance Report')
                       ),
                       
                       textOutput('pm_output'),
                       
                       tags$style("#pm_output{color: green;
                                 font-size: 20px;
                                 font-style: italic;
                                 }"),
                       
                       div(id = "pm_form",
                       
                       
                       fluidRow(
                         column(
                           3,
                           
                           dateInput(
                             inputId = 'pm_date_entered',
                             label = 'Date',
                             value = NULL,
                             min = NULL,
                             max = NULL,
                             format = "yyyy-mm-dd",
                             startview = "month",
                             weekstart = 0,
                             language = "en",
                             width = NULL,
                             autoclose = TRUE,
                             datesdisabled = NULL,
                             daysofweekdisabled = NULL
                           ),
                           
                           uiOutput('annual_customer_id'),
                           
                           uiOutput('annual_technician_id'),
                           
                           numericInput(
                             inputId = 'pm_amps',
                             label = 'Circuit Amperage',
                             value = NULL
                           ),
                           
                           numericInput(
                             inputId = 'pm_volts',
                             label = 'Voltage' ,
                             value = NULL
                           ),
                           
                           numericInput(
                             inputId = 'pm_psi',
                             label = 'Guage Reading (PSI)',
                             value = NULL
                           )
                         
                         ),
                         column(
                           4,
                           offset = 1,
                           
                           selectInput("pm_scale", "Evidence of Scale",
                                       c(Yes = 'True', No = 'False')),
                           
                           textInput(inputId = 'pm_gt', label = 'Grouphead Temp'),
                          
                           uiOutput("pm_product_1"),
                           
                           textInput(inputId = 'pm_serial', label = 'Serial Number'),
                           
                           selectInput(
                             "pm_pm_schedule",
                             "PM Schedule",
                             c("Quarterly", "Bianunual", "Annual")
                           ),
                           
                           selectInput("pm_filter", "Filter Changed?",
                                       c(Yes = 'True', No = 'False'))
                       ),
                       
                       column(
                         4,
                           
                           dateInput(
                             inputId = 'pm_filter_date',
                             label = 'Next Filter Change Date',
                             value = NULL,
                             min = NULL,
                             max = NULL,
                             format = "yyyy-mm-dd",
                             startview = "month",
                             weekstart = 0,
                             language = "en",
                             width = NULL,
                             autoclose = TRUE,
                             datesdisabled = NULL,
                             daysofweekdisabled = NULL
                           ),
                           
                           numericInput(
                             inputId = 'pm_duration',
                             label = 'Duration - Hrs',
                             value = NULL
                           ),
                           
                           textInput(inputId = 'pm_notes', label = 'Notes'),
                           
                           textInput(inputId = 'pm_recs', label = 'Recommendations'),
                           
                           actionButton(
                             inputId = 'pm_submit',
                             label = 'Submit Report',
                             icon = NULL,
                             width = NULL
                           )
                         )
                       )
                       )),
      
      
      conditionalPanel(condition = "input.reportType == 'reactive'",
                       h3(tags$b(
                         'Reactive Service Report'
                       )),
                       
                       textOutput('reactive_output'),
                       
                       tags$style("#reactive_output{color: green;
                                 font-size: 20px;
                                 font-style: italic;
                                 }"),
                       
                      div(id = "reactive_form",
                       fluidRow(
                         column(
                           3,
                           
                           dateInput(
                             inputId = 'reactive_date_entered',
                             label = 'Date',
                             value = NULL,
                             min = NULL,
                             max = NULL,
                             format = "yyyy-mm-dd",
                             startview = "month",
                             weekstart = 0,
                             language = "en",
                             width = NULL,
                             autoclose = TRUE,
                             datesdisabled = NULL,
                             daysofweekdisabled = NULL
                           ),
                           
                           uiOutput('reactive_customer_id'),
                           
                           uiOutput('reactive_technician_id'),
                           
                           numericInput(
                             inputId = 'reactive_amps',
                             label = 'Circuit Amperage',
                             value = NULL
                           ),
                           
                           numericInput(
                             inputId = 'reactive_volts',
                             label = 'Voltage' ,
                             value = NULL
                           ),
                           
                           numericInput(
                             inputId = 'reactive_psi',
                             label = 'Guage Reading (PSI)',
                             value = NULL
                           )
                           
                         ),
                         
                         
                         column(
                           4,
                           offset = 1,
                           
                           selectInput("reactive_scale", "Evidence of Scale",
                                       c(Yes = 'True', No = 'False')),
                           
                           textInput(inputId = 'reactive_gt', label = 'Grouphead Temp'),
                           
                           uiOutput("reactive_product_1"),
                           
                           textInput(inputId = 'reactive_serial', label = 'Serial Number'),
                           
                           selectInput(
                             "reactive_pm_schedule",
                             "PM Schedule",
                             c("Quarterly", "Bianunual", "Annual")
                           ),
                           
                           selectInput("reactive_filter", "Filter Changed?",
                                       c(Yes = 'True', No= "False"))
                         ),
                         column(
                           4,     
                           dateInput(
                             inputId = 'reactive_filter_date',
                             label = 'Next Filter Change Date',
                             value = NULL,
                             min = NULL,
                             max = NULL,
                             format = "yyyy-mm-dd",
                             startview = "month",
                             weekstart = 0,
                             language = "en",
                             width = NULL,
                             autoclose = TRUE,
                             datesdisabled = NULL,
                             daysofweekdisabled = NULL
                           ),
                           
                           numericInput(
                             inputId = 'reactive_downtime',
                             label = 'Machine Downtime (days)',
                             value = NULL
                           ),
                           
                           textInput(inputId = 'reactive_notes', label = 'Notes'),
                           
                           textInput(inputId = 'reactive_recs', label = 'Recommendations'),
                           
                           numericInput(
                             inputId = 'reactive_duration',
                             label = 'Duration - Hrs',
                             value = NULL
                           ),
                           
                           actionButton(
                             inputId = 'reactive_submit',
                             label = 'Submit Report',
                             icon = NULL,
                             width = NULL
                           )
                         )
                       )
                       )),
      
      
      
      
      br(),
      br(),
      
      
      br(),
      
      div(tags$hr()),
      
      br()
    )
  
))}

# Define server logic required to draw a histogram
server <- function(input, output) {
  # DB Connection
   { db <- 'postgres'  #provide the name of your db
  
  host_db <- 'prod.cazcqhfxsztq.us-east-1.rds.amazonaws.com' #i.e. # i.e. 'ec2-54-83-201-96.compute-1.amazonaws.com'  
  
  db_port <- '5432'  # or any other port specified by the DBA
  
  db_user <- 'postgres'
  
  db_password <- 'Janj2910!'
  
  con <- dbConnect(RPostgres::Postgres(), dbname = db, host=host_db, port=db_port, user=db_user, password=db_password)  
  
 }
  
  ## Adding Queries
   { 
    ## Products 
      {
      products <- dbGetQuery(con, "SELECT * FROM products where type <> 'Part'")
      products$identifier = paste(products$id, products$type,  products$manufacturer_sku, products$name, products$manufacturer,"\n", "Variation: ",products$variation, "\n","Group Heads: ",products$group_heads,"\n", "Configuration: ",products$configuration)
      products <- data.frame(products)
  }
    
    ## Technician
      {
      technicians <- dbGetQuery(con, "SELECT * FROM technicians")
      technicians$full_name = paste(technicians$id, technicians$first_name, technicians$last_name)
      technicians = data.frame(technicians)
      }
    
    ## Customers 
      {
      customers <- dbGetQuery(con, "SELECT * FROM customers")
      customers$identifier = paste(customers$id,  customers$customer_name, customers$address)
      customers <- data.frame(customers)
      }
     
    ## Reports
     {
     report <- dbGetQuery(con, "SELECT * FROM reports r join customers c on r.customer_id = c.id ")
     report$identifier = paste(report$id,  report$customer_name, report$address, report$on_site_date)
     reports <- data.frame(customers)
     }
  
  } 
  
  ## UI Customer, Technician, and Product Outputs
    {     
    ## Pre-Installation
     {
  output$pre_customer_id <- renderUI({selectInput(inputId = 'pre_customer_id',
                                                  label = 'Customer', 
                                                  choices = c('',customers$identifier),
                                                    selected = F, multiple = F)
  })
  
  output$pre_technician_id <- renderUI({selectInput(inputId = 'pre_technician_id',
                                                    label = 'Technician', 
                                                    choices = c('',technicians$full_name),
                                                    selected = F, multiple = F)
  })
      }
    ##Installation 
     {
  
    output$install_customer_id <- renderUI({selectInput(inputId = 'install_customer_id',
                                                        label = 'Customer', 
                                                        choices = c('',customers$identifier), 
                                                        selected = F, multiple = F)
    })
    
    output$install_technician_id <- renderUI({selectInput(inputId = 'install_technician_id',
                                                          label = 'Technician',
                                                          choices = c('',technicians$full_name),
                                                          selected = F, multiple = F)
    })
    
    output$install_product <- renderUI({selectInput(inputId = 'install_product',
                                                    label = 'Product',
                                                    choices = c('',products$identifier),
                                                    selected = F, multiple = F)
    })
       
    output$install_pre_id <- renderUI({selectInput(inputId = 'install_pre_id',
                                                        label = 'Pre-Installation Report ID',
                                                        choices = c('',report$identifier),
                                                        selected = F, multiple = F)
      }) }
    ## PM 
     {
  output$annual_customer_id <- renderUI({selectInput(inputId = 'pm_customer_id',
                                                     label = 'Customer',
                                                     choices = c('',customers$identifier),
                                                     selected = F, multiple = F)
  })
  
  output$annual_technician_id <- renderUI({selectInput(inputId = 'pm_technician_id',
                                                       label = 'Technician', 
                                                       choices = c('',technicians$full_name),
                                                       selected = F, multiple = F)
  })
  
  output$pm_product_1 <- renderUI({selectInput(inputId = 'pm_product_1',
                                               label = 'Product',
                                               choices = c('',products$identifier),
                                               selected = F, multiple = F)
  })
  }
    ## Reactive
     {
  output$reactive_customer_id <- renderUI({selectInput(inputId = 'reactive_customer_id',
                                                       label = 'Customer',
                                                       choices = c('',customers$identifier),
                                                       selected = F, multiple = F)
  })
  
  output$reactive_technician_id <- renderUI({selectInput(inputId = 'reactive_technician_id',
                                                         label = 'Technician',
                                                         choices = c('',technicians$full_name),
                                                         selected = F, multiple = F)
  })
  
  output$reactive_product_1 <- renderUI({selectInput(inputId = 'reactive_product_1',
                                                     label = 'Product',
                                                     choices = c('',products$identifier),
                                                     selected = F, multiple = F)
  })
}
    ## Water
     {

  
  output$water_report_id <- renderUI({selectInput(inputId = 'water_report',
                                                 label = 'Report ID',
                                                 choices = c('',report$identifier),
                                                 selected = F, multiple = F)
  })
     }

      
      }
  
  #Insert  Queries
    ## Technician 
     { tech_query = renderText({paste0('INSERT INTO technicians(
        first_name,
        last_name,
        address,
        city,
        state_code,
        country_code,
        zip_code,
        phone_number,
        vera_affiliation
      )
      VALUES (',
         "'",                            
        input$tech_fname,"'",  ',' , "'", 
        input$tech_lname, "'",  ',' , "'", 
        input$tech_address, "'",  ',' , "'", 
        input$tech_city, "'",  ',' , "'", 
        input$tech_state, "'",  ',' , "'", 
        input$tech_country, "'",  ',' , "'", 
        input$tech_zip, "'",  ',' , "'", 
        input$tech_phone, "'",  ',' , 
        input$tech_affiliation, 
      ')')
    })
      observeEvent(input$submit_tech,dbSendQuery(con,tech_query()))
      tech_update <- eventReactive(input$submit_tech, tech_query())
      tech_reply <- eventReactive(input$submit_tech, "Your Submission Has Been Recieved. Thank you.")
      output$tech_output <- renderText({tech_reply()})
      observeEvent(input$submit_tech, {
        shinyjs::reset("form")
      })
  }
    ## Customer
     {
      cust_query = renderText({paste0('INSERT INTO customers(
        customer_name,
        address,
        city,
        state_code,
        country_code,
        zip_code,
        phone_number
      )
      VALUES (',
         "'",
        input$cust_name,"'",  ',' , "'",
        input$cust_address,"'",  ',' , "'",
        input$cust_city,"'",  ',' , "'",
        input$cust_state,"'",  ',' , "'",
        input$cust_country,"'",  ',' , "'",
        input$cust_zip,"'",  ',' , "'",
        input$cust_phone,"'", 
        ')')
        })
      observeEvent(input$submit_cust,dbSendQuery(con,cust_query()))
      cust_reply <- eventReactive(input$submit_cust, "Your Submission Has Been Recieved. Thank you.")
      cust_update <- eventReactive(input$submit_cust, cust_query())
      output$cust  <- renderText({cust_reply()})
      observeEvent(input$submit_cust, {
        shinyjs::reset("cust_form")
      })
  }
   ## Product 
     {
    prod_query = renderText({paste0('INSERT INTO products (
     name,
     sku,
     manufacturer,
     price,
     cost
    )
   VALUES(',
        "'",
     input$prod_name,"'",  ',' , "'",
     input$prod_sku,"'",  ',' , "'",
     input$prod_manu,"'",  ',' , "'",
     input$prod_price,  ',' , 
     input$prod_cost,
     ')'
   )})
    observeEvent(input$submit_prod,dbSendQuery(con,prod_query()))
    prod_reply <- eventReactive(input$prod_cust, "Your Submission Has Been Recieved. Thank you.")
    output$prod <- renderText({prod_reply()})
    observeEvent(input$submit_prod, {
      shinyjs::reset("form")
    })
     }
   ## Pre-Installation Report
     {pre_install_query = reactive({paste0('INSERT INTO reports (
        customer_id,
        technician_id,
        on_site_date,
        duration,
        notes,
        report_type
      )
      VALUES (',
           as.numeric(scan(text = input$pre_customer_id, what = " ")[1]), ',' ,
           as.numeric(scan(text = input$pre_technician_id, what = " ")[1]),  ',' , "'", 
           input$pre_on_site_date,"'", ',' ,
           input$pre_duration,  ',' , "'", 
           input$pre_notes, "'", ',' , "'", 
           "Pre-Installation", "'",
           ') RETURNING id')
    })
    
    
    report_id_result = eventReactive(input$pre_submit, dbGetQuery(con,pre_install_query()))
   
    pre_install_reply <- renderText({report_id_result()$id})
      
    output$pre_install <- renderText(paste0("Your Submission Has Been Received. The Pre-installation Report Id is ",
                   pre_install_reply() ,". Please keep this for your records. Thank you."))
    
    observeEvent(input$pre_submit, {
     shinyjs::reset("pre-form")
    })
    }
   ## Installation Report
     {
  install_report_query = reactive({paste0('INSERT INTO reports (
        customer_id,
        technician_id,
        pre_installation_report_id,
        on_site_date,
        notes,
        voltage_reading,
        psi_reading,
        observed_scale,
        groundhead_temp,
        pm_schedule,
        filter_replaced,
        next_filter_repair,
        duration,
        report_type
      )
     VALUES (',
                                        as.numeric(scan(text = input$install_customer_id, what = " ")[1]), ',' ,
                                        as.numeric(scan(text = input$install_technician_id, what = " ")[1]),  ',' , 
                                        as.numeric(scan(text = input$install_pre_id, what = " ")[1]),  ',' , "'",
                                        input$install_date_entered,"'", ',' , "'",
                                        input$install_notes, "'", ',' ,
                                        input$install_volts,',' ,
                                        input$install_psi,',' ,
                                        input$install_scale, ',' ,
                                        input$install_gt, ',' , "'",
                                        input$install_pm_schedule, "'", ',' ,
                                        input$install_filter, ',' , "'",
                                        input$install_filter_date, "'", ',' ,
                                        input$install_duration,  ',' , "'",
                                        "Installation", "'",
                                        ') RETURNING id')
  })
  
  install_report_id_result = eventReactive(input$install_submit, dbGetQuery(con,install_report_query()))
  
  install_reply <- renderText({install_report_id_result()$id})
  
  install_jobs_query = reactive({paste0(
    "INSERT INTO jobs (
        job_type,
        report_id,
        product_id,
        product_serial_number,
        product_manufacturer_invoice_date,
        qty,
        start_date
      )
     VALUES (",
                 "'",'Installation',"'",",",
                 install_reply(), ",",
                 as.numeric(scan(text = input$install_product, what = " ")[1]),",","'",
                 input$install_serial,"'",",","'",
                 input$install_manufacturer_invoice_date, "'", ",",
                 input$install_quantity, ",","'",
                 input$install_date_entered, "'",
                 ")")
    
    
    
  })
    
    observeEvent(input$install_submit, dbSendQuery(con,install_jobs_query()))
    
    output$install <- renderText(
      paste0("Your Submission Has Been Received. The Installation Report Id is ",
                                              install_reply() ,". Please keep this for your records. Thank you."))

    observeEvent(input$install_submit, {
      shinyjs::reset("install-form")
    })
     }
   ## Water Quality
     {wq_query = reactive({paste0(
    "INSERT INTO water_analysis (
      date_results,
      report_id,
      pre_or_post_filtration,
      alkalinity,
      ammonia,
      nacl,
      dpd1,
      dpd4,
      cu2,
      caco3,
      no3,
      ph,
      phosphate)
       values (", "'", 
    
                    input$water_analysis_date,"'",',',
                    as.numeric(scan(text = input$water_report, what = " ")[1]),
                    input$water_filter, ',' ,
                    input$alk,',' ,
                    input$ammonia,',' ,
                    input$nacl,',' ,
                    input$dpd1, ',' ,
                    input$dpd4, ',' ,
                    input$cu2,',' ,
                    input$caco3,',' ,
                    input$no3,',' ,
                    input$no2,',' ,
                    input$ph,',' ,
                    input$phosphate, ")"
      )})
    
    observeEvent(input$water_submit,dbSendQuery(con,wq_query()))
    wq_reply <- eventReactive(input$water_submit, "Your Water Quality Report Has Been Recieved. Thank you.")
    output$wq_output <- renderText({wq_reply()})
    observeEvent(input$water_submit, {
      shinyjs::reset("wq_form")
    })
   }
   ## Reactive
     { reactive_report_query = reactive({paste0('INSERT INTO reports (
        customer_id,
        technician_id,
        on_site_date,
        notes,
        recommendations,
        voltage_reading,
        psi_reading,
        observed_scale,
        groundhead_temp,
        pm_schedule,
        filter_replaced,
        next_filter_repair,
        duration,
        report_type
      )
     VALUES (',
                                            as.numeric(scan(text = input$reactive_customer_id, what = " ")[1]), ',' ,
                                            as.numeric(scan(text = input$reactive_technician_id, what = " ")[1]),  ',' ,"'",
                                            input$reactive_date_entered,"'", ',' , "'",
                                            input$reactive_notes, "'", ',' , "'",
                                            input$reactive_recs, "'", ',',
                                            input$reactive_volts,',' ,
                                            input$reactive_psi,',' ,
                                            input$reactive_scale, ',' ,
                                            input$reactive_gt, ',' , "'",
                                            input$reactive_pm_schedule, "'", ',' ,
                                            input$reactive_filter, ',' , "'",
                                            input$reactive_filter_date, "'", ',' ,
                                            input$reactive_duration,  ',' , "'",
                                            "Reactive", "'",
                                            ') RETURNING id')
  })
    
    reactive_report_id_result = eventReactive(input$reactive_submit, dbGetQuery(con,reactive_report_query()))
    
    reactive_reply <- renderText({reactive_report_id_result()$id})
    
    reactive_jobs_query = reactive({paste0(
      "INSERT INTO jobs (
        job_type,
        report_id,
        product_id,
        product_serial_number,
        machine_downtime_days,
        start_date
      )
     VALUES (",
      "'",'Reactive',"'",",",
      reactive_reply(), ",",
      as.numeric(scan(text = input$reactive_product_1, what = " ")[1]),",","'",
      input$reactive_serial,"'",",",
      input$reactive_downtime, ',' ,"'", 
      input$reactive_date_entered, "'",
      ")")
      
      
      
    })
    
    observeEvent(input$reactive_submit, dbSendQuery(con,reactive_jobs_query()))
    
    output$reactive_output <- renderText(
      paste0("Your Submission Has Been Received. The Reactive Service Call Report Id is ",
             reactive_reply() ,". Please keep this for your records. Thank you."))
    
    observeEvent(input$reactive_submit, {
      shinyjs::reset("reactive_form")
  
    })
    
    
  }
   ## PM
  { pm_report_query = reactive({paste0('INSERT INTO reports (
        customer_id,
        technician_id,
        on_site_date,
        notes,
        recommendations,
        voltage_reading,
        psi_reading,
        observed_scale,
        groundhead_temp,
        pm_schedule,
        filter_replaced,
        next_filter_repair,
        duration,
        report_type
      )
     VALUES (',
                                               as.numeric(scan(text = input$pm_customer_id, what = " ")[1]), ',' ,
                                               as.numeric(scan(text = input$pm_technician_id, what = " ")[1]),  ',' ,"'",
                                               input$pm_date_entered,"'", ',' , "'",
                                               input$pm_notes, "'", ',' , "'",
                                               input$pm_recs, "'", ',',
                                               input$pm_volts,',' ,
                                               input$pm_psi,',' ,
                                               input$pm_scale, ',' ,
                                               input$pm_gt, ',' , "'",
                                               input$pm_pm_schedule, "'", ',' ,
                                               input$pm_filter, ',' , "'",
                                               input$pm_filter_date, "'", ',' ,
                                               input$pm_duration,  ',' , "'",
                                               "PM", "'",
                                               ') RETURNING id')
  })
  
  pm_report_id_result = eventReactive(input$pm_submit, dbGetQuery(con,pm_report_query()))
  
  pm_reply <- renderText({pm_report_id_result()$id})
  
  pm_jobs_query = reactive({paste0(
    "INSERT INTO jobs (
        job_type,
        report_id,
        product_id,
        product_serial_number,
        start_date
      )
     VALUES (",
    "'",'PM',"'",",",
    pm_reply(), ",",
    as.numeric(scan(text = input$pm_product_1, what = " ")[1]),",","'",
    input$pm_serial,"'",",","'",
    input$pm_date_entered, "'",
    ")")
    
    
    
  })
  
  observeEvent(input$pm_submit, dbSendQuery(con,pm_jobs_query()))
  
  output$pm_output <- renderText(
    paste0("Your Submission Has Been Received. The PM Report Id is ",
           pm_reply() ,". Please keep this for your records. Thank you."))
  
  observeEvent(input$pm_submit, {
    shinyjs::reset("pm_form")
    
  })
  }
  
    
  }



# Run the application
shinyApp(ui = ui, server = server)
