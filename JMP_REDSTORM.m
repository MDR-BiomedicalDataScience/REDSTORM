% Resolution EnhanceD SubseT Optimization by Reference Matching (REDSTORM) - for general 2D spectra
%     Reference: Posma and Garcia-Perez, et al. (2017) Analytical Chemistry 89(6)
%
%   Required input:
% X = [j,p,n] stacked 2D-spectra
% f2 = [1,p] f2-axis (for J-Res this is the ppm-axis)
% f1 = [j,1] f1-axis (for J-Res this is the J-axis)
% df2 = [1,1] driver of f2-axis
% df1 = [1,1] driver of f1-axis
% ref = [j,p] reference spectrum
% 
%   Optional input:
% f2range = range of f2-axis to consider to find reference region from driver
% f1range = range of f1-axis to consider to find reference region from driver
% tv = threshold for pr(variables) (default: 0.5) 0.01<tv<=1
% ts = threshold for pr(samples) (default: 0.5) 0<ts<=1
% pattern = 'square' (default), 'diamond' or 'circle' to use for peak finding
% arm = [2,1] the extent in both directions of ref of the pattern (default: [6 6])
% iopa = (0,1) logical, to include the original area of the 'peak' by default or only if it is higher than its
%   surrounding pattern (minus the previous variables part of the peak) (default: false)
% peaklimit = [1,1] (0<fraction<=1) or 'last', to reduce the number of variables to be used for the algorithm, fraction
%   of all peaks used (sorted descendingly) or 'last' (default) which uses all peaks that are higher than peaks on the
%   0-axis (for J-res) and diagonal (for homonuclear 2D spectra), for heteronuclear spectra 'last' defaults to a
%   fraction of 0.1
% dtype = 'jres', 'homonuclear' (for COSY/TOCSY), 'heteronuclear' (for HSQC/HMBC)
% expandref = (0,1) logical, to find other peaks in (f2range,f1range) that can be added to the reference
% razbet = r and z bootstrap estimation type for samples and expanding reference region
%   'min': minimum |r| (and z) from bootstrap resampling for a conservative estimate
%   'max': maximum |r| (and z) from bootstrap resampling for an optimistic estimate
%   'mean': average z (~r) from bootstrap resampling (default)
%   'median': median z (~r) from bootstrap resampling
%   'none': do not do bootstrap resampling
% razfvi = r and z for variable importance after optimal subset is obtained
%   'driver': r and z of each variable with driver variable
%   'max': using maximum |r| (and z) of each variable with all reference variables (default)
%   'mean': using average z (~r) of each variable with all reference variables
%   'wmean': using weighted (~ intensity of reference region variables) average z (~r) of each variable with all reference variables
%   'median': using median z (~r) of each variable with all reference variables
% vibs = (0,1) logical, variable importance bootstrap switch, whether or not to do bootstrap resampling using subset
%   probabilities for finding variable importance, uses razfvi for each iteration and razbet to get the overall estimate
%   (default: true)
% nboot = integer>1, number of bootstrap resamplings (default: 100)
% ni = integer, number of iterations per clustering
% nbi = integer, number of burn-in iterations per clustering
% mss = [1,1] maximum subset size 10<mss<=n
%
%   Output:
% model = [subset,prs,prv,Rd12]
%   subset = indices of samples in subset
%   prs = probability of samples belonging to distribution that matches the reference
%   prv = probability of variables belonging to the distribution that matches the driver region
%   Rd12 = region of the driver
%
% version v1.0