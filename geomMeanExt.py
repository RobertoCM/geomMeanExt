import numpy as np
import scipy.stats.mstats as ssm
import math
#geomMeanExt.py Modification of the geometric mean expression to include datasets with zero values.
#
#The formula is:
#   exp(mean(log(dataset+delta)))-delta (Eq. I)
#where delta is the maximum value such that:
#   exp(mean(log(dataset_nozeros+delta)))-delta-geomean(dataset_nozeros)<epsilon*geomean(dataset_nozeros) (Eq. II)
#where:
#   dataset_nozeros is obtained removing the zero values of the dataset
#   geomean: the usual geometric mean
#
#input_values
#   dataset 
#   epsilon: default value=1e-5
#output_values
#   gmeanE: value of the expression (Eq. I)
#   delta: value calculated in (Eq. II)
#
#Roberto de la Cruz, 16/06/2018
#####################################################
def geomMeanExtension(dataset):
	epsilon=1e-5
	
	dataset_nozeros=dataset[dataset>0]
	geomeanNozeros=ssm.gmean(dataset_nozeros)
	
	deltamin=0
	deltamax=geomeanNozeros-min(dataset_nozeros);
	delta=(deltamin+deltamax)/2;
	
	epsilon=epsilon*geomeanNozeros;
	auxExp=math.exp(np.mean(np.log(dataset_nozeros+delta)))-delta;
	while (auxExp-geomeanNozeros)>epsilon:
		if(auxExp<geomeanNozeros):
			deltamin=delta
		else:
			deltamax=delta
		delta=(deltamin+deltamax)/2;
		auxExp=math.exp(np.mean(np.log(dataset_nozeros+delta)))-delta;

	gmeanE=math.exp(np.mean(np.log(dataset+delta)))-delta;
	return(gmeanE,delta);


