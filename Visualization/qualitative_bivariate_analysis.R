# Visualizing 2 Categorical Variable with
# base plotting, lattice and ggplot2
movies <- read.csv('Movies.csv')

# contingency table
awards <- table(
  movies$Awards,
  movies$Rating
)
awards

# base r plotting
# grouped bar plot
barplot(
  height = awards,
  beside = TRUE,
  main = 'Count of Movies by Rating and Awards',
  xlab = "Rating",
  ylab = "Count of Movies",
  legend = c("No", "Yes"),
  args.legend = list(
    x = 'topleft',
    title = 'Awards'
  )
)

# stacked frequency bar chart
barplot(
  height = awards,
  main = 'Count of Movies by Rating and Awards',
  xlab = "Rating",
  ylab = "Count of Movies",
  legend = c("No", "Yes"),
  args.legend = list(
    x = 'topleft',
    title = 'Awards'
  )
)

# proportional frequency table by column
proportions <- apply(awards, 2, function(x) {x / sum(x)})
head(awards)
head(proportions)

# 100% stacked bar chart
barplot(
  height = proportions,
  main = 'Proportions of Movies by Rating and Awards',
  xlab = "Rating",
  ylab = "Proportion of Movies",
  legend = c("No", "Yes"),
  args.legend = list(
    x = 'topleft',
    title = 'Awards'
  )
)

# created contingency table
# with rows and columns flipped or transposed
awards <- table(
  movies$Rating,
  movies$Awards
)
awards
# rename columns
colnames(awards) <- c("No", "Yes")
awards

# create a spineplot
spineplot(
  x = awards,
  main = 'Proportion of Movies by Rating and Awards',
  xlab = "Rating",
  ylab = "Awards"
)

# create mosaic plot
mosaicplot(
  x = awards,
  main = 'Proportion of Movies by Rating and Awards',
  xlab = "Rating",
  ylab = "Awards"
)

# lattics plotting
library(lattice)

# grouped bar chart
barchart(
  x = awards,
  stack = FALSE,
  horizontal = FALSE,
  main = 'Count of Movies by Rating and Awards',
  xlab = "Rating",
  ylab = "Count of Movies",
  auto.key = list(
    x = 0.05,
    y = 0.95,
    title = 'Awards',
    text = c("No", "Yes")
  )
)

# stacked bar chart
barchart(
  x = awards,
  stack = TRUE,
  horizontal = FALSE,
  main = 'Count of Movies by Rating and Awards',
  xlab = "Rating",
  ylab = "Count of Movies",
  auto.key = list(
    x = 0.05,
    y = 0.95,
    title = 'Awards',
    text = c("No", "Yes")
  )
)

# proportional frequency table by row
matrix <- apply(awards, 1, function(x) {x / sum(x)})
proportions <- t(matrix)
matrix
proportions

# 100% stacked bar chart
barchart(
  x = proportions,
  stack = TRUE,
  horizontal = FALSE,
  main = 'Proportion of Movies by Rating and Awards',
  xlab = "Rating",
  ylab = "Proportion of Movies",
  auto.key = list(
    x = 0.70,
    y = 1.05,
    title = 'Awards',
    columns = 2,
    text = c("No", "Yes"),
    background = "lightgray"
  )
)

# ggplot2 plotting
# grouped bar chart
ggplot(
  movies,
  aes(x = Rating, fill = Awards)
) +
  geom_bar(position = 'dodge') +
  ggtitle('Count of Movies by Rating and Awards') +
  scale_fill_discrete(label = c("No", "Yes"))
  
# stacked bar chart
ggplot(
  movies,
  aes(x = Rating, fill = Awards)
) +
  geom_bar() +
  ggtitle('Count of Movies by Rating and Awards') +
  scale_fill_discrete(label = c("No", "Yes"))

# 100% stacked bar chart
ggplot(
  movies,
  aes(x = Rating, fill = Awards)
) +
  geom_bar(position = 'fill') +
  ggtitle('Proportion of Movies by Rating and Awards') +
  scale_fill_discrete(label = c("No", "Yes"))


  
  














