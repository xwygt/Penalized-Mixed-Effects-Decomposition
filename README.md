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
