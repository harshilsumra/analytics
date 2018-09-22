
df = women
df
df[c(1,5,7),2] = NA
df
df[c(3,5,8),1] = NA
df
is.na(df)
colSums(is.na(df))
rowSums(is.na(df))
cor(women)
options(digits=5)
cor(df)
cor(df, use="pairwise.complete.obs")
