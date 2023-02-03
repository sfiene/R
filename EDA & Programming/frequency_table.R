# Creating a two-way and three-way frequency table

# two way table is the count of two categorical
# variables and their relative frequencies

# Goal: find counts of members relative to behavior
# or characteristics

crf <- read.table(
  'Carved_Rock_Fitness.csv',
  header = TRUE,
  sep = ','
)

my2table <- table(
  crf$Membership_Status,
  crf$Age_Group # A will be rows, B will be columns
)

my2table

# Creating a three-way frequency table

# count three categorical variables and their
# relative frequencies

# Goal: find counts of members relative to 
# behavior or characteristics

my3table <- table(
  crf$Membership_Status,
  crf$Age_Group,
  crf$Gender
)

ftable(my3table)

# Proportions
# Chow the percentages of the total amount per category
# SHow frequencies across groups in percentages
# All cells add up to 100%

my2table <- table(
  crf$Membership_Status,
  crf$Zip
)
my2table

prop2table <- prop.table(my2table) # this is in percent
prop2table

perc2 <- (100 * prop2table) # this is in percent
perc2

my3table <- table(
  crf$Membership_Status,
  crf$Zip,
  crf$Gender
)
ftable(my3table)

prop3table <- prop.table(my3table) # this is in percent
ftable(prop3table)

perc3 <- (100 * prop3table)
ftable(perc3)

# Marginal Frequency Table

# simple two way frequency table
# must include sum of rows and columns

my2table <- table(
  crf$Membership_Status,
  crf$Zip
)
margin <- addmargins(my2table)
ftable(margin)

prop2table <- prop.table(my2table)
marginprop <- addmargins(prop2table)
ftable(marginprop)

install.packages('questionr')
library(questionr)
pct2 <- prop_table(
  my2table,
  total = TRUE,
  percent = TRUE
)
pct2


