# Chapter 6: the back-end
### Architecture, new features and the legacy problem

During my fifth month as intern, I worked on the back-end side of the project, my tasks being refactoring the existing code, developing new features and integrating it on the front-end.

Architecture

As I step in and take charge of the back-end of the web application for CAM, a valuable and rich codebase already exists. Let’s quickly review the architecture of the system, by listing its components.

![CAM Architecture][architecture]

On the front-end, the UI we discussed so far. On the back-end instead, there exist two separate and independent components:
the Annotation server, it’s the core engine of the whole CAM system. It’s capable of analysing, mining and augmenting the documents in input, and it outputs in RDF/XML format
the Web Server, which acts as mediator between the client and the Annotation server, has two primary roles: serving static and dynamic assets to the client, and fetching live analysis data from the Annotation server

Since a basic UI for CAM already existed in the past, a Web server is already set up and most of the work needed to parse the RDF results and build an Object representation of it in memory is already available, and therefore there’s no necessity to rebuild everything from scratch. The problem however is that the new client application is expecting certain input data, some of them totally new, with a given structure, in a JSON format, and so on. My job then is to refactor the existing data into a more suitable shape, develop and build new features and aggregations on top of the available ones, and integrate such a suite of services on the client, by means of a simple RESTful type of service.
I thus decided to create a mediator module, sitting between client and server, capable of managing the interactions between the two through an API, which exposes the minimal interface needed to make it work; by doing this, I decouple as much as possible both the UI and the already existing Web server, allowing future versions of either one of the other to be easily plugged in or replaced. In addition to this, my module abstracts the interactions and hides as much as possible the underlying processing jobs that take place on the web server, the goal of which is to support Mondeca’s decision to outsource CAM’s UI maintainance to another company in the future.

# Server-side
 - architecture schema:
     + cam server
     + cam ui backend
     + --> my module
     + cam ui frontend
 - module's structure
     + sessions
     + can I cookie if RESTful?
 - data refactoring 
 - performance fixes:  
     + client doesn't wait document to be indexed (it's async)
     + parallel processing of many documents at once
     + server-side session storage to cache results until needed
     + progress tracking 

Because the new CamAPI I introduce sits in between client and server, I had the possibility to rethink the way the two endpoint interact with each other. 

 - the importance of progress, proposals and solution

As I proceeded submitting my plan to the members of the team who used to work on CAM in the past, I immediately encountered some resistance in introducing the progress tracking; this was not because there is something wrong with the idea itself, but it turned out there's no actual way to get such information from the annotation server, which basically processes the whole document in a stateless manner. 

While this may seem a small detail in the entirety of the CAM application, there are some considerations to make on the user experience of it when no progress tracking is available. One of the most important phase of the interaction between a person and an object (being it a real or a virtual one) is the feedback the person is presented with, indeed, without some sort of hint that the interaction took place

By digging a little bit more into the problem, I found out that, while the annotation server does its job in a single run, the web server still needs to post-process the result in several ways, before storing the result. In such a multi-step way of proceeding I saw an opportunity to 

 - compromises: simplify the add tag

#### GIFs of interactions?

