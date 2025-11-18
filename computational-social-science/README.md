# Political Books on Amazon Italy: Topics, Emotions, and Network Dynamics

### Project summary

This repository contains the materials, code, and results for a Computational Social Science project investigating how political bestsellers on Amazon Italy shape and reflect ideological, emotional, and interactional dynamics. Developed within the academic context of the *Computational Social Science* exam, the project combines web scraping, topic modeling, emotional analysis, and multilayer network methods to study reviews as a form of social and political behavior.

The dataset represents a **snapshot of the political bestsellers at the moment of data collection** (may 2025), which can be interpreted as a cultural and political “thermometer” of Italy’s public discourse. The books that dominate the charts at a given time mirror the topics receiving the greatest media attention, reflecting broader socio-political tensions, interests, and narratives circulating in that specific historical moment.

Within this landscape, the study conceptualizes Amazon not merely as a marketplace but as a **social platform**, where reviews, reactions, and recommendation algorithms contribute to shaping the visibility and emotional salience of ideological content. By analyzing **3,748 reviews across 100 political bestsellers**, the project investigates how themes, emotions, and user engagement cluster around politically charged works.

While the phenomenon surrounding Roberto Vannacci’s *Il mondo al contrario* stands out for its volume of attention, another significant pattern emerges from the reviews of Francesca Albanese’s work. Compared to other bestsellers, Albanese’s book displays a **remarkably high level of emotional engagement**, suggesting a strong attachment to both the topic and the author. In retrospect, this emotional intensity may be read as an early indicator of the renewed social mobilization in Italy around the **Israeli–Palestinian conflict**, which experienced a notable escalation from May onward.

---

## Key points

### Research questions

1. RQ1: What themes emerge from reviews of Italian political bestsellers, and how are they structured within Amazon’s review network?
2. RQ2: How do textual features—especially emotions—correlate with user interaction (helpfulness reactions)?
3. RQ3: Do different political and cultural themes elicit distinct emotional profiles in the reviews?

---

## Techniques & methods

### 1. Data collection & preprocessing

* Scraped 100 books from Amazon Italy’s *Politics* bestseller list (May 7, 2025), retrieving up to 500 reviews per title.
* Extracted 3,748 reviews (title, text, number of “helpful” reactions).
* Reviews were sorted by Amazon’s “most relevant” default logic, giving prominence to socially salient content.
* Preprocessing and cleaning performed using Python, Selenium, BeautifulSoup, spaCy.

---

### 2. Topic modeling

* Implemented LDA (Latent Dirichlet Allocation) to assign each review a prevailing topic.
* After qualitative evaluation, 10 interpretable topics were selected, including:

  * *Society & identity*
  * *Geopolitics*
  * *Israeli-Palestinian conflict*
  * *History and memory of fascism*
  * *Vannacci-specific topic*
  * *Book quality* and *purchase experience*

Topic modeling was used to map thematic clusters and to construct a multilayer network.

---

### 3. Multilayer network modelling

A Heterogeneous Information Network (HIN) was built with four node types:

* B: Books
* R: Reviews
* T: Topics
* U: Helpfulness reactions

Edges:

* *B–R* (book–review),
* *R–T* (review–topic),
* *R–U* (review–reaction).

Network analysis was conducted with NetworkX and visualized using Gephi.

The project employed:

* Degree centrality
* Meta-path analysis (B–R–U, T–R–U)
* PathSim to measure book similarity through shared topics.

---

### 4. Emotional analysis

Using EmoAtlas, each review was annotated with:

* Primary emotions (Plutchik’s eight categories) based on z-scores (|z| > 1.96).
* Complex emotions (emotional dyads), computed only when both contributing emotions were statistically significant.

This enabled a nuanced mapping of emotional landscapes rather than simple sentiment polarity.

---

### 5. Statistical testing

* Spearman correlation between review length and number of reactions.
* Shapiro-Wilk and Mann-Whitney U for comparing reactions across emotional categories.
* Chi-square tests to assess dependencies between topics and emotional expression.

---

## Main findings

### Network structure and thematic patterns

* *Il mondo al contrario* by Roberto Vannacci overwhelmingly dominated network activity:

  * 10× more B–R–U paths than the second most active book.
  * Highly polarized emotional and thematic clustering.

* Certain topics—especially *Society & Identity* and *Vannacci*—showed dense interconnections and strong user engagement.

### Emotional dynamics

* The most frequent emotions across topics were Anticipation, Joy, and Trust, reflecting the generally positive skew of Amazon bestseller reviews.
* Highly charged topics (e.g., fascism, Israeli-Palestinian conflict, Vannacci) triggered:

  * Above-average Disgust, Anger, Fear, and Sadness.
  * A diverse and complex range of emotional dyads (e.g., *Remorse*, *Aggressiveness*, *Shame*, *Unbelief*).

### Interaction patterns

* Longer reviews received significantly more useful reactions (Spearman ρ ≈ 0.45).
* Reviews with complex emotions received *fewer* reactions, suggesting that overly emotional content is perceived as less informative by users.
* Strong statistical association between topics and emotional expression, indicating that certain themes systematically elicit distinct emotional responses.

---

## Conclusions

The project demonstrates that Amazon reviews operate as a form of social interaction that reflects broader ideological, emotional, and cultural dynamics. Key takeaways:

* The Vannacci phenomenon shows how a book can become an identity marker, generating intense ingroup/outgroup polarization visible in both textual and interactional data.
* Beyond the Vannacci case, Francesca Albanese’s book stands out for its exceptionally high level of emotional engagement compared to other political bestsellers. This suggests not only a deep attachment to the work and its themes, but—retrospectively—may also be interpreted as an early indicator of the renewed social mobilization in Italy around the Israeli–Palestinian conflict, which intensified significantly from May onward.
* The combination of HIN network analysis and emotion modeling offers a powerful framework for understanding how political and cultural content circulates on platforms.
* Amazon’s architecture—visibility mechanisms, reactions, ranking systems—plays a fundamental role in amplifying emotional and ideological signals.

Overall, the study highlights Amazon as a hybrid socio-technical environment, where cultural products, user interactions, and platform algorithms jointly shape the public sphere.
