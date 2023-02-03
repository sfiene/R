# Qualitative Univariate Data Visualization
movies <- read.csv('Movies.csv')
head(movies)

# Univariate Visualizations for qualitative variable
# single categorical variable

movies$Rating <- as.factor(movies$Rating)
str(movies)

# base R plotting
# frequency bar chart
plot(
  x = movies$Rating,
  main = 'Count of Movies by Rating',
  xlab = 'Rating',
  ylab = 'Count of Movies'
)  

# horizontal bar chart
plot(
  x = movies$Rating,
  horiz = TRUE,
  main = 'Count of Movies by Rating',
  xlab = 'Count of Movies',
  ylab = 'Rating'
)

# cleveland dot plot
dotchart(
  x = table(movies$Rating),
  pch = 16,
  main = 'Count of Movies by Rating',
  xlab = 'Count of Movies',
  ylab = 'Rating'
)

# lattice plotting
library(lattice)

# frequency table of rating
table <- table(movies$Rating)
rating <- as.data.frame(table)
names(rating)[1] <- 'Rating'
names(rating)[2] <- 'Count'
print(rating)

# frequency bar chart
barchart(
  x = Count ~ Rating,
  data = rating,
  main = 'Count of Movies by Rating',
  xlab = 'Rating'
)

# horizontal bar chart
barchart(
  x = Rating ~ Count,
  data = rating,
  main = 'Count of Movies by Rating',
  xlab = 'Rating'
)

# cleveland dot plot
dotplot(
  x = Rating ~ Count,
  data = rating,
  main = 'Count of Movies by Rating',
  xlab = 'Rating'
)

# part-of-whole frquency bar chart
histogram(
  x = ~ Rating,
  data = movies,
  main = 'Percent of Movies by Rating'
)

# ggplot2 plotting
library(ggplot2)

# frequency bar chart
ggplot(
  data = movies,
  aes(x = Rating)
) +
  geom_bar() +
  ggtitle('Count of Movies by Rating')

# horizontal bar chart
ggplot(
  data = movies,
  aes(x = Rating)
) +
  geom_bar() +
  coord_flip() +
  ggtitle('Count of Movies by Rating')

# cleveland dot plot
ggplot(
  data = movies,
  aes(x = Rating)
) +
  geom_point(stat = 'count') +
  coord_flip() +
  ggtitle('Count of Movies by Rating')








  
  
  
  
  
  
  
  
  