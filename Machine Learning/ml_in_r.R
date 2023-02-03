# machine learning in R

data(iris)

set.seed(42)

# randomly sample 100 of 150 rows of indexes
indexes <- sample(
  x = 1:150,
  size = 100
)

print(indexes)

# create training data set
train <- iris[indexes, ]

# create test data set
test <- iris[-indexes, ]

library(tree)

# train model
model <- tree(
  Species ~ .,
  train
)

# inspect model
summary(model)

# visualize decision tree
plot(model)
text(model)

# load color brewer
library(RColorBrewer)

# create color palette for color blindness
palette <- brewer.pal(3, 'Set2')

# create scatterplot colored by species
plot(
  iris$Petal.Length,
  iris$Petal.Width,
  pch = 19,
  col = palette[as.numeric(iris$Species)],
  main = 'Iris Petal Length vs. Width',
  xlab = 'Petal Length (cm)',
  ylab = 'Petal Width (cm)'
)

# plot decision tree boundaries
partition.tree(
  snip.tree(
    model,
    nodes = c(12, 7)),
  label = 'Species',
  add = TRUE
)

# predict with the model
predictions <-  predict(
  model,
  test,
  type = 'class'
)

# create confusion matrix
table(
  x = predictions,
  y = test$Species
)

library(caret)

# evaluate prediciton results

confusionMatrix(
  predictions,
  test$Species
)

# save model
save(model, file = 'Tree.RData')


















