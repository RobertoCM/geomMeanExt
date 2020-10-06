geomMeanExtension <- function(dataset, epsilon){
#geomMeanExtension.R Modification of the geometric mean expression to
#include datasets with zero values.
#
#The formula is:
#exp(mean(log(dataset+delta)))-delta (Eq. I)
#where delta is the maximum value such that:
#   abs([exp(mean(log(dataset_nozeros+delta)))-delta]-geomean(dataset_nozeros))<epsilon*geomean(dataset_nozeros) (Eq. II)
#where:
#   dataset_nozeros is obtained removing the zero values of the dataset
#   geomean: the usual geometric mean
#
#input_values
#   dataset
#   epsilon: (default value=1e-5)
#output_values
#   gmeanE: value of the expression (Eq. I)
#   delta: value calculated in (Eq. II)
#
#Roberto de la Cruz, 06/05/2020
########################################################################
#library("EnvStats")

dataset_nozeros <- dataset[dataset>0]
geomeanNozeros <- geoMean(dataset_nozeros)
epsilon <- epsilon*geomeanNozeros

#Simple bisection  method to calculate delta: ( (Eq. I) is increasing as
#consequence of the Superaddivity of the Geometric Mean)
deltamin <- 0
deltamax <- (geomeanNozeros+epsilon)
while (exp(mean(log(dataset_nozeros+deltamax)))-deltamax < epsilon){#Just for data set with very small standard desviation
    deltamin <- deltamax
    deltamax <- deltamax*2
}
delta <- (deltamin+deltamax)/2
auxExp <- exp(mean(log(dataset_nozeros+delta)))-delta #Define auxExp to not repeat operations
while ((auxExp-geomeanNozeros)>epsilon){
    if ((auxExp<geomeanNozeros)){
            deltamin <- delta
    } else {
            deltamax <- delta
    }
    delta <- (deltamin+deltamax)/2
    auxExp <- exp(mean(log(dataset_nozeros+delta)))-delta
}
gmeanE <- exp(mean(log(dataset+delta)))-delta

#print(paste("Modified geometric mean", gmeanE))
#print(paste("Delta value", delta))
return(c(gmeanE,delta))
}