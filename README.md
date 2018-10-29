# Penalized-Mixed-Effects-Decomposition
PMD: Penalized Mixed-Effects Decomposition for Functional Data
Created by Yue, Xiaowei, from the Georgia Institute of Technology
## Introduction
The code is for the Penalized Mixed-effects Decomposition (PMD) Method. 
The PMD method can decompose the profiles (curves/ functional data) into four components: fixed effects, normal effects, defective effects ,and noise. The PMD method can be used for the multichannel profile detection of in-line Raman spectra, and it can also be used for feature extraction of other signals (profiles/functional data). 

## Reference:
Yue, X., Yan, H., Park, J.G., Liang, Z., Shi, J., “A Wavelet-based Penalized Mixed Effects Decomposition for Multichannel Profile Monitoring Based on In-line Raman Spectroscopy”, IEEE Transactions on Automation Science and Engineering, (in press).DOI: 10.1109/TASE.2017.2772218.


## Abstract of the paper:
Modeling and analysis of profiles, especially high-dimension nonlinear profiles, is an important and challenging topic in statistical process control. Conventional mixed-effects models have several limitations in solving the multichannel profile detection problems for in-line Raman spectroscopy, such as the inability to separate defective information from random effects, computational inefficiency, and inability to handle high dimensional extracted coefficients. In this paper, a new wavelet-based penalized mixed-effects decomposition (PMD) method is proposed to solve the multichannel profile detection problem in Raman spectroscopy. The proposed PMD exploits a regularized high-dimensional regression with linear constraints to decompose the profiles into four parts: fixed effects, normal effects, defective effects, and signal-dependent noise. An optimization algorithm based on the accelerated proximal gradient (APG) is developed to do parameter estimation efficiently for the proposed model. Finally, the separated fixed effects coefficients, normal effects coefficients, and defective effects coefficients can be used to extract the quality features of fabrication consistency, within-sample uniformity, and defect information, respectively. Using a surrogated data analysis and a case study, we evaluated the performance of the proposed PMD method and demonstrated a better detection power with less computational time.

## Usage
To run the main function: PMD_main_v0_2.m
*The file can be played by Matlab software. The code is tested on Matlab R2016b, but should work on other versions of Matlab with no or little changes. Current version works on these platforms: Windows 64-bit, Linux 64-bit, and Mac (Intel 64-bit).
*Version information: v0.1

## Data Description
*This publication is supported by the Raman spectra data. Three datasets are attached in the supplementary materials.
idealcurve2.mat includes one Raman spectrum, that is the mean spectrum according to multiple in-control spectra.
XY.mat includes meansurement points coordinates (2916 points).
ZZ.mat includes Raman Intensity data for each Raman spectrum.

*The real Raman spectrum data is collected by Renishaw™ inVia micro-Raman system with custom-designed remote optical probe and roller sample stage. In all measurements, Near Infra-Red (NIR) laser with a wavelength of 785nm and a laser output power of 150mW was used to eliminate the effect of ambient light. A low magnification lens was used to achieve larger focus tolerance.

*The authors have legitimate access to data. 

*Link to data (The dataset will be deposited to the authors’ webpage if the manuscript is accepted. It will also be provided as supplementary materials accompanying this paper)


## License
Our code is released under MIT License (see LICENSE file for details).


## Note
* Note: to run the code, WTortho.m and orthofil.m from the wavelab (http://statweb.stanford.edu/~wavelab/) are needed to generate wavelet basis
* Note: to compare the PMD with the benchmark method SSD, the bsplineSmoothDecompauto.m and bsplineBasis.m from Hao Yan are used. 

## Reproducibility
The Fig. 3-8, 10-12, Tables I can be reproduced by the code and datasets.


## Contact Information

Jianjun (Jan) Shi
The Carolyn J. Stewart Chair and Professor
H. Milton Stewart School of Industrial and Systems Engineering
765 Ferst Drive, Groseclose Building, Room 109
Georgia Institute of Technology
Atlanta, Georgia 30332-0205
http://www2.isye.gatech.edu/~jshi33

Xiaowei Yue
Assistant Professor 
Grado Department of Industrial and Systems Engineering
Virginia Tech
113 Durham Hall (MC 0118), 1145 Perry Street, Blacksburg, VA, 24061 USA 	
https://ise.vt.edu/yue.html
