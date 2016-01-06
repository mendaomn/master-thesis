# The process

Technologies, specs and sketches

In my second month as intern, I went on implementing the initial sketches that served mainly the purpose of better explaining the ideas I had for the new version of the CAM application.

## Setting up the project

As it was decided to proceed developing the first two screens, a better definition of the process to be followed had to be stated. Since I was working alone on this project, it was decided to slightly change the way we iterate over the screens, in order to allow me to move both more quickly and more freely. First of all, after having roughly sketched the global flow of the application, I should focus on one screen at a time, completing and validating as many features as possible, before skipping to the next section. In addition to this, since no other developer is involved, we decided to reduce the sketching phase, with the goal of producing semi-working mock ups which are easier to discuss over for non-technical people. 
I then adopted the following process:

 - mock up in the browser a rough representation of a screen
 - meet together with the Product Manager and the Sales Manager in order to define features and content
 - iterate until the screen is finished
 - skip to the next screen

## Choosing the framework

The first thing to do at this point, was deciding which framework to adopt so that the development of the functionalities, that enable the application to offer an interactive experience to the user, will be as fast and productive as possible. Naturally, an MVC pattern (or similar) needed to be adopted, as really often happens in web applications and UI development. 
I decided to go for Angular, a JavaScript framework targeting single page applications, after having considered Backbone and React, as they are the main players in the front-end frameworks game. While Backbone offers a much more lightweight JavaScript file and great extensibility and freedom in the choice of plugins, template engine, and so on, this comes at the cost of having to manually write a lot of code and browsing through sparse documentation (each plugin has its own). On the other hand React, the new kid in town, developed by the Facebook’s team and adopted by Instagram.com, is still in its earliest years, meaning there is not that big of a community yet, plus it somehow reinvents the way web applications are developed nowadays, requiring a little bit of effort by people who come from the already-established way of doing things for the web.
So why Angular? There are a lot of reasons why the decision fell on this framework: first of all, it is really quick to get going and easy to learn. My first concern in choosing the right environment, though, was going for solutions that will be easily maintained by the company when I will finish my stage; people at Mondeca in fact are prevalently trained in Java programming, and they have in fact always developed web UIs through the use of the Google Web Toolkit, which allows them to cross-compile Java code into JavaScript and HTML/CSS. Thus, I should make it as straightforward as possible for them to go in and modify something when needed. Plus, a big factor was the availability for Mondeca of an outsourcing partner which already takes care of some of the web UI development for them, and which is a huge expert in Angular-based applications. Therefore, the company can rely on a trusted partner in the future in order to handle my project’s evolution.
However, Angular has a lot of bonus features that are great for CAM: first of all, it offers out-of-the-box two-ways data binding, which is the automatic synchronization of data between the model and view components. The way that Angular implements data-binding lets you treat the model as the single-source-of-truth in the application. The view is a projection of the model at all times. When the model changes, the view reflects the change, and vice versa. This is of course great in many scenarios, but especially for CAM, which is an application that, at its core, takes as input a series of tags, lets the user browse through it and delete some of the tags, then sends as output the outcome of the user’s interactions. In other words, the view needs to simply reflect what’s in the model at all times and each user’s decision can be simply reflected in the model by deleting (or adding) tags to the list. 
In addition to this, Angular relies on a declarative way of binding actions and data to HTML tags, which makes it great for fast and mock-up-centered iterations, where the design phase is limited and there’s the need for a semi-working mock-up as early as possible in order to let the Product and Sales Managers be involved in the process. In fact, since I work alone on the project, I primarily talk with these people, who are neither designers nor developers, so it’s really important that I allow them to focus on the functionality of the application, getting rid of static representations of what the final product will look like.
A final consideration on the drawbacks of using Angular needs to be made: it is a moderately heavy framework that could suffer from a performance perspective when thousands of bindings are present at the same time; this is not extremely important for the typical user that’s being targeted by CAM: indeed, the user is supposed to be on a laptop (no problems related to low-power mobile devices) and it will certainly be willing to wait for a small initial loading time.

## Automate to enhance productivity

It is common knowledge that, in software development, productivity isn't just related to the time one spends writing down code, rather to the speed tasks get done at. In order to improve such a metric, good developers spend some time making their working environment more ergonomic and smooth; it for this reason that I wish to include in the following some parts of my job that are not directly related to CAM, but that allowed me to reduce the burden of side tasks that affect each developer's everyday job. 

#### Front-end {-}

On the front-end side, I made heavy use of tooling and automation, as it is standard practice today. I relied on `gulp` as a task runner, rather than using `make`, for it exists a huge catalog of ready-to-use gulp tasks to enhance every single aspect of the developing activity. What this tool allows to do is basically running standalone JavaScript code (in other words, JS code that doesn't need a browser to be run) in a particular sequence through a command-line interface; moreover, thanks to _watch tasks_, I was able to automatically run my sequence at every saved modifications to my source files. In particular, it was taking care of:

 -  concatenation, vendor-prefixing and minification of CSS files
 -  concatenation, uglification and linting of JS files
 -  minification and in-lining of HTML templates
 -  compression of images

More on these techniques in Chapter 5.
In addition to tasks automation, another area in which tools can improve programmers' life is dependency management; I used `bower` to manage JavaScript and CSS libraries, and `npm` to manage NodeJS modules, like `gulp`'s tasks and external tools. It is especially useful to rely on such tools when cooperating with other people, since they can easily set all the tooling up and fetch all dependencies by simply downloading the source and running the install scripts: `npm install && bower install`.  

#### Back-end code and deployment {-}

On the back-end, I already had some Maven tasks to run that were coming from the existing project I inherited. So I simply made compilation and deployment on test server a single job, by creating a `Makefile`.
However, such an activity takes several seconds (up to 40s on my laptop), which can be a problem, especially when testing small changes, since long waits may interrupt the mental flow. I thus decided to divide deployment step into two parts, that don't need to go together all the time:

 - deployment of back-end code, which consists in copying the WAR file into the server
 - deployment of front-end code, which I could speed up by an incredible amount by simply treating the WAR archive as a simple RAR archive, and substituting modified files; this made front-end code's deployment as fast as half a second

#### Version control systems {-}

Finally, I set up a versioning system for both front-end and back-end. On the back-end, I kept using `svn` which is the system of choice at Mondeca, and allows developers to synchronize their project with the internal integration system (Jenkins). On the front-end, I decided to use a local `git` repository, in order to benefit of local branching and smarter changes history. 

## Framing the problem: specs

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
 - selected entities in the text

The list of entities shows, for every entry, the following information:

 - name
 - taxonomy
 - occurrences
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
 - occurrences RDF

The user can decide which one she wants to read through buttons.

The RDF code is displayed in a researchable area: the user can search for a particular word, or tag, and go directly to that part of the code.
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
 - presence of a stacktrace (YES or NO)

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

After agreeing on the screens, I started to mock up in HTML a static version of the overview page, so that it can be seen how it looks like in the browser. Moreover, it allows the Team Leader and me to start thinking of the theming of the application, phase which usually gets skipped in the sketching process.
My first day of mocking up saw me transforming this sketch

![Sketch, Overview][sketch_overview]

into this HTML page

![Mockup, Overview][mockup_overview]
