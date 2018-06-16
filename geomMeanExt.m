function [ gmeanE, delta ] = geomMeanExt( dataset, epsilon) 
%geomMeanExt.m Modification of the geometric mean expression to 
%include datasets with zero values.
%
%The formula is:
%   exp(mean(log(dataset+delta)))-delta (Eq. I)
%where delta is the maximum value such that:
%   exp(mean(log(dataset_nozeros+delta)))-delta-geomean(dataset_nozeros)<epsilon*geomean(dataset_nozeros) (Eq. II)
%where:
%   dataset_nozeros is obtained removing the zero values of the dataset
%   geomean: the usual geometric mean
%
%input_values
%   dataset 
%   epsilon: default value=1e-5
%output_values
%   gmeanE: value of the expression (Eq. I)
%   delta: value calculated in (Eq. II)
%
%Roberto de la Cruz, 16/06/2018
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(nargin==1)
  epsilon=1e-5;
end
%elseif(nargin>2)
%  error('Wrong number of input arguments')
%end

if(std(dataset)>0)
    dataset_nozeros=dataset(dataset>0);
    geomeanNozeros=geomean(dataset_nozeros);
    epsilon=epsilon*geomeanNozeros;        
    %Simple bisection  method to calculate delta: ( (Eq. I) is increasing as
    %consequence of the Superaddivity of the Geometric Mean)
    deltamin=0;
    deltamax=(geomeanNozeros+epsilon);         
        while exp(mean(log(dataset_nozeros+deltamax)))-deltamax < epsilon %Just for data set with very small standard desviation
            deltamin=deltamax;
            deltamax=deltamax*2;
        end
    delta=(deltamin+deltamax)/2;
    auxExp=exp(mean(log(dataset_nozeros+delta)))-delta; 
    while (auxExp-geomeanNozeros)>epsilon 
        if((auxExp<geomeanNozeros))
            deltamin=delta;
        else
            deltamax=delta;
        end    
            delta=(deltamin+deltamax)/2;
            auxExp=exp(mean(log(dataset_nozeros+delta)))-delta;
    end
    gmeanE=exp(mean(log(dataset+delta)))-delta;
else
    if isempty(dataset)
        error('Empty data set')
    else
        gmeanE=dataset(1);
        delta=0;
    end
end
end

