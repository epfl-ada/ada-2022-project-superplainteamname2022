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
    <figcaption>Error bar: 95 CI.</figcaption>
    </center>
    </figure>
</div>

<!-- <figure>
  <center>
    <img src="./images/Overall_average.png" width="600" height="600" style="vertical-align:middle">
    <figcaption>Error bar: 95 CI.</figcaption>
  </center>
</figure> -->

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

<!-- <figure>
    <center>
    <img class="average" src="./images/topic_revenue_average.png" width = 500 height = 500>
    <figcaption>Error bar: 95 CI.</figcaption>
    </center>
</figure> -->

<div>
    <figure>
    <center>
        <iframe src="./images/topic_revenue_average.html" width="600" height="500"></iframe> 
        <figcaption>Error bar: 95 CI.</figcaption>
    </center>
    </figure>
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

Clear patterns can be seen from clusters of KeySum, supporting our claim that keywords can be used for another method than topics for grouping movie plots. However, one subtle point could be that keyword clustering just repeat what topic modeling does. To eliminate this doubt, we visualize the distribution of topic id in each keyword cluster.

<figure>
  <center>
    <img src="./images/topic_in_keyword.png" width="800" height="600" style="vertical-align:middle">
  </center>
</figure>

Different topics appear in the same keyword cluster, supporting our seperated analysis on both topics and keywords. Moreover, it shows that topics and keywords are indeed two perspectives of viewing the movie plots.

We also visualize 15 top-frequent tokens in each keyword cluster, similar to the visualization of topics, to look into each cluster of what words are in it. 

<center>
  <img src="./images/keyword_vis.png" alt="" width="800" height="400">
</center>

The frequent word in topic modeling, such as "kill" or "fight", have disappeared in keyword analysis, which proves once again that topics and keywords are different from each other. 

### 1.4 Is the movie revenue in each KeySum cluster different from each other?

Finally, we can investigate whether the revenues are different in different KeySum clusters. Similar to analysis of topic groups, we first qualitatively visualize the KeySum group average and then do the quantification. 

<div>
    <figure>
    <center>
        <iframe src="./images/keyword_revenue.html" width="600" height="500"></iframe> 
        <figcaption>Error bar: 95 CI.</figcaption>
    </center>
    </figure>
</div>

<div>
    <center>
    <iframe src="./images/keyword_cluster_id.html" width="500" height="500"></iframe> 
    </center>
</div>

Two salient KeySum clusters appear, i.e., cluster 6 and 10. The word "train", in cluster 6, is not a noun but a verb. Why is that? Let us explain via two examples. `Star Wars Episode I`, `The Avengers` and other movies that are about a group of people to be trained are in that cluster (`Star Wars Episode I`, trained to be Jedi; `The Avengers`, a group of superhero is trained to form an organization). Cluster 10 is more easy to comprehend (Sci-Fi-like keywords!). We assume that people expect the growth of the characters (that's why they need to be trained), even if they are already strong individuals, rather than watching a superhero being invincible for two hours (typical movie length!). Moreover, like we have expected, the sci-fi-related keywords are preferred by audience. Movies in cluster 10: `Avatar`, `Transformers: Dark of the Moon`, `Spider-Man 3`, etc. 

However, we also notice several worse-selling KeySum clusters, such as 1,3,5,16. Looking at the keywords, they are all about some daily routine plots. Especially all the keywords in cluster 1, are about soap operas. We are not saying that these kinds of movies are bad, because movies like `There's Something About Mary`, `Shakespeare in Love` are in these clusters. However, we do claim that including those words in the movie plots cannot bring you much revenue! 

***The keywords in those blockbusters' plots are often related to "a group of people being trained" and Sci-Fi-related words like "aliens, scientist"!***

### 1.5 Are movies of different genres share the boost-selling tricks for writing the plots?

So far, we have come up with several suggestions on how to make a movie plot to help the movie earn more money, and how to avoid things in the plot that might undermine the movie revenue. However, a commonsense would be that  A question now would be, do movies of all genres share those suggestions? To answer it, we want to quantify the overlapping between top-selling topics and KeySum in each genre, and the overall top-selling topics and KeySum clusters. We propose to use Jaccard index to quantify the distance between two lists of indices, where indices can be topic id or KeySum cluster id. First, let's look at the topics.

#### 1.5.1 Quantifying the overlap between overall top-selling/worse-selling topics and those in different movie genres. 

We first extract top-10 top-selling and low-selling topics overall (10 topics are 40% of all topics, which can be regarded as top-selling ones). Then, for all movies belonging to each genre, we also extract top-10 topics similarly. We plot the Jaccard distance between those top-10 topics in each genre and the overall one.

<center>
  <img src="./images/overlap_topic.png" alt="" width="800" height="400">
</center>

The first thing to notice is that some of the Jaccard indexes are too high, like why does the genre "Comedy" need topics in 4, 18, 13 (contains "kill, fight" etc.)? The reason is that the movie genre is quite loose. For example, if an Adventure movie contains some has some comedic elements, it will belong to Comedy genre (`Pirates of the Caribbean: At World's End` is both Adventure and Comedy!). This phenomenon reflect that introducing comedic elements into movies related to "kill, fight, attack" can also bring more revenue.

In the top-selling part, we observe that "Documentary", "Indie", "Crime Fiction" overlap not so much with the overall topic-selling trend, while in the low-selling part, the weird genres become "Documentary" and "Indie". Little overlapping indicates that movies in these genres cannot adopt our suggestions, and need specific treatment. We further extract the top-selling and low-selling topic ids in those movie genres, and **exclude** the overall top-selling and low-selling topics, to provide more specific guidance for what should those movies include in the plots.

<center>
| Movie Genre     | Top-selling Topics | Low-selling Topics |
|-----------------|--------------------|--------------------|
| Crime Fiction   | 24, 8, 17, 6       | 11                 |
| Documentary     | 3, 7, 15, 24       | 9, 6, 17, 22, 8, 13|
</center>

We observe that for Crime Fiction, it seems a bit weird that the top-selling topics include some topics that are not related to "Crime", namely 24 and 17. That's because the movie plots focus more on the background of crimes instead of the crime itself, like movie `Sister Act` and `Dangerous Minds`. For Documentary, as we have expected, this kind of movie needs to be as realistic as possible to attract people, and that's why topic 7,15,24 can bring more revenue to Documentary. Moreover, people need some documentaries on crimes for society to learn a lesson, and this is why topic 3 is in top-selling topics in documentary (e.g.,`Crime After Crime`). However, some documentaries about war or other heavy topics in real world might cause oppressive atmosphere and make people not want to watch the movie, like `Into Eternity`. That's why topic 13, 8 etc are in the low-selling topics in Documentary. 

#### 1.5.2 Quantifying the overlap between overall top-selling/worse-selling KeySum clusters and those in different movie genres. 

Similar to the analysis for topics, we extract top-8-selling and low-8-selling (~47% of all KeySum clusters) KeySum clusters and perform similar analysis as in topics. 

<center>
  <img src="./images/overlap_keyword.png" alt="" width="800" height="400">
</center>

<center>
| Movie Genre     | Top-selling KeySum Cluster | Low-selling KeySum Cluster |
|-----------------|----------------------------|----------------------------|
| Documentary     | 4, 8, 16, 3                | 6, 0, 14, 2                |
| Horror          | 5, 9, 3                    | 0, 11, 14, 8               |
</center>

Again, Documentary appears! Similar to the aforementioned reasons, movies belonging to Documentary have different top/low-selling topics than others. Moreover, Horror movies have a different low-selling topics than the mainstream, indicating that filmmakers need to pay extra attention to those keywords in plots when making Horror movies. All those keywords are about the daily routine, which is hardly horrible.

***To filmmakers of Documentary, Horror, and Crime Fiction: Do not follow the crowd! Adopt genre-specific strategies!***

### 1.6 Are the ranking of revenues of topic and KeySum groups constant through time?



<video width="320" height="240" controls>
  <source src="./images/topic.mp4" type="video/mp4">
</video>

<video width="320" height="240" controls>
  <source src="./images/keyword.mp4" type="video/mp4">
</video>


