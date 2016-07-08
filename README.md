# LOFS: A Library of Online Streaming Feature Selection

As an emerging research direction, online streaming feature selection deals with sequentially added dimensions in a 
feature space while the number of data instances is fixed. Online streaming feature selection provides a new, complementary algorithmic methodology to enrich online feature selection, especially targets to high dimensionality in big data analytics. 

LOFS is a software toolbox for online streaming feature selection. It provides the first open-source library for use in MATLAB and OCTAVE that implements the state-of-the-art algorithms of online streaming feature selection. The library is designed to facilitate the development of new algorithms in this research direction and make comparisons between the new 
methods and existing ones available. LOFS is available from https://github.com/kuiy/LOFS.


Copyright © 2015 Kui Yu, Wei Ding, and Xindong Wu

License: GNU GENERAL PUBLIC LICENSE Version 3


The LOFS architecture is based on a separation of three modules, that is, CM (Correlation Measure), Learning, 
and SC (Statistical Comparison). 

The three modules in the LOFS architecture are designed independently, and all codes follow the MATALB/OCTAVE standards. This makes that the LOFS library is simple, easy to implement, and extendable flexibly. One can easily add a new algorithm to the LOFS library and share it through the LOFS framework without modifying the other modules.
 
In the CM module, LOFS provides four measures to calculate correlations between features, Chi-square test, G2 test, Fisher's Z test, and mutual information, where Chi-square test, G2 test, and mutual information for dealing with discrete data while Fisher's Z test for handling continuous data.

With the measures above, the learning module consists of two submodules, LFI (Learning Features added Individually) 
and LGF (Learning Grouped Features added sequentially). The LFI module includes Alpha-investing OSFS, Fast-OSFS, and 
SAOLA to learn features added individually over time, while the LGF module provides the group-SAOLA algorithm to online
mine grouped features added sequentially.

Based on the learning module, the SC module provides a series of performance evaluation metrics (i.e., prediction accuracy, 
AUC, kappa statistic, and compactness, etc.). To conduct statistical comparisons of algorithms, the SC model further provides the Friedman test and the Nemenyi test.
