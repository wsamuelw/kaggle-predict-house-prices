# visualise missingness
naniar::vis_miss(full)

# show features with missing values (in %)
sapply(full, function(x) sum(is.na(x))) %>% 
  as.data.frame() %>% 
  rename(., missing = .) %>% 
  filter(missing >0) %>% 
  arrange(desc(missing)) %>% 
  mutate(total = nrow(full),
         pct = round(missing / total, 4))

#              missing total    pct
# PoolQC          2909  2919 0.9966 # Pool quality and PoolArea are related. data eng idea = Has_Pool
# MiscFeature     2814  2919 0.9640 # Miscellaneous feature. data eng idea = Has_MiscFeature
# Alley           2721  2919 0.9322
# Fence           2348  2919 0.8044
# FireplaceQu     1420  2919 0.4865
# LotFrontage      486  2919 0.1665
# GarageYrBlt      159  2919 0.0545
# GarageFinish     159  2919 0.0545
# GarageQual       159  2919 0.0545
# GarageCond       159  2919 0.0545
# GarageType       157  2919 0.0538
# BsmtCond          82  2919 0.0281
# BsmtExposure      82  2919 0.0281
# BsmtQual          81  2919 0.0277
# BsmtFinType2      80  2919 0.0274
# BsmtFinType1      79  2919 0.0271
# MasVnrType        24  2919 0.0082
# MasVnrArea        23  2919 0.0079
# MSZoning           4  2919 0.0014
# Utilities          2  2919 0.0007
# BsmtFullBath       2  2919 0.0007
# BsmtHalfBath       2  2919 0.0007
# Functional         2  2919 0.0007
# Exterior1st        1  2919 0.0003
# Exterior2nd        1  2919 0.0003
# BsmtFinSF1         1  2919 0.0003
# BsmtFinSF2         1  2919 0.0003
# BsmtUnfSF          1  2919 0.0003
# TotalBsmtSF        1  2919 0.0003
# Electrical         1  2919 0.0003
# KitchenQual        1  2919 0.0003
# GarageCars         1  2919 0.0003
# GarageArea         1  2919 0.0003
# SaleType           1  2919 0.0003

spot_check <- full %>% 
  filter(!is.na(Alley))

View(spot_check)
