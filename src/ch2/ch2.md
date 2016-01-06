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
I decided to go for Angular, a JavaScript framework targeting single page applications, after having considered Backbone and React, as they are the main players in the front-end frameworks game. While Backbone offers a much more lightweight JavaScript file and great extensibility and freedom in the choice of plugins, template engine, and so on, this comes at the cost of having to manually write a lot of code and browsing through sparse documentation (each plugin has its own). On the other hand React, the new kid in town, developed by the Facebook’s team and adopted by Instagram.com, is still in its earliest years, meaning there’s not that big of a community yet, plus it somehow reinvents the way web applications are developed nowadays, requiring a little bit of effort by people who come from the already-established way of doing things for the web.
So why Angular? There are a lot of reasons why the decision fell on this framework: first of all, it’s really quick to get going and easy to learn. My first concern in choosing the right environment, though, was going for solutions that will be easily maintained by the company when I’ll finish my stage; people at Mondeca in fact are prevalently trained in Java programming, and they have in fact always developed web UIs through the use of the Google Web Toolkit, which allows them to cross-compile Java code into Javascript and HTML/CSS. Thus, I should make it as straightforward as possible for them to go in and modify something when needed. Plus, a big factor was the availability for Mondeca of an outsourcing partner which already takes care of some of the web UI development for them, and which is a huge expert in Angular-based applications. Therefore, the company can rely on a trusted partner in the future in order to handle my project’s evolution.
However, Angular has a lot of bonus features that are great for CAM: first of all, it offers out-of-the-box two-ways data binding, which is the automatic synchronization of data between the model and view components. The way that Angular implements data-binding lets you treat the model as the single-source-of-truth in the application. The view is a projection of the model at all times. When the model changes, the view reflects the change, and vice versa. This is of course great in many scenarios, but especially for CAM, which is an application that, at its core, takes as input a series of tags, lets the user browse through it and delete some of the tags, then sends as output the outcome of the user’s interactions. In other words, the view needs to simply reflect what’s in the model at all times and each user’s decision can be simply reflected in the model by deleting (or adding) tags to the list. 
In addition to this, Angular relies on a declarative way of binding actions and data to HTML tags, which makes it great for fast and mock-up-centered iterations, where the design phase is limited and there’s the need for a semi-working mock-up as early as possible in order to let the Product and Sales Managers be involved in the process. In fact, since I work alone on the project, I primarily talk with these people, who are neither designers nor developers, so it’s really important that I allow them to focus on the functionality of the application, getting rid of static representations of what the final product will look like.
A final consideration on the drawbacks of using Angular needs to be made: it is a moderately heavy framework that could suffer from a performance perspective when thousands of bindings are present at the same time; this is not extremely important for the typical user that’s being targeted by CAM: indeed, the user is supposed to be on a laptop (no problems related to low-power mobile devices) and it will certainly be willing to wait for a small initial loading time.

## Automate to enhance productivity

It is common knowledge that, in software development, productivity isn't just related to the time one spends writing down code, rather to the speed tasks get done at. In order to improve such a metric, good developers spend some time making their working environment more ergonomic and smooth; it for this reason that I wish to include in the following some parts of my job that are not directly related to CAM, but that allowed me to reduce the burden of side tasks that affect each developer's everyday job. 

#### Front-end {-}

On the front-end side, I made heavy use of tooling and automation, as it is standard practice today. I relied on `gulp` as a task runner, rather than using `make`, for it exists a huge catalog of ready-to-use gulp tasks to enhance every single aspect of the developing activity. What this tool allows to do is basically running standalone JavaScript code (in other words, JS code that doesn't need a browser to be run) in a particular sequence through a command-line interface; moreover, thanks to __watching__ tasks, I was able to automatically run my sequence at every saved modifications to my source files. In particular, it was taking care of:

 -  concatenation, vendor-prefixing and minification of CSS files
 -  concatenation, uglification and linting of JS files
 -  minification and in-lining of HTML templates
 -  compression of images

More on these techniques in Chapter 5.

#### Back-end code and deployment {-}

On the back-end, I already had some Maven tasks to run that were coming from the existing project I inherited. So I simply made compilation and deployment on test server a single job, by creating a `Makefile`.
However, such an activity takes several seconds (up to 40s on my laptop), which can be a problem, especially when testing small changes, since long waits may interrupt the mental flow. I thus decided to divide deployment step into two parts, that don't need to go together all the time:

 - deployment of back-end code, which consists in copying the WAR file into the server
 - deployment of front-end code, which I could speed up by an incredible amount by simply treating the WAR archive as a simple RAR archive, and substituting modified files; this made front-end code's deployment as fast as half a second

#### Version control systems {-}

Finally, I set up a versioning system for both front-end and back-end. On the back-end, I kept using `svn` which is the system of choice at Mondeca, and allows developers to synchronize their project with the internal integration system (Jenkins). On the front-end, I decided to use a local `git` repository, in order to benefit of local branching and smarter changes history. 
