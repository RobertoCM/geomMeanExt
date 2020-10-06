#Installing and loading the EnvStats package
packages <- c("EnvStats")
if (length(setdiff(packages, rownames(installed.packages()))) > 0) {
    install.packages(setdiff(packages, rownames(installed.packages())))  
}
library("EnvStats")


data<-read.csv("data.txt", header = FALSE, sep = ",")
epsilon<-1e-5
source('./geomMeanExtension.R')
output<-geomMeanExtension(as.matrix(data),epsilon)
print(paste0("The modified geometric mean is ",output[1]))
