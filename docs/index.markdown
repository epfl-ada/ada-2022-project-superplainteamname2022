---
layout: default
---
<img src="./images/movie_poster.jpg">

## Overview

The box office revenue of a movie is one of the most critical measurements of its success. The revenue of a movie can be affected by multiple factors.  Internal factors such as topic and keywords in movie plots and actors as well as external factors like other movies released in the same period can have a large impact on a movie's revenue. Studying the effect of plots, actors, and same-period movies on the revenue of movies can shed light on what movies should filmmakers make if they want to earn more, and can give an overview of the development of the movie industry. In this project, we first investigate what topics and keywords those blockbusters have in their plots to show the effect of movie plots. Then we try to find certain actors that can bring more money to a certain kind of movie but can potentially doom the revenue of other kinds of movies. Finally, we will show the effect of other top-selling movies on movies in the same period. The dataset we use, CMU Movie Summary Corpus, contains 81741 movies and 39088 of them have a plot. Among the 39088 movies, 10306 of them have revenue data after our data completion. We conduct our analysis on those 39088 movies and draw conclusions from those movies that have revenue data.

First, let's look at the overall annual average revenue of movies, to have a rough glance at the development movie industry.


<div>
    <figure>
    <center>
    <iframe src="./images/Overall_average.html" width="700" height="700"></iframe> 
    </center>
    <figcaption>Error bar: 95 CI.</figcaption>
    </figure>
</div>

<figure>
  <center>
    <img src="./images/Overall_average.png" width="600" height="600" style="vertical-align:middle">
    <figcaption>Error bar: 95 CI.</figcaption>
  </center>
</figure>

We can see that the average annual revenue of the film industry has increased over time (good to hear this!), reflecting the thriving development of the film industry and the enhancement of people's purchasing power.


## Question 1: What do those blockbusters have in their plots?

Plot is one of the most important elements of a good movie. A good plot can make the audience willing to buy a ticket, while a terrible one can doom a movie, no matter how cool the special effects are. We consider two perspectives to study the movie plots, namely topics and keywords. The topic is a top-down way of investigating the plots, looking at the overall frequency of words, namely bag-of-word modeling, while keywords are bottom-up manner, extracting information from a single movie plot and doing further grouping. First, let's extract the topics from all the movie plots. 

### 1.1 What are the topics in those movies?

We first use topic modeling to extract 25 topics from movie plots and visualize the top 15 weighted words as a wordcloud in each topic. 

<center>
  <img src="./images/topic_vis.png" alt="Coherence score: 0.3452" width="700" height="700" style="vertical-align:middle">
</center>

Topics are different from each other. For example, topic 13 contains some negative words like "kill, destroy, attack" (`Iron Man` is in this topic) while topic 5 contains some postive words like "marry, love, life, familiy" (`Mamma Mia!` is in this topic). 

### 1.2 Is the movie revenue in each topic group different from each other?

To see whether the revenue of movies can be affected by its topic, we first visualize the average revenue in each topic group and then quantify the pair-wise differences between topic groups. Here, we first visualize the average revenue in each topic group and then quantify the difference in a heatmap, with all values significant (p<0.05, 0 value means non-significant comparison).

<figure>
    <center>
    <img class="average" src="./images/topic_revenue_average.png" width = 500 height = 500>
    <figcaption>Error bar: 95 CI.</figcaption>
    </center>
</figure>

<div>
    <center>
    <iframe src="./images/topic_revenue_average.html" width="500" height="500"></iframe> 
    </center>
</div>

<div>
    <center>
    <iframe src="./images/topic_id.html" width="500" height="500"></iframe> 
    </center>
</div>

Topics 4, 13 and 18 stand out on this figure and topics 13 & 18 have more compact CIs than topic 4. Looking at topics 13 and 18, they are all about "kill, fight, attack, destroy, escape", and all of them are events that we rarely encounter in our daily life. We assume that people are willing to buy tickets for those kinds of movies because 1) Routine life sometimes is boring and people needs some excitement, and 2) The development of special effects creation in cinemagraphs make the expressiveness of those kinds of movies increase a lot while barely changing the movies with topics 15, 1, which are narrative movies about "interview" (topic 15) or "story" (topic 1). The two reasons can also explain why the aforementioned two topics, 15 & 1, have bad sales in average. 

***Those blockbusters typically contain "kill, fight, attack, destroy, escape" in their topics!***

### 1.3 What are the keywords in the plot of each movie?

While topics provide a top-down view of all movie plots, it remains unclear whether we can group movie plots in a bottom-up manner, namely first looking at the important information in each movie plot and then trying to identify patterns in the collected important information. First, we define the **important information** in movie plots as **keywords**. We use KeyBERT to extract all unigram, bigram, and trigram keywords in each movie plot and turn each token in the extracted keywords into a pre-trained word vector. The sum of all keyword vectors then represents all the important information we summarize from a movie plot, defined as **KeySum**. We then use K-Means to cluster those KeySum into 17 clusters. Visualization of 10 of 17 KeySum clusters (to avoid clutter) is given below (reduce dimensionality to 2 for visualization using t-SNE). 

<figure>
  <center>
    <img src="./images/keyword_cluster_vis.png" width="600" height="600" style="vertical-align:middle">
  </center>
</figure>

Clear patterns can be seen from clusters of KeySum, supporting our claim that keywords can be used for another method than topics for grouping movie plots. However, one subtle point could be that keyword clustering just repeat what topic modeling does. To eliminate this doubt, we visualize the distribution of topic id in each keyword cluster

<figure>
  <center>
    <img src="./images/topic_in_keyword.png" width="800" height="600" style="vertical-align:middle">
  </center>
</figure>

Different topics appear in the same keyword cluster, supporting our seperated analysis on both topics and keywords. Moreover, it shows that topics and keywords are indeed two perspectives of viewing the movie plots.

We also visualize 15 top-frequent tokens in each keyword cluster, similar to the visualization of topics, to look into each cluster of what words are in it. 

<center>
  <img src="./images/keyword_vis.png" alt="" width="800" height="550" style="vertical-align:middle">
</center>

The frequent word in topic modeling, such as "kill" or "fight", have disappeared in keyword analysis, which proves once again that topics and keywords are different from each other. Finally, we can investigate whether the revenues are different in different KeySum groups. Similar to analysis of topic groups, we first qualitatively visualize the KeySum group average and then do the quantification. 


<figure>
    <center>
    <img class="average" src="./images/keyword_revenue.png" width = 500 height = 500>
    <figcaption>Error bar: 95 CI.</figcaption>
    </center>
</figure>

<div>
    <center>
    <iframe src="./images/keyword_cluster_id.html" width="700" height="700"></iframe> 
    </center>
</div>


<video width="320" height="240" controls>
  <source src="./images/topic.mp4" type="video/mp4">
</video>

<video width="320" height="240" controls>
  <source src="./images/keyword.mp4" type="video/mp4">
</video>


