orig_data <- read.csv2('Jan_2015_ontime.csv',
                      sep = ',',
                      header = TRUE,
                      stringsAsFactors = FALSE)

nrow(orig_data) #check rows

# create subset and filter data
airports <- c("ATL", "LAX", "ORD", "DFW", "JFK",
              "SFO","CLT", "LAS", "PHX")
orig_data <- subset(orig_data, DEST %in% airports & ORIGIN %in% airports)

nrow(orig_data)

head(orig_data)
tail(orig_data)     

orig_data$X <- NULL # drop column X
head(orig_data)

# check if any values are correlated
cor(orig_data[c("ORIGIN_AIRPORT_SEQ_ID",
                "ORIGIN_AIRPORT_ID")])
cor(orig_data[c("DEST_AIRPORT_SEQ_ID",
                "DEST_AIRPORT_ID")])

# drop correlated columns
orig_data$ORIGIN_AIRPORT_SEQ_ID <- NULL
orig_data$DEST_AIRPORT_SEQ_ID <- NULL

# more checking on correlated data
mismatched <- orig_data[orig_data$CARRIER != orig_data$UNIQUE_CARRIER,]
nrow(mismatched)
orig_data$UNIQUE_CARRIER <- NULL                     
                        
# drop unneeded rows
on_time_data <- orig_data[!is.na(orig_data$ARR_DEL15) &
                            orig_data$ARR_DEL15 != "" &
                            !is.na(orig_data$DEP_DEL15) &
                            orig_data$DEP_DEL15 != "",]

# change data types
on_time_data$DISTANCE <- as.integer(on_time_data$DISTANCE)
on_time_data$CANCELLED <- as.integer(on_time_data$CANCELLED)
on_time_data$DIVERTED <- as.integer(on_time_data$DIVERTED)

on_time_data$ARR_DEL15 <- as.factor(on_time_data$ARR_DEL15)
on_time_data$DEP_DEL15 <- as.factor(on_time_data$DEP_DEL15)
on_time_data$DEST_AIRPORT_ID <- as.factor(on_time_data$DEST_AIRPORT_ID)
on_time_data$ORIGIN_AIRPORT_ID <- as.factor(on_time_data$ORIGIN_AIRPORT_ID)
on_time_data$DAY_OF_WEEK <- as.factor(on_time_data$DAY_OF_WEEK)
on_time_data$DEST <- as.factor(on_time_data$DEST)
on_time_data$ORIGIN <- as.factor(on_time_data$ORIGIN)
on_time_data$DEP_TIME_BLK <- as.factor(on_time_data$DEP_TIME_BLK)
on_time_data$CARRIER <- as.factor(on_time_data$CARRIER)

# EDA
tapply(on_time_data$ARR_DEL15, 
       on_time_data$ARR_DEL15,
       length
)

# What % is delayed
(6460 / (25664 + 6460))

# load package
library(caret)

# set seed value
set.seed(122515)

# set training  and test data
feature_cols <- c('ARR_DEL15', 'DAY_OF_WEEK',
                  'CARRIER', 'DEST', 'ORIGIN',
                  'DEP_TIME_BLK')
on_time_data_filtered <- on_time_data[,feature_cols]

# create list of column indices for train and test data
in_train_rows <- createDataPartition(on_time_data_filtered$ARR_DEL15,
                                     p = 0.70,
                                     list = FALSE)

train_data_filtered <- on_time_data_filtered[in_train_rows,]
test_data_filtered <- on_time_data_filtered[-in_train_rows,]

# check if data was split correctly
nrow(train_data_filtered) / (nrow(test_data_filtered) + nrow(train_data_filtered))
nrow(test_data_filtered) / (nrow(test_data_filtered) + nrow(train_data_filtered))

# train model
logistic_reg_model <- train(ARR_DEL15 ~ .,
                            data = train_data_filtered,
                            method = 'glm',
                            family = 'binomial')

# predict data
logistic_reg_prediction <- predict(logistic_reg_model,
                                   test_data_filtered)

# evaluate the model
log_reg_conf_mat <- confusionMatrix(logistic_reg_prediction,
                                    test_data_filtered[, 'ARR_DEL15'])

log_reg_conf_mat

# Random forest model
library(randomForest)

rf_model <- randomForest(train_data_filtered[-1],
                         train_data_filtered$ARR_DEL15,
                         proximity = TRUE,
                         importance = TRUE)

rf_validation <- predict(rf_model, test_data_filtered)
rf_conf_mat <- confusionMatrix(rf_validation,
                               test_data_filtered[, 'ARR_DEL15'])
rf_conf_mat



