library(shiny)
library(shinythemes)
library(DBI)



db <- 'postgres'  #provide the name of your db

host_db <- '' #i.e. # i.e. 'ec2-54-83-201-96.compute-1.amazonaws.com'  

db_port <- '5432'  # or any other port specified by the DBA

db_user <- 'postgres'

db_password <- 'password'

# con <- dbConnect(RPostgres::Postgres(), dbname = db, host=host_db, port=db_port, user=db_user, password=db_password)  


# Define UI for application that draws a histogram
ui <- shinyUI(
  fluidPage(
    theme = shinytheme("cosmo"),
    title = "Vera Data Collection",
    
    h1('What are you looking to do?'),
    
    selectInput(
      "filing",
      "Filing Type",
      c(
        `Submit Report` = "report",
        `Add Technician` = "tech",
        `Add Product` = 'product',
        `Add Customer` = 'customer'), selected = NULL
    ),
      
    conditionalPanel(condition = "input.filing == 'tech'",
                     h1("Adding a New Technician"),
                     div(tags$hr()),
                fluidRow(column(3,
                     
                    textInput(inputId = 'fname',
                              label = 'First Name'),
    
                    textInput(inputId = 'lname',
                              label = 'Last Name'),
                    
                    textInput(inputId = 'address',
                              label = 'Working From Address'),
              
                    textInput(inputId = 'city',
                              label = 'City/Town')),
                    
               column(3, offset = 1,
                    
                    textInput(inputId = 'state',
                              label = 'State - 2 letter code'),
    
                    textInput(inputId = 'country',
                              label = 'Country - 2 letter code'),
                    
                    textInput(inputId = 'zip',
                              label = 'Zip Code'),
    
                    textInput(inputId = 'phone',
                              label = 'Phone Number'),
    
                    selectInput(
                      "affiliation",
                      "Vera Affiliated?",
                      c(
                        True = "True",
                        False = "False")
                    ),
                    br(),
                    actionButton(
                      inputId = 'submit',
                      label = 'Submit New Technician',
                      icon = NULL,
                      width = NULL
                    )))),
    
    conditionalPanel(condition = "input.filing == 'customer'",
                     h1("Adding a New Customer"),
                     div(tags$hr()),
                     fluidRow(column(3,
                                     
                                     textInput(inputId = 'name',
                                               label = 'Customer Name'),
                                     
                                     textInput(inputId = 'address',
                                               label = 'Working From Address'),
                                     
                                     textInput(inputId = 'city',
                                               label = 'City/Town'),
                                     
                                     textInput(inputId = 'state',
                                               label = 'State - 2 letter code')),
                              
                              column(3, offset = 1,
                                     
                                     textInput(inputId = 'country',
                                               label = 'Country - 2 letter code'),
                                     
                                     textInput(inputId = 'zip',
                                               label = 'Zip Code'),
                                     
                                     textInput(inputId = 'phone',
                                               label = 'Phone Number'),
                                     
                                     br(),
                                     actionButton(
                                       inputId = 'submit',
                                       label = 'Submit New Customer',
                                       icon = NULL,
                                       width = NULL
                                     )))),
                    
    conditionalPanel(condition = "input.filing == 'product'",
                     h1("Adding a New Product"),
                     div(tags$hr()),
                     
                     textInput(inputId = 'name', label = 'Product Name'),
                     
                     textInput(inputId = 'sku', label = 'SKU#'),
                     
                     textInput('manu', label = 'Manufacturer'),
                     
                     textInput('serial', 'Serial Number'),
                     
                     dateInput(
                       inputId = 'date_manufactured',
                       label = 'Date Manufactured',
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
                     
                     textInput('invoice', 'Invoice Number'),
                     
                     dateInput(
                       inputId = 'date_invoice',
                       label = 'Date Product Invoice Recieved',
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
                     br(),
                     actionButton(
                       inputId = 'submit',
                       label = 'Add New Product',
                       icon = NULL,
                       width = NULL
                     )),
    
    
    conditionalPanel(condition = "input.filing == 'report'",
    h1("Filing a Report"),
    selectInput(
      "reportType",
      "Report Type",
      c(
        `Pre-install Report` = "pre",
        `Install Report` = "install",
        `BiAnnual PM` = 'bi',
        `Annual PM` = 'annual',
        `Reactive Service Call` = 'reactive'
      )
    ),
    
    div(tags$hr()),
    
    
    conditionalPanel(condition = "input.reportType == 'pre'",
                     
                     fluidRow(
                       column(
                         3,
                         
                         h3(tags$b('Business Data')),
                         
                         dateInput(
                           inputId = 'date_entered',
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
                         
                         textInput(inputId = 'business_address',
                                   label = 'Business Address'),
                         
                         textInput(inputId = 'customer_id',
                                   label = 'Customer ID'),
                         
                         textInput(inputId = 'technician_id',
                                   label = 'Technician ID'),
                         
                         numericInput(
                           inputId = 'Amps',
                           label = 'Circuit Amperage',
                           value = NULL
                         ),
                         
                         numericInput(
                           inputId = 'Volts',
                           label = 'Voltage' ,
                           value = NULL
                         ),
                         
                         numericInput(
                           inputId = 'psi',
                           label = 'Guage Reading (PSI)',
                           value = NULL
                         ),
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
                         )
                       ),
                       
                       column(
                         4,
                         offset = 1,
                         
                         
                         h3(tags$b('Pre-Filration Water Analysis')),
                         
                         
                         numericInput(
                           inputId = 'alk',
                           label = 'Alkalinity, Total - Drinking',
                           value = NULL
                         ),
                         
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
                         ),
                         
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
                         )
                       ),
                       
                       column(
                         4,
                         
                         h3(tags$b('Post-Filration Water Analysis')),
                         
                         numericInput(
                           inputId = 'alk',
                           label = 'Alkalinity, Total - Drinking',
                           value = NULL
                         ),
                         
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
                         ),
                         
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
                         )
                         
                       )
                     )),
    
    conditionalPanel(condition = "input.reportType == 'install'",
                     
                     fluidRow(
                       column(
                         3,
                         
                         h3(tags$b('Business Data')),
                         
                         dateInput(
                           inputId = 'date_entered',
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
                         
                         textInput(inputId = 'business_address', label = 'Business Address'),
                         
                         textInput(inputId = 'customer_id', label = 'Customer ID'),
                         
                         textInput(inputId = 'technician_id', label = 'Technician ID'),
                         
                         numericInput(
                           inputId = 'Amps',
                           label = 'Circuit Amperage',
                           value = NULL
                         ),
                         
                         numericInput(
                           inputId = 'Volts',
                           label = 'Voltage' ,
                           value = NULL
                         ),
                         
                         numericInput(
                           inputId = 'psi',
                           label = 'Guage Reading (PSI)',
                           value = NULL
                         ),
                         
                         textInput(inputId = 'notes', label = 'Notes')
                       ),
                       
                       column(
                         4,
                         offset = 1,
                         
                         
                         h3(tags$b('Post-Filration Water Analysis')),
                         
                         
                         numericInput(
                           inputId = 'nacl',
                           label = 'Chloride (as NaCl)',
                           value = NULL
                         ),
                         
                         numericInput(
                           inputId = 'caco3',
                           label = 'Hardness, Total HR (as CaCO3)',
                           value = NULL
                         ),
                         
                         numericInput(
                           inputId = 'ph',
                           label = 'pH, BT - Fresh',
                           value = NULL
                         )
                       ),
                       
                       
                       
                       column(
                         4,
                         
                         h3(tags$b('Machine Information')),
                         
                         textInput(inputId = 'er', label = 'Electrical Receptacle'),
                         
                         textInput(inputId = 'ws', label = 'Water Supply Fitting'),
                         
                         textInput(inputId = 'em', label = 'Equipment Manufacturer'),
                         
                         textInput(inputId = 'model', label = 'Model'),
                         
                         textInput(inputId = 'invoicenum', label = 'Manufacturer Invoice #'),
                         
                         dateInput(
                           inputId = 'manufacture_date',
                           label = 'Manufacture Date',
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
                         
                         dateInput(
                           inputId = 'invoice_date',
                           label = 'Invoice Date',
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
                         textInput(inputId = 'sku', label = 'SKU #'),
                         
                         textInput(inputId = 'pmsched', label = 'PM Schedule'),
                         
                         textInput(inputId = 'filter', label = 'Filter Schedule'),
                         
                         textInput(inputId = 'serial', label = 'Serial Number')
                         
                         
                         
                       )
                       
                     )),
    
    conditionalPanel(
      condition = "input.reportType == 'annual'",
      
      fluidRow(
        column(
          3,
          
          h3(tags$b('Business Data')),
          
          dateInput(
            inputId = 'date_entered',
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
          
          textInput(inputId = 'business_address', label = 'Business Address'),
          
          textInput(inputId = 'customer_id', label = 'Customer ID'),
          
          textInput(inputId = 'technician_id', label = 'Technician ID'),
          
          numericInput(
            inputId = 'Amps',
            label = 'Circuit Amperage',
            value = NULL
          ),
          
          numericInput(
            inputId = 'Volts',
            label = 'Voltage' ,
            value = NULL
          ),
          
          numericInput(
            inputId = 'psi',
            label = 'Guage Reading (PSI)',
            value = NULL
          ),
          
          numericInput(
            inputId = 'duration',
            label = 'Duration',
            value = NULL
          ),
          
          selectInput("scale", "Evidence of Scale",
                      c(Yes = 'yes', No = 'no')),
          
          textInput(inputId = 'gt', label = 'Grouphead Temp'),
          
          textInput(inputId = 'duration', label = 'Service Call Duration'),
          
          textInput(inputId = 'notes', label = 'Notes')
        ),
        
        column(
          4,
          offset = 1,
          
          
          h3(tags$b('Post-Filration Water Analysis')),
          
          numericInput(
            inputId = 'alk',
            label = 'Alkalinity, Total - Drinking',
            value = NULL
          ),
          
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
          ),
          
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
          )
        ),
        
        column(
          4,
          
          h3(tags$b('Service Information')),
          
          textInput(inputId = 'rp', label = 'Replaced Part ID(s)'),
          
          numericInput(inputId = 'pq', label = 'Part Quantity',
                       value = NULL),
          
          numericInput(inputId = 'cost', label = 'Part Cost',
                       value = NULL),
          
          textInput(inputId = 'sympt', label = 'Symptoms'),
          
          textInput(inputId = 'num', label = 'Invoice #'),
          
          numericInput(inputId = 'value', label = 'Invoice Value Pre-Tax',value = NULL),
          
          selectInput(
            "replace",
            "Filter Replaced",
            c(Yes = "yes",
              No = "no")),
            
            dateInput(
              inputId = 'next_filter',
              label = 'Next Filter Replace Schedule',
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
            
            textInput(inputId = 'recs', label = 'Recommendations')
            
            
            
          )
          
        )),
      
    conditionalPanel(
      condition = "input.reportType == 'bi'",
      
      fluidRow(
        column(
          3,
          
          h3(tags$b('Business Data')),
          
          dateInput(
            inputId = 'date_entered',
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
          
          textInput(inputId = 'business_address', label = 'Business Address'),
          
          textInput(inputId = 'customer_id', label = 'Customer ID'),
          
          textInput(inputId = 'technician_id', label = 'Technician ID'),
          
          numericInput(
            inputId = 'Amps',
            label = 'Circuit Amperage',
            value = NULL
          ),
          
          numericInput(
            inputId = 'Volts',
            label = 'Voltage' ,
            value = NULL
          ),
          
          numericInput(
            inputId = 'psi',
            label = 'Guage Reading (PSI)',
            value = NULL
          ),
          
          numericInput(
            inputId = 'duration',
            label = 'Duration',
            value = NULL
          ),
          
          selectInput("scale", "Evidence of Scale",
                      c(Yes = 'yes', No = 'no')),
          
          textInput(inputId = 'gt', label = 'Grouphead Temp'),
          
          textInput(inputId = 'duration', label = 'Service Call Duration'),
          
          textInput(inputId = 'notes', label = 'Notes')
        ),
        
        column(
          4,
          offset = 1,
          
          
          h3(tags$b('Post-Filration Water Analysis')),
          
          
          numericInput(
            inputId = 'nacl',
            label = 'Chloride (as NaCl)',
            value = NULL
          ),
          
          numericInput(
            inputId = 'caco3',
            label = 'Hardness, Total HR (as CaCO3)',
            value = NULL
          ),
          
          numericInput(
            inputId = 'ph',
            label = 'pH, BT - Fresh',
            value = NULL
          )
        ),
        
        column(
          4,
          
          h3(tags$b('Service Information')),
          
          textInput(inputId = 'rp', label = 'Replaced Part ID(s)'),
          
          numericInput(inputId = 'pq', label = 'Part Quantity',
                       value = NULL),
          
          numericInput(inputId = 'cost', label = 'Part Cost',
                       value = NULL),
          
          textInput(inputId = 'sympt', label = 'Symptoms'),
          
          textInput(inputId = 'num', label = 'Invoice #'),
          
          numericInput(inputId = 'value', label = 'Invoice Value Pre-Tax',value = NULL),
          
          selectInput(
            "replace",
            "Filter Replaced",
            c(Yes = "yes",
              No = "no")),
          
          dateInput(
            inputId = 'next_filter',
            label = 'Next Filter Replace Schedule',
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
          
          textInput(inputId = 'recs', label = 'Recommendations')
          
          
          
        )
                       )) ,
      
    conditionalPanel(
      condition = "input.reportType == 'reactive'",
      
      fluidRow(
        column(
          3,
          
          h3(tags$b('Business Data')),
          
          dateInput(
            inputId = 'date_entered',
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
          
          textInput(inputId = 'business_address', label = 'Business Address'),
          
          textInput(inputId = 'customer_id', label = 'Customer ID'),
          
          textInput(inputId = 'technician_id', label = 'Technician ID'),
          
          numericInput(
            inputId = 'Amps',
            label = 'Circuit Amperage',
            value = NULL
          ),
          
          numericInput(
            inputId = 'Volts',
            label = 'Voltage' ,
            value = NULL
          ),
          
          numericInput(
            inputId = 'psi',
            label = 'Guage Reading (PSI)',
            value = NULL
          ),
          
          numericInput(
            inputId = 'duration',
            label = 'Duration',
            value = NULL
          ),
          
          selectInput("scale", "Evidence of Scale",
                      c(Yes = 'yes', No = 'no')),
          
          textInput(inputId = 'gt', label = 'Grouphead Temp'),
          
          textInput(inputId = 'duration', label = 'Service Call Duration'),
          
          textInput(inputId = 'notes', label = 'Notes')
        ),
        
        column(
          4,
          offset = 1,
          
          
          h3(tags$b('Post-Filration Water Analysis')),
          
          
          numericInput(
            inputId = 'nacl',
            label = 'Chloride (as NaCl)',
            value = NULL
          ),
          
          numericInput(
            inputId = 'caco3',
            label = 'Hardness, Total HR (as CaCO3)',
            value = NULL
          ),
          
          numericInput(
            inputId = 'ph',
            label = 'pH, BT - Fresh',
            value = NULL
          )
        ),
        
        column(
          4,
          
          h3(tags$b('Service Information')),
          
          textInput(inputId = 'rp', label = 'Replaced Part ID(s)'),
          
          numericInput(inputId = 'pq', label = 'Part Quantity',
                       value = NULL),
          
          numericInput(inputId = 'cost', label = 'Part Cost',
                       value = NULL),
          
          textInput(inputId = 'sympt', label = 'Symptoms'),
          
          textInput(inputId = 'num', label = 'Invoice #'),
          
          numericInput(inputId = 'value', label = 'Invoice Value Pre-Tax',value = NULL),
          
          selectInput(
            "replace",
            "Filter Replaced",
            c(Yes = "yes",
              No = "no")),
          
          dateInput(
            inputId = 'next_filter',
            label = 'Next Filter Replace Schedule',
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
          
          numericInput(inputId = 'downtime', label = 'Machine Downtime (days)',value = NULL),
          
          selectInput(
            "repaired",
            "Repaired?",
            c(Yes = "yes",
              No = "no")),
          
          selectInput(
            "followup",
            "Follow Up Required?",
            c(Yes = "yes",
              No = "no")),
          
          textInput(inputId = 'recs', label = 'Recommendations')
          
          
          
        )
                         
                       )),
    
    
    
    
    br(),
    br(),
    
    fluidRow(column(3, offset = 8,
                    
    actionButton(
      inputId = 'submit',
      label = 'Submit Report',
      icon = NULL,
      width = NULL
    ))),
    
    br(),
    
    div(tags$hr()),
    
    br())
  )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  
}

# Run the application
shinyApp(ui = ui, server = server)
