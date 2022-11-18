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

In the movie metadata dataset, the number of movies with revenue data is a bit small (8401/81741). We need to enrich the data with other sources of revenue information.

We tried to find a revenue dataset from <https://zenodo.org/record/1240586#.Y3eqfOyZOrM>. It contains IMDB ID and revenue information for about 8000 movies. We convert the IMDB ID to freebase ID and merge it with the movie metadata dataset. After merging, we have 10306 movies with revenue data in total.

There are other revenue datasets like IMDB mojo and OpusData, but they are not free. We may try to contact them for help in the future.

## Methods

### 1. Latent Dirichlet Allocation (LDA) for topic modeling.

#### 1.1 Text Cleaning

1. Exclude stop words and punctuations. 
2. Tokenize the sentence. 
3. Delete name of person using NER (with spacy pre-trained model).

#### 1.2 Creating the model

1. Use the LdaMulticore class in gensim to speed up modeling.
2. Select the best "number of topics" using coherence score. (gensim.models.coherencemodel)
3. Assign each movie to one topic with the highest probability or combine multiple topics, weighted by the probability of the movie belonging to this topic. 

### 2. Keywords extraction of each movie plot.

#### 2.1 Creating the model for keyword extraction

1. Use KeyBERT for the extraction.
2. Use "all-MiniLM-L6-v2", as it is claimed to be the best model for English text.
3. For a paragraph of text, the model can give the keywords with probability. 

#### 2.2 Creating keyword vector for each movie plot

1. Load Global Vectors for Word Representation (GloVe) for word vectors. Use the 100d version with 400000 vocabulary. 
2. Sum over all keywords vectors of one movie plot (here it can be weighted by the probability or not weighted). Only pick the word with a probability higher than a fixed value (needs to be decided).

#### 2.3 Grouping the keyword vectors

1. Use K-Means to cluster all keyword vectors without supervision. Number of clusters need to be decided.
2. Assign each movie to a keyword cluster using the distance between its keyword vector and the cluster center.

#### 3 Qualitatively and quantitatively evaluate the average revenue in each topic & keyword group of movies. 

1. Qualitative results are visualized using bar plots. (Preliminary results can be seen in the notebook!)
2. Quantitative results can be obtained via hypothesis testing or comparison between CI.
3. Quantitative results visualization with heatmap.

#### 4. Genre-related analysis of topics and keywords.

1. Identify main genres using the frequency of each genre, or by clustering with genre word vectors.
2. Group movies according to their genres (only use main genres).
3. Extract top-selling and bad-selling topics & keywords in each main genres. 
4. Visualize the result using word clouds. 

#### 5. Time-related analysis of topics and keywords.

1. Discretize time into several periods (decades, five-year, annual, etc)
2. Group movies according to their release time period.
3. In each time period, find the top-selling and bad-selling topics & keywords.
4. Visualize the result using word clouds. 

### 6. For each topic group or keyword group of movie, extract the actors that earn the most or least.

#### 6.1 Case study of actors with "specialty"

1. Find the actors that have the highest average revenue (of movies that he/she is in) in one group but have the lowest in others. 
2. Try to devise a reason for each actor with the situation described in (1).

#### 6.2 Identify out-dated actor

1. Find the actors that have a decreasing trend of average revenue of movies that he/she is in. 
2. Correlate the change to the trend found in task 

### 7. Build revenue relationship between top-selling movies and other movies in the same closed time period.

#### 7.1 Definition of top-selling movies(top blockbusters)
There is no quantitative definition about blockbuster given by the film industry. Therefore, we give a simple and clear definition of top blockbusters. We simply define them as the annual box office champions. However, based on their revenue, we can also refine the blockbusters to different levels(eg. With box office revenue higher than 1 billion,2 billion...)

#### 7.2 Definition of movies released in a close period with the top blockbusters
Given some empirical knowledge about the historical box office, we give a preliminary definition for movies released in a close period with the top blockbusters: Movies that are released in the same month with the top blockbusters are considered to be released in a close period.

#### 7.3 Assumptions and analysis

* We assume that top blockbusters have a negative influence on the revenues of movies released close to it. 
* To prove our assumption, we wanna minimize the impact on revenues due to those movies' own quality. Although film producers may not agree that box office revenue is an ideal indication of movie quality, we as data scientists, will still make a naive assumption that high box office revenue always means high quality. Therefore, our analysis will be mainly conducted on the median of revenue of those movies released close to the top blockbuster since extremely low revenue may be mainly caused by the movie's own quality, making the blockbuster's effect neglectable while high quality movies could easily overpower this negative influence.(Another movie released in the same month with the annual blockbuster might have just a slightly lower revenue. eg. *Avengers: Age of Ultron* and *Furious 7*)

#### 7.4 Rule out the influence of released months
*   Hordes of film analysts, more often than not, tend to believe that movies released in different time of the year, even with close topic or genres, have considerably different possibility to reach a high revenue. One classic argument is that movies released between Halloween and Christmas have a much higher chance to get higher revenue than movie released during spring(March,April). One can easily finds tons of examples.(eg. *Frozen* vs *Monsters University*, *Spider-Man: No Way Home* vs *Black Widow*) 
*   To defende out assumption against this potential influence, we also compare the revenue of our selected movie with the average revenue of movies from its genres that are released in the same month of the previous year and the next year. For example, since our selected movie *Rabbit without ears 2* is released in Dec,2009. We will compare its revenue to movies with the same genre that are released in Dec,2008 and Dec,2010

#### 7.5 Beyond genres

The analysis based on genres provides us with an intuitive demonstration of blockbusters' influence. However, even movies within the same genre could be extremely different(*Divergent* vs *The Hunger Games*). Therefore, we need a more precise way measure the similarity between movies in order to compare the revenue of our selected movies with its most similar movie that is not affected by any blockbuster. Currently, we have two ideas:

1.   Computing Euclidean distance or cosine similarity between the word vector extracted in Part 1.
2.   Merging the word vector and the other metadata of movies in a latent space and measured distance in that latent space.

However, the final choice and more detailed implementation will need more discussion.

## Proposed timeline

- 25.11 Enrich the revenue data with external sources, as listed in the additional dataset part. Revise the topic modeling and keyword extraction pipeline, tuning all the parameters to the best, including cluster number and topic number. 
- 02.12 Perform actor-related analysis. Start genre-related and time-related analysis, and other-movie-related analysis.
- 09.12 Start the development of website. Continue all analysis.
- 16.12 First draft of datastory website. Finish all analysis. 
- 23.12 Final version of datastory website. 

## Organization within the team

#### Yitao Xu: 

- Topic modeling and analysis with LDA
- Keyword extraction and analysis with KeyBERT
- Genre-related analysis with topics and keywords.

#### Jianting Guo:

- Time related analysis with topics and keywords
- Develop the final text for the data story

#### Tianxiao Shen:

- Continue exploring the dataset and enrich the revenue data with external sources
- Come up with meaningful visualizations
- Develop the website

#### Zehao Chen:

- Actor-related analysis and other movie analysis
- Develop the final text for the data story

## Questions for TAs (optional)
