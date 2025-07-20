
library(shiny)
library(DT)

# Source logic
source("knn.r")

ui <- fluidPage(
  titlePanel("🌸 KNN Classifier on Iris Dataset"),

  sidebarLayout(
    sidebarPanel(
      sliderInput("k", "Choose value of K:", min = 1, max = 15, value = 3, step = 1),
      actionButton("run", "Run Model"),
      hr(),
      h4("🔍 Accuracy:"),
      verbatimTextOutput("accuracy"),
      h4("🎯 Precision:"),
      verbatimTextOutput("precision"),
      h4("📢 Recall:"),
      verbatimTextOutput("recall"),
      h4("📘 F1 Score:"),
      verbatimTextOutput("f1"),
      h4("📏 Kappa:"),
      verbatimTextOutput("kappa")
    ),

    mainPanel(
      tabsetPanel(
        tabPanel("📊 Confusion Matrix", verbatimTextOutput("conf")),
        tabPanel("📋 Confusion Details", verbatimTextOutput("conf_details")),
        tabPanel("📈 Predictions", DTOutput("results"))
      )
    )
  )
)

server <- function(input, output, session) {
  results <- eventReactive(input$run, {
    run_knn(input$k)
  })

  output$accuracy <- renderText({
    req(results())
    paste0(round(results()$accuracy * 100, 2), " %")
  })

  output$precision <- renderText({
    req(results())
    paste(
      sprintf("%-10s | Precision: %.3f", gsub("Class: ", "", names(results()$precision)), results()$precision),
      collapse = "\n"
    )
  })

  output$recall <- renderText({
    req(results())
    paste(
      sprintf("%-10s | Recall: %.3f", gsub("Class: ", "", names(results()$recall)), results()$recall),
      collapse = "\n"
    )
  })

  output$f1 <- renderText({
    req(results())
    paste(
      sprintf("%-10s | F1 Score: %.3f", gsub("Class: ", "", names(results()$f1)), results()$f1),
      collapse = "\n"
    )
  })

  output$kappa <- renderText({
    req(results())
    paste0("Kappa: ", round(results()$kappa, 3))
  })

  output$conf <- renderText({
    req(results())
    paste(capture.output(print(results()$confusion)), collapse = "\n")
  })

  output$conf_details <- renderText({
    req(results())
    paste(results()$confusion_details, collapse = "\n")
  })

  output$results <- renderDT({
    req(results())
    datatable(
      data.frame(
        Actual = results()$test_labels,
        Predicted = results()$knn_pred
      ),
      options = list(pageLength = 10),
      class = "display nowrap compact",
      rownames = FALSE
    )
  })
}

shinyApp(ui, server)
