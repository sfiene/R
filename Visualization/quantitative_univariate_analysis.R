# Univariate Visualizations for quantitative variable
# single numeric variable
movies <- read.csv('Movies.csv')


# base r plotting
# dotplot of runtime
plot(
  x = movies$Runtime,
  y = rep(0, nrow(movies)),
  main = 'Distribution of Movie Runtimes',
  xlab = 'Runtime (minutes)',
  ylab = '',
  yaxt = 'n'
)

# dotplot with alpha transparency
plot(
  x = movies$Runtime,
  y = rep(0, nrow(movies)),
  main = 'Distribution of Movie Runtimes',
  xlab = 'Runtime (minutes)',
  ylab = '',
  yaxt = 'n',
  pch = 16,
  col = rgb(0, 0, 0, 0.1)
)

# add jitter to dot plot
plot(
  x = movies$Runtime,
  y = jitter(rep(0, nrow(movies))),
  main = 'Distribution of Movie Runtimes',
  xlab = 'Runtime (minutes)',
  ylab = '',
  yaxt = 'n',
)

# boxplot of runtimes
boxplot(
  x = movies$Runtime,
  horizontal = TRUE,
  main = 'Distribution of Movie Runtime',
  xlab = 'Runtime (minutes)'
)

# histogram of runtimes
hist(
  x = movies$Runtime,
  main = 'Distribution of Movie Runtimes',
  xlab = 'Runtime (minutes)'
)

# more coarse grained histogram
hist(
  x = movies$Runtime,
  breaks = 10,
  main = 'Distribution of Movie Runtimes',
  xlab = 'Runtime (minutes)'
)

# finer grained histogram
hist(
  x = movies$Runtime,
  breaks = 30,
  main = 'Distribution of Movie Runtimes',
  xlab = 'Runtime (minutes)'
)

# denisty plot of runtime
plot(
  x = density(movies$Runtime),
  main = 'Distribution of Movie Runtime',
  xlab = 'Runtime (minutes)'
)

# small multiple of all four charts
par(mfrow = c(4, 1))
plot(
  x = movies$Runtime,
  y = jitter(rep(0, nrow(movies))),
  xlim = c(25, 200),
  main = 'Distribution of Movie Runtimes',
  xlab = '',
  ylab = '',
  yaxt = 'n',
  pch = 16,
  col = rgb(0, 0, 0, 0.1)
)

boxplot(
  x = movies$Runtime,
  ylim = c(25, 200),
  horizontal = TRUE
)

hist(
  x = movies$Runtime,
  xlim = c(25,200),
  main = '',
  xlab = '',
  ylab = '',
  yaxt = 'n'
)

plot(
  x = density(movies$Runtime),
  xlim = c(25, 250),
  main = '',
  xlab = 'Runtime (minutes)',
  ylab = '',
  yaxt = 'n'
)

# reset multi-row display
par(mfrow = c(1,1))

# lattice plotting
stripplot(
  x = ~ Runtime,
  data = movies,
  main = 'Distributions of Movie Runtimes',
  xlab = 'Runtime (minutes)'
)

# dot plot with jitter
stripplot(
  x = ~ Runtime,
  data = movies,
  jitter = TRUE,
  amount = 0.5,
  main = 'Distributions of Movie Runtimes',
  xlab = 'Runtime (minutes)'
)

# box plot
bwplot(
  x = ~ Runtime,
  data = movies,
  main = 'Distributions of Movie Runtimes',
  xlab = 'Runtime (minutes)'
)

# histogram
histogram(
  x = ~ Runtime,
  data = movies,
  main = 'Distributions of Movie Runtimes',
  xlab = 'Runtime (minutes)'
)

# density plot
densityplot(
  x = ~ Runtime,
  data = movies,
  main = 'Distributions of Movie Runtimes',
  xlab = 'Runtime (minutes)'
)

# ggplot2 plotting
ggplot(
  movies,
  aes(x = Runtime, stat = 'count')) +
  geom_dotplot(binwidth = 1) +
  ggtitle('Distributions of Movie Runtimes') +
  xlab('Runtime (minutes)')

# violin plot
ggplot(
  movies,
  aes(x = Runtime, stat = 'count')) +
  geom_dotplot(binwidth = 1,
               stackdir = 'center') +
  ggtitle('Distributions of Movie Runtimes') +
  xlab('Runtime (minutes)')
)

# boxplot
ggplot(
  movies,
  aes(x = Runtime, y = Runtime)) +
  geom_boxplot() +
  coord_flip() +
  ggtitle('Distributions of Movie Runtimes') +
  xlab('') +
  ylab('Runtime (minutes)') +
  theme(
    axis.text.y = element_blank(),
    axis.ticks.y = element_blank()
  )

# histogram
ggplot(
  movies,
  aes(Runtime)) +
  geom_histogram(binwidth = 10) +
  ggtitle('Distributions of Movie Runtimes') +
  xlab('Runtime (minutes)')

# density plot
ggplot(
  movies,
  aes(Runtime)) +
  geom_density() +
  ggtitle('Distributions of Movie Runtimes') +
  xlab('Runtime (minutes)')

dev.off()

# small multiples
library(grid)
library(ggplot2)

viewport <- viewport(
  layout = grid.layout(4,1)
)

pushViewport(viewport)

dot <- ggplot(
  movies,
  aes(Runtime, ..count..)) +
  geom_dotplot(binwidth = 0.25) +
  scale_x_continuous(limits = c(0, 250)) +
  ggtitle('Distributions of Movie Runtimes') +
  xlab('')

print(
  x = dot,
  vp = viewport(
    layout.pos.row = 1,
    layout.pos.col = 1
  )
)

box <- ggplot(
  movies,
  aes(x = Runtime, y = Runtime)) +
  geom_boxplot() +
  coord_flip() +
  scale_y_continuous(
    limits = c(0, 250)) +
  ylab('') +
  xlab('')


print(
  x = box,
  vp = viewport(
    layout.pos.row = 2,
    layout.pos.col = 1
  )
)

hist <- ggplot(
  movies,
  aes(Runtime)) +
  geom_histogram(binwidth = 10) +
  scale_x_continuous(
    limits = c(0, 250)) +
  xlab('')

print(
  x = hist,
  vp = viewport(
    layout.pos.row = 3,
    layout.pos.col = 1
  )
)

density <- ggplot(
  movies,
  aes(Runtime)) +
  geom_density() +
  scale_x_continuous(
    limits = c(0,250)) +
  xlab('Runtime (minutes)')

print(
  x = density,
  vp = viewport(
    layout.pos.row = 4,
    layout.pos.col = 1
  )
)

dev.off()
