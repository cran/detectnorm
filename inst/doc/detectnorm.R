## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  fig.width  =  6,
  fig.height =  6,
  fig.align = "center"
)

## ----setup--------------------------------------------------------------------
library(detectnorm)

## ----beta_example-------------------------------------------------------------
library(detectnorm)
# Situations using beta distributions
set.seed(32411)
#Using Fleishman's method to generate non-normal data
dat1 <- rnonnorm(n = 1000, mean = 0, sd = 1, skew = 2, kurt = 5)$dat
hist(dat1)
psych::describe(dat1)
#Suppose we don't know about the raw data
result <- desbeta(vmean = mean(dat1), vsd = sd(dat1),lo = min(dat1), hi = max(dat1), showFigure = TRUE, rawdata = dat1)
result

## ----trun_example-------------------------------------------------------------
library(detectnorm)
#Truncated normal distribution
set.seed(34120)
dat2 <- truncnorm::rtruncnorm(n = 1000, a = 0, b = 14, mean = 4, sd = 3)
psych::describe(dat2)
destrunc(vmean=mean(dat2), vsd=sd(dat2), lo=0, hi=14, rawdata = dat2, showFigure = TRUE)

## ----betameta_example---------------------------------------------------------
library(detectnorm)
# examine the meta-analysis dataset by simulating extremely non-normal distribution
# population mean1 = 1, mean2 = 1.5, sd1 = sd2=1, skewness1 = 4, kurtosis2 = 2, skewness2=-4, kurtosis2=2
data("beta_mdat")
beta1 <- detectnorm(m1i = m1,sd1i = sd1,n1i = n1, hi1i = hi1,lo1i = lo1,m2i = m2,sd2i = sd2,n2i = n2, hi2i = hi2,lo2i=lo2,distri = "beta", data = beta_mdat)
head(beta1)
#compare the sample skewness and estimated skewness using beta distribution
mean(beta1$skew1)#sample skewness calculated from the sample in group 1
mean(beta1$g1_skewness) #estimated using beta in group 1
mean(beta1$skew2) #sample skewness calculated from the sample in group 2
mean(beta1$g2_skewness)#estimated using beta in group 2

## ----trunmeta_example---------------------------------------------------------
library(detectnorm)
data("trun_mdat")
head(trun_mdat)
trun1 <- detectnorm(m1i = m1,sd1i = sd1,n1i = n1, hi1i = 4,lo1i = 0,m2i = m2,sd2i = sd2,n2i = n2, hi2i = 4,lo2i= 0,distri = "truncnorm", data = trun_mdat)
mean(trun1$skew1)#sample skewness calculated from the sample in group 1
mean(trun1$g1_skewness)#estimated using truncnorm in group 1
mean(trun1$skew2)#sample skewness calculated from the sample in group 2
mean(trun1$g2_skewness)#estimated using truncnorm in group 2

