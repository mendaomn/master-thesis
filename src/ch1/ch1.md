# The context

Introducing Mondeca, the product and my responsibilities

This report concerns the six months I spent as intern at Mondeca, a French company located in Paris which sells software products capable of exploiting semantic technologies. In particular, their main product is the so-called Smart Content Factory (SCF), a complex system that allows companies to index, annotate and browse through their documentation. Indeed, main targets of the product are those companies which need to handle huge amounts of documents (newspapers, legal offices, and so on).

Let's say that National Geographic (who, by the way, is among Mondeca's customers) wants an automatic way to handle all the scientific articles it publishes onto its website; this is what it will happen:

 - it can maintain an ontology with the system 
 - it may feed SCF with its documents and articles
 - SCF analyzes the documents via text mining tools and content annotation systems in order to recognize entities inside the text
 - the analysis outputs entities detected in the text, entities that have been inferred from the text (but that are not mentioned) and candidates that could be inserted in the ontology
 - a further rule-based classification is possible, meaning SCF will tag the documents according to some rules provided by the customer. For instance, SCF could tag as "Not for kids" the articles that are about crime, blood and sex
 - finally, it is possible to browse the whole documentation by means of a semantic search engine 

## The CAM application

What I will be working on is the so-called Content Annotation Manager (CAM), which is a component of the SCF system. It takes care of text mining a document, annotating it according to the selected ontology and yielding out the enriched document. 
As I enter the company, CAM is just a step of the process, it is automatically executed and it doesn't have an UI. Data flows in, data flows out. 
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

## State of the art

During my first days I searched for competing text mining tools with the purpose of focusing on both the different features they present and the ways they present their results, in order to take inspiration in terms of visualization techniques. Such an activity led me to narrow down a list of very simplified features competitors implement:

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

## Framing the problem: iterating on sketches

In order to get a deeper knowledge of the current state of the application, and to start forming an idea of the desired state of the next version of it, I iterated through a series of sketches; this phase is of the uttermost importance since, by showing concrete drawings of what I think it would be great to show and to hide to the team members, I have the possibility to learn about the product itself. Every team member has something to add to the design phase, since everyone of them is expert in a particular side of CAM (current UI, back-end architecture, system's capabilities, gotchas, and so on). Thus, iteration after iteration, I kept putting together all this knowledge and refining my ideas, until a complete picture of where CAM is now and where it's going next was ready. The next fundamental thing to do then is discussing my ideas with both the Product Manager and the Development Team Leader, in order to collect their feedback and finally redacting a draft of the requirements document, so that the developers, the managers and me could agree on a list of feature to implement. This isn't by any means trying to be a finalized and frozen document, but at the contrary it acts as a reference people can refer to while pushing the product forward.  
The result of such a cyclic process, can be trusted here as a way to better define the main purpose of the application and its core sections; let's quickly go through it, keeping in mind that not all the listed features made it to the final realization of the application (especially in the troubleshooting and user sections, which got moved out of scope during the course of the project). 

### Main purpose of the application

The purpose of the CAM web application is allowing the user to load one or more resources and visualize the result of the analysis process. The user will need to see an high-level overview, and a detailed view of the analysis, one document at a time. 
In addition to this, privileged users will be capable of browsing the log messages and the actual RDF file that comes out of the processing pipeline.

### Core sections

In order to properly group up the elements of the application, the following sections will be present:

 - File selection
 - Overview
 - Review
 - Troubleshooting
 - User profile

#### File selection {-}

This section allows the user to select which files she wants to send to the analysis process. A pool of files coming from different sources is created, shown under the form of a list.

Such sources can be

 - Manually inserted text
 - Dropbox
 - Locally stored file (on the client's machine)
 - Remotely stored file (via URL)

The list of files presents, for every file, the following information:

 - name of the file
 - type of the file
 - workflow to be used
 - source of the file (e.g. - Dropbox)

The user can "check" files that she wants to

 - remove from the pool
 - associate with a workflow
 - run

The user can:

 - remove a file from the pool
 - check all
 - uncheck all
 - run all

While the process is running, the user can keep track of the progress. Both per file progress and global progress.

#### Overview {-}

This section looks and feels as a normal dashboard, and it aims at showing the following measures:

 - title of the document
 - workflow selected
 - number of words analyzed
 - number of tags generated
 - number of seconds needed to process that document
 - metadata of the document, them being
     - customer’s decision
     - as many as the customer likes
     - as different in type as needed
 - composition of the generated tags, broke down by quality, meaning whether they have been
     - detected in the text
     - inferred
     - suggested as candidates
     - generated as rule-based tags
 - composition of the generated tags, broke down by taxonomy 
 - rule-based tags
 - main topic the document is about, exploiting a side-effect of a cluster-based scoring algorithm already in use
 - top 3 subtopics with metric, if any (e.g. "the document is also partly about HEALTH 20%, FINANCE 10% and ANIMALS 8%")

The UI has a tiled layout, meaning it is composed of rectangles, each one of those containing a measure or a piece of information. Composition-type measures are presented under the form of pie charts.

#### Review {-}

This section allows the user to browse through the entities that have been found or generated. 
It is logically divided into two main parts: filters and results. In addition to these two, another feature is new tags addition: the user can add a new tag (that was missed by the system or that’s missing in the taxonomy). 
This may happen in two ways:
 
 - by the add tag button
 - by selecting a word in the text and right clicking it

The process of adding the tag unfolds itself in the following steps:
 
 - type in the new tag
 - select its class from a intelligently filled list
 - suggest the class if it’s missing in the taxonomy

##### Review: Filters {-}

Filters allow the user to narrow down the quantity of information that it is displayed in the results section.
Filters are:

 - score
 - class
 - quality, being it
     - detected
     - inferred
     - candidates
     - rule-based

Filters are meant to be collapsible into a side bar which disappears on the left-hand side of the screen.
The filters bar itself is structured in a way that it allows the different filters to be collapsed or expanded, in a tree-fashioned style.
This allows for further addition of filters.

##### Review: Results {-}

The results are simply 2 different views of the same knowledge:

 - selected entities in a list
 - selected enetities in the text

The list of entities shows, for every entry, the following information:

 - name
 - taxonomy
 - occurrencies
 - score

The text view displays the document itself and, via highlighting or underlining, it allows the user to locate the selected entities in the text itself.

#### Troubleshooting  {-}

This section targets privileged users, who need to read through log messages and browse the whole RDF file which contains the result of the analysis.
It is therefore subdivided in two sections:

 - RDF
 - Log

##### Troubleshooting: RDF {-}

The RDF file is split in Valid and Invalid RDF, by means of tabs.
Both valid and invalid RDF is further split into three chunks:

 - metadata RDF
 - knowledge RDF
 - occurrencies RDF

The user can decide which one she wants to read through buttons.

The RDF code is displayed in a searchable area: the user can search for a particular word, or tag, and go directly to that part of the code.
Tags in the code will allow collapsing and expanding actions, as in regular text editors.

##### Troubleshooting: Log {-}

The log messages are displayed in a table containing the following fields:

 - module name
 - message type (INFO or ERROR)
 - referenced entity
 - message code
 - processing time
 - date
 - time of the day
 - resence of a stacktrace (YES or NO)

In case a stacktrace is present, clicking on "YES" will lead to a view showing:

 - relative message's details
 - stacktrace

By means of a button, the user can switch between the "table view" displaying all the messages and the "time view", which breaks down modules by time.
This allows the user to understand which parts of the pipeline took the most time, and which parts are the most efficient.

#### User profile {-}

This section is still to be defined.

My suggestions for it would be:

 - user's permissions
     - can the user access all the files?
     - can the user access all the workflows?
     - can the user access the troubleshooting section?
 - create, edit, delete workflows
 - change language
 - in the future, past sessions

## The first mock-up

After all agreeing on the screens, I started to mock up in HTML a static version of the overview page, so that it can be seen how it looks like in the browser. Moreover, it allows the Team Leader and me to start thinking of the theming of the application, phase which usually gets skipped in the sketching process.
My first day of mocking up saw me transforming this sketch

![Sketch, Overview][sketch_overview]

into this HTML page

![Mockup, Overview][mockup_overview]
