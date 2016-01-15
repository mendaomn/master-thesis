# The context: Mondeca, the product and my responsibilities

In the ever expanding Web of data, content is quickly becoming more important than software itself. In such a context, the capability of giving meaning to unstructured data is more and more central to both big and small companies; at Mondeca^[http://www.mondeca.com/], indeed, the sentence _Making Sense of Content_ is written on the front-door of the office, as it is the company's motto. 
Indeed, the present work concerns the six months I spent as intern at Mondeca, a French company located in Paris which sells software products capable of exploiting semantic technologies. In particular, their main product is the so-called Smart Content Factory (SCF), a complex system that allows companies to index, annotate and browse through their documentation. Indeed, main targets of the product are those companies which need to handle huge amounts of documents (newspapers, legal offices, and so on).

Let's say that National Geographic (who, by the way, is among Mondeca's customers) wants an automatic way to handle all the scientific articles it publishes onto its website; this is what it will happen:

 - it can maintain an ontology with the system 
 - it may feed SCF with its documents and articles
 - SCF analyzes the documents via text mining tools and content annotation systems in order to recognize entities inside the text
 - the analysis outputs entities detected in the text, entities that have been inferred from the text (but that are not mentioned) and candidates that could be inserted in the ontology
 - a further rule-based classification is possible, meaning SCF will tag the documents according to some rules provided by the customer. For instance, SCF could tag as "Not for kids" the articles that are about crime, blood and sex
 - finally, it is possible to browse the whole documentation by means of a semantic search engine 

As the need for meaning and structure grows, a partially new challenge opens up for UI designers and data visualization experts: creating applications capable of exposing in a clear and meaningful way the real and valuable _content_ of a given piece of data, hopefully supporting further reasoning or action over the conveyed information. It is precisely what I've been tasked to do at Mondeca during my 6 months internship.

## The CAM application

What I will be working on is the so-called Content Annotation Manager (CAM), which is a component of the SCF system. It takes care of text mining a document, annotating it according to the selected ontology and yielding out the enriched document. 
As I enter the company, CAM is just a step of the process, it is automatically executed and it doesn't have a UI. Data flows in, data flows out. 
The only web UI that Mondeca has for CAM is a poorly presented testing environment ("demo") that they demonstrate to potential customers to show off the potential of their API (which ultimately exposes all the goodness the system produces).
Thus, my role inside Mondeca would be rethinking the current demo UI in order to provide an easy-to-use, sell-able and pretty web application that could serve the purpose of both convincing potential clients to trust the system and allowing them to actually monitor and intervene over this step of the pipeline.

Here's how it looks like at the moment:

![Old CAM, Annotations][oldcam_annotations]

![Old CAM, Overview][oldcam_overview]

As it is now, the CAM UI allows the user to do the following:

 - select resources to be analyzed
 - change some configuration settings
 - launch the process
 - monitor the results
 - add and remove annotations
 - read the log messages of the system 
 - read the RDF file that contains all the results of the analysis

This is a fairly basic overview of what it can be done but, as I undertake the challenge of improving the way the user can interact with the system, I'd rather understand the 10.000 feet view of the product than diving immediately deep into the details and the nuances of it. Such a first analysis gives the right vision of what needs to be focused on, and, most importantly, allows for a clearer conception of what the underlying servers are capable of producing or doing, in response to eventual user's requests.

However, the main focus of CAM was better defined during the course of the iterative process of sketching and validating the ideas with the team members: while it is mostly used as demo for potential clients at the moment, the idea is to migrate to a fully fledged app, targeting those human agents or indexers who are hourly paid to verify and review automatically assigned tags, bringing on the table their own expertise on a topic. For instance, a surgeon gets paid to delete wrong tags, add missing ones and review the general correctness of the analysis of all the tags related to surgery or body anatomy. The goal becomes then to help such a kind of users to do their job in as little time as possible; the challenge is to demonstrate to potential clients that, through the use of the tools this application provides, human indexers can analyze many more documents in a given time span, than they would by manually reading and annotating the text.

## Learning about competitors

During my first days I searched for competing text mining tools with the purpose of focusing on both the different features they present and the ways they present their results, in order to take inspiration in terms of visualization techniques. Such an activity led me to narrow down a list of very simplified features competitors^[http://www.butleranalytics.com/20-text-mining-and-text-analysis-tools/] implement:

 - Sentiment analysis on entities or keywords
 - Sentiment comparisons of a term over different data sources
 - Language recognition (e.g. 15% English 85% French)
 - Part of Speech tagging
 - NER
 - NED is rarely advertised
 - Relevant words occurrence
 - Topics/themes (ordered by pertinence)
 - Names translation
 - Categorization, often times starting from the bunch of documents only, without prior knowledge
 - Adult content detection
 - Documents similarity detection

On the visualization side, though, this exercise hasn't been enlightening: on one hand, existing tools often targets really specific markets where presentation details aren't taken too much in consideration, thus the teams working on these solutions focus primarily on functionalities and "smartness" of the software; on the other hand, data visualization is a highly data-dependent discipline, meaning it is ultimately based on what type of data one is willing to show and, most importantly, what kind of reasoning it is trying to support (e.g. - metrics comparison versus content distribution). For these reasons, I decided to go on framing the problem CAM is trying to solve for its users, then to attack eventual visualization challenges from a completely user-centered perspective, meaning my goal would be finding the least complex way to guide the user through the possibly big amount of data the system is capable of producing.

## Technical specs

As it becomes more clear what the scope of the project is, it is common practice to delimit the work to be done with a series of technical constraints. In my case, the specifications are pretty loose:

 - on the _front-end_, HTML, CSS and JavaScript are the technologies of choice; the running environment is supposed to include every major browser up to the last two versions (Mozilla Firefox, Google Chrome, Internet Explorer and Apple Safari), with a minimum supported resolution of 1024x768. No particular framework or technology is enforced. 
 - on the _back-end_, the existing code base is written in Java, so that is the language of choice. The system already relies on Shiro as authentication and security framework, and on JBoss as application server.
