# Functional Programming

values <- 1:10

# using the apply function
# apply(X, MARGIN, FUN, ..., simplify = TRUE)
# in r, this is much faster than a for loop
# because r is vectorized
# using built in vectorized r functions
# allows r to send the code to c to run
# since r is written in c

df <- mtcars[1:4,1:4]

apply(df, 1, min) # rows wise
apply(df, 2, min) # column wise

add_one <- function(x){
  x + 1
}

apply(df, 2, FUN = add_one)

# Anonymous Functions - lambda
# not names and must be consumed immediately

add_one <- function(x){
  x + 1
}
add_one(2)

(function(x) x + 1)(2)

# Passing anonymous functions into apply

apply(df, 1, function(x) x + 1)

# When to use a named function vs an anonymous function
# 1. the function is more than 1 line
# 2. it takes more than 3 seconds to understand it
# 3. you will need the function again

# Common aplly functions in R
# lapply - input is list or vector, output is list
# sapply - input is list or vector, output is vector
# vapply - input is list of vector, output is specified type for error checking

# lapply
result <- lapply(values, add_one) # output is a list
unlist(result)

head(iris)

lapply(iris, summary) # applied to each column of the df

lapply(iris, class)

df <- iris[, 1:4]
head(df)

result <- lapply(df, function(x) x + 100)
result

result$Sepal.Length
typeof(result)

result <- as.data.frame(result)
head(result)

# sapply

sapply(values, add_one) # output is a vector

sapply(df, summary)

# vapply

vapply(values, add_one) # error

vapply(values, add_one, numeric(1))

vapply(values, add_one, logical(1)) #error

sapply(1:10, function(x) x %% 2)

vapply(1:10, function(x) x %% 2, logical(1)) # error

vapply(1:10, function(x) as.logical(x %% 2), logical(1))

# tapply
# iterates over vector, and groups by factor level
# applies function to each element

sapply(iris, class)

tapply(iris$Sepal.Length, iris$Species, mean)

tapply(iris$Sepal.Length, iris$Species, summary)

tapply(iris$Sepal.Length, iris$Species, function(x) x %% 2 == 0)

tapply(iris$Sepal.Length, iris$Species, function(x) sum(x %% 2 == 0))

# replicate
# executes specified function a certain number of times

replicate(3, 'value')

rep('value', 3)

runif(1)

rep(runif(1), 3) # rep simple copies the output 3 times

replicate(3, runif(1)) # replicate runs function 3 different times

get_random_obs <-  function(){
  n_rows <- nrow(iris)
  random_row <- sample(n_rows, 1)
  iris[random_row, ]
}

get_random_obs()

replicate(3, get_random_obs())

# Summary
df <- iris[, 1:4]
head(df)

apply(df, 2, mean)
lapply(df, mean) # output is list
sapply(df, mean) # output is vector
vapply(df, mean, numeric(1)) # ability to type check
tapply(iris$Sepal.Length, iris$Species, mean) # output mean value of each group
replicate(3, runif(1)) # iterates over each element then executes function
rep(runif(1), 3) # execute funtion first then value gets placed in






