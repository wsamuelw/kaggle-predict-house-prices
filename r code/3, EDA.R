# EDA
# auto EDA
train %>%
  DataExplorer::create_report()

# do one for numeric features only
select_if(train, is.numeric) %>%
  DataExplorer::create_report()

# disable scientific notation
options(scipen=999)

# plot a histogram to visualise the SalePrice distribution from the train set
# the median SalePrice is 163000
ggplot(train, aes(SalePrice)) +
  geom_histogram() +
  geom_vline(xintercept = median(train$SalePrice), color = "green") +
  theme_bw()

# boxplot for outliers
ggplot(train, aes(SalePrice)) +
  geom_boxplot(outlier.colour = "red") +
  theme_bw()

# MSSubClass: Identifies the type of dwelling involved in the sale.	
ggplot(train, aes(as.factor(MSSubClass))) +
  geom_bar() +
  theme_bw()

# MSZoning: Identifies the general zoning classification of the sale
ggplot(train, aes(MSZoning)) +
  geom_bar() +
  theme_bw()

# LotFrontage: Linear feet of street connected to property
# the median without all the missing values = 69
ggplot(train, aes(LotFrontage)) +
  geom_histogram() +
  geom_vline(xintercept = median(train$LotFrontage, na.rm = T), color = "green") +
  theme_bw()

# LotArea: Lot size in square feet
# the median without all the missing values = 9478.5
ggplot(train, aes(LotArea)) +
  geom_histogram() +
  geom_vline(xintercept = median(train$LotArea, na.rm = T), color = "green") +
  theme_bw()

# boxplot for outliers
ggplot(train, aes(LotArea)) +
  geom_boxplot(outlier.colour = "red") +
  theme_bw()

# Street: Type of road access to property
ggplot(train, aes(Street)) +
  geom_bar() +
  theme_bw()

ggplot(train, aes(Alley)) +
  geom_bar() +
  theme_bw()

ggplot(train, aes(LotShape)) +
  geom_bar() +
  theme_bw()

# continue from the above




