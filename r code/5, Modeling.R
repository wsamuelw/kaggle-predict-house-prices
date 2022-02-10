# modeling strategy is to split the train set (supplied train set) into train and test
# this enables us to evaluate the predictions

# too many missing values in these features
# drop them from the data set
full_cleaned <- full %>% 
  select(-c(FireplaceQu, Fence, Alley, MiscFeature, PoolQC))

train_cleaned <- full_cleaned %>% 
  filter(SalePrice != 0)

# use as.data.frame to convert character into factor
train_prepared <- as.data.frame(unclass(train_cleaned), stringsAsFactors = TRUE)

glimpse(train_prepared)

# split the train set into train and test
set.seed(222) 
house_split <- initial_split(train_prepared, prop = 0.8, strata = SalePrice) # enforce similar distributions
house_split

# <Analysis/Assess/Total>
# <1166/294/1460>
  
house_train <- training(house_split); nrow(house_train) # 1166
house_test <- testing(house_split); nrow(house_test) # 294

# xgboost model for regression
model_spec <- boost_tree() %>% 
  set_engine("xgboost") %>% 
  set_mode("regression")

model_spec

# Fit to the data
# *one observation = cannot have features with too many missing values
model_fit <- model_spec %>%
  fit(formula = SalePrice ~ . - Id, data = house_train)

model_fit

# feature importance
vip(model_fit)

# Predict new data
predictions <- predict(model_fit, house_test) %>%
  bind_cols(house_test) # Add the test set

View(predictions)

# evaluation 
# mae
yardstick::mae(predictions, estimate = .pred, truth = SalePrice) # 18494

# rmse
yardstick::rmse(predictions, estimate = .pred, truth = SalePrice) # 26430

# rmsle
library(mltools)
rmsle(predictions$.pred, predictions$SalePrice) # 0.1512431




# now, apply the model on the test dataset (the unseen data)
unseen <- full_cleaned %>% 
  filter(SalePrice == 0) %>% # test set (unseen data)
  select(-SalePrice)

glimpse(unseen)

unseen_prepared <- as.data.frame(unclass(unseen), stringsAsFactors = TRUE)

glimpse(unseen_prepared)

# Predict new data
unseen_predictions <- predict(model_fit, unseen_prepared) %>%
  bind_cols(unseen_prepared) # Add the test set

View(unseen_predictions)

# make a submission on kaggle
submission <- unseen_predictions %>% 
  select(Id, .pred) %>% 
  rename(SalePrice = .pred)

head(submission)

# export submission
write.csv(submission, "submission5.csv", row.names = FALSE)
