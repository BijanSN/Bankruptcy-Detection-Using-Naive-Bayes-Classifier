# Bankruptcy-Detection-Using-Naive-Bayes-Classifier

* **Qualitative_Bankruptcy.data.txt**   : The project's dataset described below.
* **Project_datamining.R**              : Data pre-processing and Data exploration/visualisation.
* **NaivebayesClassifier.R**            : Implements the Naive Bayes Classifier on the qualitative data set.


# Introduction
It is common in the insurance industry to study the history of previous diseases (or ultimately, deaths) of past individuals to understand what factors might lead to a higher probability of being hospitalised in order to charge insured persons the fairest amount of premium reflecting their characteristics. Similarly, bankruptcy –referring to the death of legal entities in the financial literacy- might be as interesting to model/predict in order to correctly price their appropriate value, given their own attributes the same way as physical persons.
From the firm’s point of view, if their financial distress is detected early, chances are that they might use this extra information in order to plan better managerial decisions. This highlights the fact that bankruptcy detection is very useful for management purposes. The problematic is as follows; firms/investors/auditors have incentives to assess the value of one’s firm. In order to do so, they need proper information of the probability of default. The goal of the study is therefore to classify bankruptcy level (if the firm is soon to be bankrupt or not) given certain attributes related to internal risks. The attributes used in this study are the following: Industrial Risk, Management Risk, Financial Flexibility, Competitiveness and Operating Risk. Using intuition, it’s relatively easy to understand that if those risks are badly managed, they will all contribute at some extend to the failure of the firm, as we’ll see during the explanatory analysis. Indeed, the sensitivity to changes in macroeconomic factors, their human resources management or even their financing strategy affects the way firms are more or less likely to be defaulting. Given the huge amount of variables involved for this task, data mining techniques are highly interesting in order to detect outliers –companies which are prone to be bankrupt.

Concerning past studies related on this dataset “The discovery of experts’ decision rules from qualitative bankruptcy data using genetic algorithms” compares their proposed solution of bankruptcy prediction modelling: GAs (genetic algorithms) methods with classical statistical and neural network methods. Another source “A PREDICTIVE SYSTEM FOR DETECTION OF BANKRUPTCY USING MACHINE LEARNING TECHNIQUES” compared several techniques in order to select the best one- which in their case was the SVM.
Following the general consensus, neural network tends to perform better on this particular task as they do not make any assumption regarding the normality of characteristics’ distribution. In term of prediction accuracy, they also outweigh classical statistical methods [2]. However, they also highlight the fact that neural networks lack solid guidelines on determining their network configuration and may suffer from overfitting, leading to false predictions [1].
All this information guided the conception of this present study to use a different method, the naïve bayesian classifier in order to understand where it excels as well as its limitations. Unlike the previous study, this data mining project will not focus on the comparison of different methods, but more on why this specific method is adapted to the problem it’s trying to solve.

Bankruptcy detection methods in general are well documented; various methods work, such as multivariate discriminant analysis (MDA), logistic regressions, random forests, neural network(NN), support vector machines(SVM), or even hybrid methods developed more recently. [1]

# Dataset and pre-processing
The dataset comes from an anonymous south Korean bank collected from 2001 to 2002. It comes from the UCI Machine repository, initially used by Myoung-Jong Kim and Ingoo Han. [1] For each firm, the dataset contains six categorical attributes, their respective level -either negative, average or positive denoted respectively as ‘N’, ‘A’ &’P’- and a qualitative variable capturing if the firm is bankrupt or not. As stated in the introduction, these attributes are the Industrial Risk, Management Risk, Financial Flexibility, Competitiveness and Operating Risk.
In order to perform feature selection, the 6 nominal variables -negative, average, positive- were converted into numerical values; scaled from 0 to 2.

![alt-text](https://github.com/BijanSN/Bankruptcy-Detection-Using-Naive-Bayes-Classifier/blob/master/Figures/Variables.png)

Overall, the quality of the data is excellent, containing no missing values, duplicate data nor obvious inconsistent values. The dataset -containing 149 non-bankrupted entities and 107 bankrupted ones- is relatively small. Therefore, no dimension reduction technique was used.
The barplots found below contain the frequencies of each respective level for all attributes.

![alt-text](https://github.com/BijanSN/Bankruptcy-Detection-Using-Naive-Bayes-Classifier/blob/master/Figures/Rplot03%20(2019_12_21%2004_37_02%20UTC).jpeg)
N, A and P respectively stands for Negative, Average and Positive


As we can see, the dataset is overall well balanced, and offers observations in each level for all qualitative variables. On a side note, there is a small underrepresentation of average competitive firms and firms with average operating risks.
In order to check the redundancy of the attributes, the linear dependence structure was studied though the Pearson’s correlation. Due to the algorithm constraint, the class “bankrupt/not bankrupt” was also converted to a binary factor. Intuitively, higher internal risks will be positively correlated to bankruptcy.

![alt-text](https://github.com/BijanSN/Bankruptcy-Detection-Using-Naive-Bayes-Classifier/blob/master/Figures/Correlations.png)

A more graphical and intuitive way to express the following matrix is done by using a correlogram of the precedent matrix:

![alt-text](https://github.com/BijanSN/Bankruptcy-Detection-Using-Naive-Bayes-Classifier/blob/master/Figures/Rplot11%20(2019_12_21%2008_37_32%20UTC).jpeg)

The darkest area suggests a higher correlation.


Our major interest in this section lies in the feature selection and therefore the redundancy of the data must be checked. As we can see, competitiveness-credibility and financial flexibility-credibility are highly correlated with each other, which can question whether credibility really adds any value over the other attributes. For this reason, the study was implemented with and without this particular variable to see its impact on the classification result.


One very important notion should be highlighted here: the independence assumption of the classifier used in this study is seriously violated by the previous graph. Indeed, the Naïve Bayesian classifier uses the assumption of independence in order to use the property that the product of each conditional probabilities equals to the posterior distribution, as summarised in the next section. If this property is violated, one could argue about the performance of the naïve bayesian classifier. This discussion will continue throughout the study.

# Algorithm: Naïve Bayes

In our case, we are interested in the probability to belonging to a certain class Ck (bankrupt or not) given attributes X (internal risks). Using the Bayes theorem: 

* 𝑃(𝐶𝑘|𝑋)=𝑃(𝐶𝑘)⋅𝑃(𝑋|𝐶𝑘)𝑃(𝑋) or 𝑃𝑜𝑠𝑡𝑒𝑟𝑖𝑜𝑟=𝑃𝑟𝑖𝑜𝑟⋅𝐿𝑖𝑘𝑒𝑙𝑖ℎ𝑜𝑜𝑑𝐸𝑣𝑖𝑑𝑒𝑛𝑐𝑒 

* 𝑃(𝐶𝑘)is the prior probability of class k. The probabilities associated to C(B) and C(NB) are respectively 0.42 and 0.58 as shown on the side. 

* 𝑃(𝑋|𝐶𝑘), known as the likelihood or conditional probability, represents the probability of observing a certain value given a certain class. For example, knowing that the firm is bankrupt, what was the probability associated to belonging in each internal risk levels?

![alt-text](https://github.com/BijanSN/Bankruptcy-Detection-Using-Naive-Bayes-Classifier/blob/master/Figures/Rplot08%20(2019_12_21%2008_37_32%20UTC).jpeg)

They can be represented as above. Blue indicates the class not-bankrupt and red the bankrupt case. An alternative representation -unstacked- is showed below as well, as it demonstrates more clearly the next point.

![alt-text](https://github.com/BijanSN/Bankruptcy-Detection-Using-Naive-Bayes-Classifier/blob/master/Figures/Rplot09%20(2019_12_21%2008_37_32%20UTC).jpeg)

As we can see, the conditional probabilities associated to being bankrupt decreases with the level of nearly all internal risks, and similarly, the conditional probabilities associated to non-bankruptcy increases with lower risks. It’s intuitive since the probability of being bankrupt tends to be larger for high internal risks and lower for non-bankrupt firms.
One important thing to notice concerns the competitiveness of the firm. Indeed, the naïve Bayes classifier uses the assumption that the product of conditional probabilities of the data on their respective classes is used in order to compute the posterior probability, as showed below.

𝑃(𝐶𝑘|𝑋)=Π𝑃(𝑋𝑖|𝐶𝑘)𝑛𝑖=1

Unfortunately, the probability distribution for (positive competitiveness| Bankrupt) as well as (negative competitiveness| Not Bankrupt) are equal to zero, yielding the whole posterior probability to equal zero. (graphically highlighted below)

![alt-text](https://github.com/BijanSN/Bankruptcy-Detection-Using-Naive-Bayes-Classifier/blob/master/Figures/Rplot10%20(2019_12_21%2008_37_32%20UTC).jpeg)

In order to bypass this specific problem, LaPlacian smoothing was implemented, increasing by a small amount the missing conditional probabilities, in order to have coherent values. The classifier will choose the class where the posterior probability is maximised.
One can argue why the Bayes classifier was used in this case. Indeed, as stated before, there is a violation of the independence between the attributes. However, as seen in the literature as well as on the results, the classifier has a relatively good performance. The choice of this classifier was partially due to curiosity to see how the lack of support of this assumption could affect the algorithm performance. Moreover, it detects non-linear relationships and is robust to noisy examples, as it the case with complex bankruptcy data.
Following this exploratory analysis, one can argue that the data might be overlapping. This leads to the fact that Gaussian mixture models or the k-mean classifier would not be wise. They were therefore judged inappropriate.
Results and Analysis
Splitting the data into 2/3 training and 1/3 testing, the following results for the complete model have been found:
As a reminder, the Accuracy is the sum of true positives and true negatives over the total observations, in this case equals (35+46)/ (82) = 81/82= 0.978
The true positive rate (TPR also called sensitivity or recall) is defined as the true positives over the sum of true positives and false negatives, leading to 1- since there is no false negatives.
The true negative rate (TNR also called specificity) measure the proportion of correctly identified negatives and equals 46/47=0.9787
As we can see the results are quite impressive. Firm bankruptcy can be detected with relative ease using this particular method despite the violation of assumption illustrated in the previous section.
The second model’s result - which does not feature competitiveness as it was seen as redundant in the previous section through a correlation-based feature selection - are below:




This model features less accuracy, sensitivity and specificity than the former model. The competitiveness was therefore useful in order to correctly classify the firms. This highlight the fact that the correlation-based feature selection might not work everytime as the correlation only captures the linear relationship among the data.
Major information was extracted; certain attributes are really significant in the determination of the bankruptcy, such as the competitiveness, credibility or financial flexibility. Even more overwhelming to see that no bankruptcy occurred when the company didn’t report any sign of frailty over competition. Of course, this is subject to selection bias, therefore no causal relationship should be imposed before conducting a proper study. Given the fact that these data are not representative of the whole market since it contains only data from a very specific country (South Korea), at a very specific timeframe (2001-2002), one should be careful handling these results.

![alt-text](https://github.com/BijanSN/Bankruptcy-Detection-Using-Naive-Bayes-Classifier/blob/master/Figures/ConfusionMatrix.png)
![alt-text](https://github.com/BijanSN/Bankruptcy-Detection-Using-Naive-Bayes-Classifier/blob/master/Figures/Sensitivity.png)

# Conclusion
To conclude, the naïve Bayes classifier worked very well despite the violation of the independence of the attributes. The goal of the study- classify bankruptcy level given internal risks metrics- is therefore achieved. However, one could add more complexity to the model by introducing time variant variables (if the availability of data permits) as well as the introduction of a cost matrix heavily impacting the classifier if it misclassifies one firm as not bankrupt where it’s the case. However, to put things into perspective, new useful non-obvious information was extracted in order to take better managerial decision: one should focus on reducing its competitive risk as soon as possible in order to reduce the probability of bankruptcy. The goal of data mining was found and the comparison of models lies into the competence of machine learning projects more that data mining.

# References
1) http://aircconline.com/ijdkp/V5N1/5115ijdkp03.pdf
2) https://link.springer.com/chapter/10.1007%2F978-3-319-67615-9_5

Relevant articles/websites used during the conception of the study:
https://www.aminer.cn/pub/53e9b4bfb7602d9703fd84c2/comparative-analysis-of-data-mining-methods-for-bankruptcy-prediction
https://cran.r-project.org/web/packages/naivebayes/naivebayes.pdf
https://doi.org/10.1016/j.camwa.2011.10.030
