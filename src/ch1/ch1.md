# Chapter 1: The context
### Introducing Mondeca, the product and my responsibilities

This report concerns my first month as intern at Mondeca, a French company located in Paris which sells software products capable of exploiting web semantics technologies. In particular, their main product is the so-called Smart Content Factory (SCF), a complex system that allows companies to index, annotate and browse through their documentation. Indeed, main targets of the product are those companies which need to handle huge amounts of documents (newspapers, legal offices, and so on).
Let's say that National Geographic (who, by the way, is among Mondeca's customers) wants an automatic way to handle all the scientific articles it publishes onto its website; this is what it will happen:
it can maintain an ontology with the system 
it may feed SCF with its documents and articles
SCF analyzes the documents via text mining tools and content annotation systems in order to recognize entities inside the text
the analysis outputs entities detected in the text, entities that have been inferred from the text (but that are not mentioned) and candidates that could be inserted in the ontology
a further rule-based classification is possible, meaning SCF will tag the documents according to some rules provided by the customer. For instance, SCF could tag as "Not for kids" the articles that are about crime, blood and sex.
finally, it is possible to browse the whole documentation by means of a semantic search engine 

What I will be working on is the so-called Content Annotation Manager (CAM), which is a component of the SCF system. It takes care of text mining a document, annotating it according to the selected ontology and yielding out the enriched document. 
As I enter the company, CAM is just a step of the process, it is automatically executed and it doesn't have an UI. Data flows in, data flows out. 
The only web UI that Mondeca has for CAM is a poorly presented testing environment ("demo") that they demonstrate to potential customers to show off the potential of their API (which ultimately exposes all the goodness the system produces).
Thus, my role inside Mondeca would be rethinking the current demo UI in order to provide an easy-to-use, sell-able and pretty web application that could serve the purpose of both convincing potential clients to trust the system and allowing them to actually monitor and intervene over this step of the pipeline.

Here’s how it looks like at the moment:

![Old CAM - Annotations][oldcam_annotations]
![Old CAM - Overview][oldcam_overview]

The CAM application 

As it is now, the CAM UI allows the user to do the following:
select files to be analyzed
change some configuration setting
launch the process
monitor the results
read the log messages of the system 
read the rdf file that contains all the results of the analysis

State of the art

During my first days I searched for competing text mining tools with the purpose of focusing on both the different features they present and the ways they present their results.   
I went through all those text mining technologies and solutions in order to extract common features and get an idea of how they do visualize their content.

Here's a list of what these tools can do:

Sentiment analysis on
entities
keywords / keyphrases
Sentiment comparisons of a term over different data sources
Language recognition (e.g. 15% english 85% french)
Part of Speech tagging
NER
NED is rarely advertised, Cogito is one of the few 
Relevant words occurrence
Topics/themes (ordered by pertinence)
Names translation
Categorization, often times starting from the bunch of documents only, without prior knowledge
Adult content detection
Documents similarity detection (probably out of scope)

Bonus features only a few have:

Multilanguage support for text mining tasks
Capability to look for documents answering a natural language query

On the visualization side, not many of those offered a demo; Although I found a couple which are decently presented:

Good visualization techniques & more similar application to CAM
http://www.basistech.com/text-analytics/rosette/
Good visualization can be seen in the video
http://www.clarabridge.com/product/

Iterating on sketches

After this analysis, I iterated through a series of sketches; this phase was of the uttermost importance since, by showing concrete drawings of what I thought it would have been great to show and to hide to the team members, I had the possibility to learn about the product itself. Every team member has something to add to the design phase, since everyone of them is expert in a particular side of CAM. Thus, iteration after iteration, I kept putting together all this knowledge refining my ideas.
At the end of the third week I had gone through 4 iterations already and I prepared a half an hour presentation of the sketches of the whole application to the development team leader and the product manager. 
As a result, ideas and corrections came out of the meeting, and we are now ready to write down a plan for the following steps. The next fundamental thing to do then was redacting the requirements document, so that the developers, the managers and me could agree on a list of feature to implement.
Here's what I produced:

# Requirements document

This document is meant to list and detail the sections that will compose the new CAM UI.

## Main purpose of the application

The purpose of the CAM web application is allowing the user to load one or more files and visualize the result of the analysis process. The user will need to see an high-level overview, and a detailed view of the analysis, one document at a time.
Priviledged users will be capable of browsing the log messages and the actual RDF file that came out of the pipeline.

## Sections

In order to properly group up the elements of the application, the following sections will be present:
File selection
Overview
Review
Troubleshooting
User profile

### File selection

This section allows the user to select which files she wants to send to the analysis process. 
A pool of files coming from different sources is created, shown under the form of a list.
Sources can be

Manually inserted text
Dropbox
Locally stored file (on the client's machine)
Remotely stored file (via URL)

The list of files presents, for every file, the following information:
name of the file
type of the file
workflow to be used
source of the file (e.g. - Dropbox)


The user can "check" files that she wants to
remove from the pool
associate with a workflow
run

The user can:
remove a file from the pool
check all
uncheck all
run all

While the process is running, the user can keep track of the progress. Both per file progress and global progress.
Whenever a file completes its "execution", it goes on the bottom of the list, while the remaining ones lift on top of it.

### Overview

This section looks and feels as a normal dashboard, and it aims at showing the following measures:
title of the document
workflow selected
number of words analyzed
number of tags generated
number of seconds needed to process that document
metadata of the document, them being
customer’s decision
as many as the customer likes
as different in type as needed
composition of the generated tags, broke down by quality, maening whether they have been
detected in the text
inferred
suggested as candidates
generated as rule-based tags
composition of the generated tags, broke down by taxonomy 
e.g. - 30% of tags come from taxonomyA 
       - 70% of tags come from taxonomyB
rule-based tags
shows the list, if under 5 tags
shows 5 tags and notifies that N more tags were added
main topic the document is about, exploiting a side-effect of a cluster-based scoring algorithm already in use
top 3 subtopcis with metric, if any
                e.g. "the document is also partly about HEALTH 20%, FINANCE 10% and ANIMALS 8%"

The UI has a tiled layout, meaning it is composed of rectangles, each one of those containing a measure or a piece of information. Composition-type measures are presented under the form of pie charts.

### Review

This section allows the user to browse through the entities that have been found or generated.
It is logically divided into two main parts:
filters
results

An additional feature is tag addition: the user can add a new tag (that was missed by the system or that’s missing in the taxonomy). This may happen in two ways:
by the add tag button
by selecting a word in the text and right clicking it

The process of adding the tag unfolds itself in the following steps:
type in the new tag
select its class from a intelligently filled list
suggest the class if it’s missing in the taxonomy

#### Review: Filters

Filters allow the user to narrow down the quantity of information that it is displayed in the results section.
Filters are:
score
class
quality, being it
detected
inferred
candidates
rule-based

Filters are meant to be collapsable into a side bar which disappears on the left-hand side of the screen.
The filters bar itself is structured in a way that it allows the different filters to be collapsed or expanded, in a tree-fashioned style.
This allows for further addition of filters.

#### Review: Results

The results are simply 2 different views of the same knowledge:
selected entities in a list
selected enetities in the text

The list of entities shows, for every entry, the following information:
name
taxonomy
occurrencies
score

Upon user's interaction on an entry of the list, further details are provided:
quality
entities from which it was inferred (if any)
sentences in which it appears
graph showing the entity in the taxonomy

The text view displays the document itself and, via highlighting or underlining, it allows the user to locate the selected entities in the text itself.
Morover, the text view is “searchable”: the user can look a term up and see it highlighted in the text.

### Troubleshooting 
         
This section targets priviledged users, who need to read through log messages and browse the whole RDF file which contains the result of the analysis.
It is therefore subdivided in two sections:
RDF
Log

#### Troubleshooting: RDF

The RDF file is split in Valid and Invalid RDF, by means of tabs.
Both valid and invalid rdf is further split into three chunks:
metadata RDF
knowledge RDF
occurrencies RDF
The user can decide which one she wants to read through buttons.

The RDF code is displayed in a searchable area: the user can search for a particular word, or tag, and go directly to that part of the code.
Tags in the code will allow collapsing and expanding actions, as in regular text editors.

#### Troubleshooting: Log

The log messages are displayed in a table containing the following fields:
module name
message type (INFO or ERROR)
referenced entity
message code
processing time
date
time of the day
presence of a stacktrace (YES or NO)

In case a stacktrace is present, clicking on "YES" will lead to a view showing:
relative message's details
stacktrace

By means of a button, the user can switch between the "table view" displaying all the messages and the "time view", which breaks down modules by time.
This allows the user to understand which parts of the pipeline took the most time, and which parts are the most efficient.

### User profile

This section is still to be defined.

My suggestions for it would be:
user's permissions
can the user access all the files?
can the user access all the workflows?
can the user access the troubleshooting section?
workflows to be then accessed in the file picking section
create, edit, delete workflows
change language
priviledge user can access the application settings
in the future, past sessions

The first mock-up

After all agreeing on the screens, I started to mock up in HTML a static version of the overview page, so that it can be seen how it looks like in the browser. Moreover, it allows the team leader and me to start thinking of the theming of the application, phase which usually gets skipped in the sketching process.
My first day of mocking up saw me transforming this sketch

![Sketch - Overview][sketch_overview]

into this HTML page

![Mockup - Overview][mockup_overview]
