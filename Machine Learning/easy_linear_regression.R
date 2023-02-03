
data(iris)

head(iris)

# base R graphics
plot(
  x = iris$Petal.Length,
  y = iris$Petal.Width,
  main = 'Iris Petal Lenght vs. Width',
  xlab = 'Petal Length (cm)',
  ylab = 'Petal Width (cm)'
)

# create a linear regression model
model <- lm(
  formula = Petal.Width ~ Petal.Length,
  data = iris
)

# summarize the model
summary(model)

# draw regression line on plot
lines(
  x = iris$Petal.Length,
  y = model$fitted.values,
  col = 'red',
  lwd = 3
)

# correlation coefficient
cor(
  iris$Petal.Length,
  iris$Petal.Width
)

# predict new values from the model
predict(
  model,
  data.frame(
    Petal.Length = c(2, 5, 7)
  )
)








