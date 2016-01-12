# The back-end: architecture, new features and the legacy problem

During my fifth month as intern, I worked on the back-end side of the project, my tasks being refactoring the existing code, developing new features and integrating it on the front-end.

## Architecture

As I step in and take charge of the back-end of the web application for CAM, a valuable and rich code base already exists. Let’s quickly review the architecture of the system, by listing its components.

![CAM Architecture][architecture]

On the front-end, the UI we discussed so far. On the back-end instead, there exist two separate and independent components:

 - the _Annotation server_, it’s the core engine of the whole CAM system. It’s capable of analyzing, mining and augmenting the documents in input, and it outputs in RDF/XML format
 - the _Web Server_, which acts as mediator between the client and the Annotation server, has two primary roles: serving static and dynamic assets to the client, and fetching live analysis data from the Annotation server

Since a basic UI for CAM already existed in the past, a Web server is already set up and most of the work needed to parse the RDF results and build an Object representation of it in memory is already available, and therefore there’s no necessity to rebuild everything from scratch. The problem however is that the new client application is expecting certain input data - some of them totally new - with a given structure, in a JSON format, and so on. My job then is to re-factor the existing data into a more suitable shape, develop and build new features and aggregations on top of the available ones, and integrate such a suite of services on the client, by means of a simple RESTful type of service.
I thus decided to create a _mediator_ module, sitting between client and server, capable of managing the interactions between the two through an API, which exposes the minimal interface needed to make it work; by doing this, I decouple as much as possible both the UI and the already existing Web server, allowing future versions of either one of the other to be easily plugged in or replaced. In addition to this, my module abstracts the interactions and hides as much as possible the underlying processing jobs that take place on the web server, aiming to support Mondeca's decision to outsource CAM’s UI maintenance to another company in the future.

## Module's structure

The new module exposes the following services:

 - `getAnalyzeData`, which returns all data needed by the Analyze page
 - `getOverviewData`, `getReviewData` and `getTroubleshootingData`, which take a document and return the relative data
 - `indexDocument`, which takes a document and perform the right analysis, depending on the document's type (is it URL, free text, binary data, and so on)
 - `getProgress`, which returns the current progress of the analysis process
 - `publish`, which takes all user's modifications made to the analysis results, and stores them

This reduces by a big amount the total surface of the API, which used to be bigger and, therefore, much less maintainable and too tightly coupled to the client's implementation. On the other hand, by using less finely grained services there exist the risk of making it too difficult to split pages on the client in smaller pages. This is a trade-off between ergonomics and adaptability, however I prefer this approach since it allows new developers to easily get on board and start writing code from their first day on both the client and server, without having too much to learn about client-server interactions; in addition to this, offering few and "big" services encourage front-end programmers to fetch all the needed data in one single request at load time, which, as described in Chapter 5, can be a big win in terms of both perceived and computational performance. 
Even though the basic structure of the module might seem completely RESTful, there are a couple of exceptions:

 - the `login` service, which makes use of cookies to authenticate the user in the following requests; this isn't completely RESTless, since it doesn't make use of such cookies to store session data
 - the `getProgress` service, which, at every call, exposes some session-tied state the server is keeping (the progress of the analysis asked by the user)

## Data refactoring

As mentioned in the previous paragraphs, one of the main goals of the mediator module is to re-factor the result into a more suitable format, while enriching it by pre-computing useful aggregation such as totals, counts, and so on. In other words, starting from a list of tags, I moved the complexity on the server by preparing all the statistics needed in the Overview page, collecting the list the Dropbox files in the configured folder for the Analyze data (anticipating the eventual request), and so on. In addition to this, the module enriches the output of the analysis by flagging the annotations basing on their category (is a given tag an inference or has it been extracted from the text?). 
The whole process might seem a small addition to the global picture, however it is of the uttermost importance that the Web Server undertakes the task of preparing all the data the client might need, supporting as many activities, aggregations and flexibility as possible, and this stands true especially if one thinks of the API as an abstraction layer, enabling client applications that are insightful and performant.

## New features and legacy's improvement

Because the new _CamAPI_ I introduce sits in between client and server, I had the possibility to rethink the way the two endpoint interact with each other, focusing on improving both performance and user experience; even though the legacy code plays the biggest part of the back-end implementation, there are plenty of opportunities to enhance the existent. Therefore, I contributed with four new features: asynchronous indexation, parallelization, results caching and progress tracking.

#### Asynchronous indexation {-}

In the old CAM, while a document is being processed, the client waits for the process to be finished and gets the result back as soon as it completes in a synchronous fashion. There are two severe drawbacks of this approach: on one side, the client is forced to process one resource at a time, on the other side, the full result of the analysis needs to be transfered on the wire, which may be fairly big and caused in the past several problems for the too heavy payload. My solution for this issue is to break the interaction into smaller pieces and make the exchange of information between client and server asynchronous, as follows: 

 - client initiates indexation process of a document
 - server processes the result
 - client is free to ask for the result as soon as it needs it

Such an approach is not only more suitable for an user interface (which usually implies a lot of asynchronous operations), but opens up to new opportunities.

#### Parallelization {-}

The most important enhancement made possible by the asynchronism of the requests is the capability for the client to trigger more than one analysis at once, in a parallel fashion. In my new design, indeed, a "pool" of documents is created and it is then sent to the server for analysis. The advantage is evident: there is now a much higher throughput of processed documents.
From an implementation point of view, one could have done better than I did; in fact, in order to process more than one document at the same time, I simply open more than one connection to the server (the number of which is, in most browsers, limited to 6). The web server handles every incoming request with a separate thread, thus true parallelism is achieved.
However, a much smarter solution would have been sending the list of documents to the server (the so called _pool_), and have it creating threads; in this way, more than 6 documents could be processed at a time, and just a single network request should have been opened on the client. The reason why I didn't take this path is for it would have taken too much time for me to implement a thread pool on the server, and I was told not to spend too much energy on the back-end, since the company is mostly interested in an usable interface, rather than having me prioritizing parallel execution of more than 6 resources. In addition to this, when the pool contains a lot of documents, the whole system is blocked waiting for every resource - possibly big files - to be transferred to the server, therefore canceling the benefit of parallelism.

#### Results caching {-}

In order to enable the client to asynchronously request for the result of a given document's analysis, it is necessary to have a session-linked results cache on the server; this ultimately solves the problem of having a possibly too big payload to be served in a single connection, since the client can now specifically ask for the parts of the result it is interested in at that precise time: when the user is on the Overview page, there's no need to fetch the data that would only be used in the Review page, nor the log messages that can be accessed in the Troubleshooting section. Since in the desktop environment CAM targets the network is almost always the performance bottleneck, such a strategy has the more general benefit of increasing the overall responsiveness of the application.     

#### Progress tracking {-}

Finally, I introduce in CAM a progress bar showing the percentage of completion of every document (which makes sense now that parallel execution is present), plus a global progress indicator which relates to all the resources being processed.
As I proceeded submitting my plan to the members of the team who used to work on CAM in the past, I immediately encountered some resistance in introducing the progress tracking; this was not because there is something wrong with the idea itself, but it turned out there's no actual way to get such information from the annotation server, which basically processes the whole document in a stateless manner. 

While this may seem a small detail in the entirety of the CAM application, there are some considerations to make on the user experience of it when no progress tracking is available. One of the most important phase of the interaction between a person and an object (being it a real or a virtual one) is the __feedback__ the person is presented with, indeed, without some sort of hint that the interaction took place, we usually tend to be doubtful of the success of the operation: _did I click the button? did the system receive my command?_ While this is very true for every interaction, it is even more fundamental when talking long activities. In the old CAM there is no way to estimate the amount of time remaining, so the user can't take decisions upon that: _can I switch to some other task while I wait? should I skip that resource, and work on simpler ones for the moment? Am I to wait an hour or a minute?_ Thus, I started to investigate how this may be achieved, because I believe that a rough and imprecise indication is much better than no indication in this case. 

By digging a little bit more into the problem, I found out that, while the annotation server does its job in a single run, the web server still needs to post-process the result in several ways, before storing the result. In such a multi-step way of proceeding I saw an opportunity to achieve my goal: I identified 5 steps that measured a non-negligible amount of time to complete and used those as an indicator of how far in the processing of the document the system is. I am highly confident that, even though the 5 steps don't take the same time and they are really not much meaningful in terms of the actual activities they correspond to, it is still a big win to be able to present to the user of an estimation of how much work is done and how much is yet to be.
