# Title

What is affecting movies' box office revenue? An analysis of movies themselves and external factors.

## Abstract

The box office revenue of a movie can be affected by multiple factors. Internal factors such as plots and actors as well as external factors like other movies released in the same period can have a large impact on a movie's revenue. Studying the effect of plots, actors, and same-period movies on the revenue of movies can shed light on what movies should filmmakers make if they want to earn more. In this project, we first investigate what topics and keywords do those blockbusters have in their plots to show the effect of movie plots. Then we try to find certain actors that can bring more money to a certain kind of movies but can potentially doom the revenue of other kinds of movies. Finally, we will show the effect of other top-selling movies on movies in the same period.

## Research Questions
1. What do those blockbusters have in their plots?
We want to see whether the top-selling movies are characterized by certain topics and keywords both qualitatively and quantitatively, since topics and keywords can be regarded as different directions of analysis (topic is top-down manner, looking at the overall frequency of words, namely bag-of-word modeling, while keywords is bottom-up manner, extracting information from a single movie plot and do further grouping). Moreover, do those money-making keywords and topics change with movie genres and time?
2. Before casting an actor, does the actor fit the movie?
Is there a certain set of actors that can bring much more revenue to movies belonging to certain topics or keywords clusters, but have terrible performance under other kinds of movies?
3. How will top blockbusters affect the revenues of other movies released in a close period?

## Proposed additional datasets (if any)
More revenue data on 
https://www.boxofficemojo.com/chart/top_lifetime_gross/

## Methods
### 1. Latent Dirichlet Allocation (LDA) for topic modeling.
#### 1.1 Text Cleaning
    (1) Exclude stop words and punctuations. 
    (2) Tokenize the sentence. 
    (3) Delete name of person using NER (with spacy pre-trained model).
#### 1.2 Creating the model
    (1) Use the LdaMulticore class in gensim to speed up modeling.
    (2) Select the best "number of topics" using coherence score. (gensim.models.coherencemodel)
    (3) Assign each movie to one topic with the highest probability or combine multiple topics, weighted by the probability of the movie belonging to this topic. 
### 2. Keywords extraction of each movie plot.
#### 2.1 Creating the model for keyword extraction
    (1) Use KeyBERT for the extraction.
    (2) Use "all-MiniLM-L6-v2", as it is claimed to be the best model for English text.
    (3) For a paragraph of text, the model can give the keywords with probability. 
#### 2.2 Creating keyword vector for each movie plot
    (1) Load Global Vectors for Word Representation (GloVe) for word vectors. Use the 100d version with 400000 vocabulary. 
    (2) Sum over all keywords vectors of one movie plot (here it can be weighted by the probability or not weighted). Only pick the word with a probability higher than a fixed value (needs to be decided).
#### 2.3 Grouping the keyword vectors
    (1) Use K-Means to cluster all keyword vectors without supervision. Number of clusters need to be decided.
    (2) Assign each movie to a keyword cluster using the distance between its keyword vector and the cluster center.

#### 3 Qualitatively and quantitatively evaluate the average revenue in each topic & keyword group of movies. 
    (1) Qualitative results are visualized using bar plots. (Preliminary results can be seen in the notebook!)
    (2) Quantitative results can be obtained via hypothesis testing or comparison between CI.
    (3) Quantitative results visualization with heatmap.
#### 4. Genre-related analysis of topics and keywords.
    (1) Identify main genres using the frequency of each genre, or by clustering with genre word vectors.
    (2) Group movies according to their genres (only use main genres).
    (3) Extract top-selling and bad-selling topics & keywords in each main genres. 
    (4) Visualize the result using word clouds. 
#### 5. Time-related analysis of topics and keywords.
    (1) Discretize time into several periods (decades, five-year, annual, etc)
    (2) Group movies according to their release time period.
    (3) In each time period, find the top-selling and bad-selling topics & keywords.
    (4) Visualize the result using word clouds. 
### 6. For each topic group or keyword group of movie, extract the actors that earn the most or least.
#### 6.1 Case study of an actor
     (1) Find the actors that have the highest average revenue (of movies that he/she is in) in one group but have the lowest in others. 
     (2) Try to devise a reason for each actor with the situation described in (1).
#### 6.2 Identify out-dated actor
    (1) Find the actors that have a decreasing trend of average revenue of movies that he/she is in. 
    (2) Correlate the change to the trend found in task 
### 7. Build revenue relationship between top-selling movies and other movies in the same closed time period.
    
## Proposed timeline
- 25.11 Enrich the revenue data with external sources, as listed in the additional dataset part. Revise the topic modeling and keyword extraction pipeline, tuning all the parameters to the best, including cluster number and topic number. 
- 02.12 Perform actor-related analysis. Start genre-related and time-related analysis, and other-movie-related analysis.
- 09.12 Start the development of website. Continue all analysis.
- 16.12 First draft of datastory website. Finish all analysis. 
- 23.12 Final version of datastory website. 
## Organization within the team
#### Yitao Xu: 
    (1) Topic modeling and analysis with LDA
    (2) Keyword extraction and analysis with KeyBERT
    (3) Genre-related analysis with topics and keywords.
#### Jianting Guo:
#### Tianxiao Shen:
#### Zehao Chen:
time related analysis with topics and keywords,
actor analysis
other movie analysis
website
## Questions for TAs (optional)

