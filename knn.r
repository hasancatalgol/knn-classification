
library(class)
library(caret)

run_knn <- function(k) {
  data(iris)

  # Normalize features
  normalize <- function(x) {
    return((x - min(x)) / (max(x) - min(x)))
  }
  iris_norm <- as.data.frame(lapply(iris[1:4], normalize))
  iris_norm$Species <- iris$Species

  # Train/test split
  set.seed(123)
  sample_index <- sample(1:nrow(iris_norm), size = 0.8 * nrow(iris_norm))
  train_data <- iris_norm[sample_index, ]
  test_data <- iris_norm[-sample_index, ]

  train_features <- train_data[, 1:4]
  train_labels <- train_data$Species
  test_features <- test_data[, 1:4]
  test_labels <- test_data$Species

  # KNN
  knn_pred <- knn(train = train_features, test = test_features, cl = train_labels, k = k)

  # Evaluation
  cm <- confusionMatrix(knn_pred, test_labels)
  accuracy <- sum(diag(cm$table)) / sum(cm$table)
  precision <- cm$byClass[,"Precision"]
  recall <- cm$byClass[,"Recall"]
  f1 <- cm$byClass[,"F1"]
  kappa <- cm$overall["Kappa"]

  return(list(
    accuracy = accuracy,
    confusion = cm$table,
    confusion_details = capture.output(cm),
    test_labels = test_labels,
    knn_pred = knn_pred,
    precision = precision,
    recall = recall,
    f1 = f1,
    kappa = kappa
  ))
}
