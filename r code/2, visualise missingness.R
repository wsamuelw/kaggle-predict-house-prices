# visualise missingness
naniar::vis_miss(full)

# a better way to # visualise missingness
visdat::vis_dat(full)

DataExplorer::plot_intro(full)

p <- DataExplorer::plot_missing(full, missing_only = T)

# drop the features below
# too many missing values in these features
# possible to do some work later
# FireplaceQU, Fence, Alley, MiscFeature, PoolQC

spot_check <- full %>% 
  filter(is.na(FireplaceQu))

View(spot_check)
