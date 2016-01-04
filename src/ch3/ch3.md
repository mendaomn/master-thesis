# Chapter 3: the core screens
### Overview and review

During my third month as intern I worked on another screen of the application and further improved the existing ones by working on both functionalities and performance. 

Screens: Review
The “review” screen was still lacking a couple of fundamental features: a way to submit the modifications and store them on the server, and the possibility to find a tag in the document and easily see its details in the table. A usability problem that I spotted in the old version of CAM was the complete lack of a system to undo just executed actions or rollback past decisions (in other words, to change one’s mind). For instance, when the user deletes a tag, it simply disappears from the application and there’s no way to restore it; or if she adds a couple, they get lost in the midst of the possibly very long list of tags. Finally, by hitting a “done” button, the user would cause an automatic process of storing the modifications, no way back. By analyzing such a situation, I immediately thought of an useful parallel with the shopping carts in e-shopping websites: when you go on Amazon.com, there is no way you can accidently end up buying something you didn’t want, nor it happens that you leave an item out of your order. This is mostly due to the last step of the purchasing process, represented by the shopping cart, which summarizes all the details, the items you are about to shop, prices, and so on; in addition, there’s some confirmation action required in order to proceed further with the order. 
The way I see CAM is greatly linked to this scenario: CAM’s users decide among a catalogue of tags which ones they want, which ones the would discard, and they can even “buy” some tags that are not present in the catalogue itself. Therefore, my suggestion is to add a simple “summary” step, in which the users are presented with a list of the modifications that are about to be permanently stored, with the option to roll back and change their minds.

![Review screen, summary][review_summary]

Another idea that came up aiming at supporting usability of the application is allowing a “right-to-left” interaction, meaning: instead of browsing the resources from left-to-right, starting from the filters, then reading the table, and finally finding the interesting tags in the document, the user might want to be able to quickly spot a tag in the document, and then easily find the tag in the table, without having to scroll a possibly very long list of those. 
The interaction to be realized is simple: clicking on the highlighted tag in the document should somehow cause a further filtering in the table on the left.

Screens: Analyze
Introducing the “analyze” screen (in lack of a better name). This screen is probably going to be the first one that the users are going to interact with: indeed, it contains the core controls which enable them to choose the resources to submit to the analysis process, see the progress of said analysis and then dive into the results for the selected resource. Moreover, here one can change some of the workflow’s parameters: remove some taxonomies from the list of the ones that will be used, disable the classifier or specify which rules should it take into account during its classification process (which is, indeed, rule-based).
In order to design a solution for all of these tasks, I decided to split the needs the user might have in two sections: on one hand there is the resource selection, which should include buttons to add files/resources, a list of the selected ones, a way to change the parameters, and so on; on the other hand, there is the process monitoring, which should provide visual feedback for the user, such as an indication of how long the process will take, which resources have already been processed, and so on. 
After having done this, I tackled the design challenges and, through a sequence of iterations, I came up with a solution composed by the following elements:

A sidebar, on the left-hand side of the page, visually representing the process monitoring section; it includes, from top to bottom:
a button to perform the most important action - running the analysis on all the selected resources
an overview of the work already done and yet to be
the global progress (e.g. - 40% completed)
some statistics on the results of the review of the documents performed by the user itself (e.g. removed tags)
The choice of having a sidebar comes from two considerations: first, it is consistent with the general design of the application, which presents a sidebar in almost every section, and secondly, it makes perfect sense to logically separate the “action”, displaced in the main area of the page, from the “details”.
From a design point of view, grouping is the technique I relied upon the most in order to visually represent the relationship existing among the various pieces of data. In fact, by doing this, it becomes obvious that what’s going to appear and change on the left, is just an addition, or an extra if you will, to what occupies the main portion of the screen, which instead is the most important thing to pay attention to.

![Analyze screen, global glance][analyze_screen]

The main content, visually representing the resource selection section. Here, the most prominent element is the list of selected documents to be indexed; indeed, I decided to represent each resource with a single, well-defined, block, rather than with a simple entry in a table or list. 

This is meant to be a visual signal that every single one of those reveals a big process, involving the content augmentation job performed by the underlying system, the tags review and modification by the human agent, while requiring special attention in the configuration and parameters selection, since every workflow (as it is called in CAM) relates to a specific type of content, to some types of file (if the document is contained in a file, as it often happens with CAM), and it has been configured by carefully choosing the plugins to be activated during the analysis (which, for instance, affect the way relevancy scores are computed). Therefore, every document is spaced-out from the others, has its own status indicator (not processed, ready, reviewed) and its own configuration. 

In this section of the application, there is a lot going on. Thus, my approach consists in hiding as much complexity as possible by providing a single point of contact between client and server. Indeed, the main object the user interacts with is a “pool” of documents to be sent to the server; she can populate such a pool in different ways: adding files from a pre-configured Dropbox folder or the local hard drive, by pointing to web resources through URLs, or even by manually entering text (this functionality hasn’t been developed yet, but it will be). There are many things the user can do, a part from populating the pool, such as setting different workflows to different documents, running or re-running only some of the resources, filtering the list, changing the parameters characterizing the workflows themselves (e.g. which taxonomies to use), and so on, but, by putting the list of “to-dos” that will be sent to server at the center, not only the user doesn’t get overwhelmed by the variety of options and nuances, but - most importantly - she is always under control.

User Experience: Animation as a tool
Contrary to what one may be tempted to believe, animation is not only a way to make things prettier in an interface, but rather it can be a powerful tool in the hands of a good designer: indeed, by making good use of motion techniques and by paying attention on not falling in the trap of cluttering the screen with too many moving elements, it is possible to greatly enhance the usability of a product. 
As humans, when we interact with some piece of software, we tend to assume that it will behave as real things do in the real word. The term behaviour is pretty powerful, but it helps conveying the message that we implicitly think of shapes and UI components as real things, and as such, we expect them to follow the same basic principles: 
objects accelerate and decelerate, rather than abruptly stopping when they have reached their destination
objects don’t enter in and exit from sight “teleporting” themselves into view

When this implicit pact is broken by a UI element, two things happen in one’s mind:
first, the user needs to realize that something happened; for instance, a dropdown menu changing from collapsed state to expanded state
then, the user’s brain needs to figure out what happened; in this example, it needs to reconstruct all the missing ‘frames’, in order to figure out the change of state
This process is really fast, but it has the negative effect of interrupting the user’s flow and, therefore, it affects the overall experience. 
Thus, keeping in mind these principles, I played with animations and implemented smooth state changes, with the goal of easing the user’s way through the application; indeed, since animated transitions can work as intermediaries between different UI states and can help orientate users, I focused on two major state changes in the “review” screen and studied how I could put all these notions together and help the user understanding not only the sequence of events, but also sorting out causes and effects. 
In the “review” screen, there is the main content, as usual, and some additional filters to act on in a sidebar. This bar isn’t always needed, so it makes sense to hide it behind a button and to show it only when the user really wants to interact with it; however, when visible, it doesn’t overlap the rest of the content, but rather it pushes it on the right, causing a big change in all the elements the user just got used to seeing. In presence of big state changes like this, it is important that the UI doesn’t surprise the user in a negative way, by moving things on the screen without her understanding where they went, or where they came from. I thus decided to animate the scene, so that the user can follow the motion of an element to understand how the before state of the page and the after state relate to each other.

![Review screen, sidebar animation][review_sidebar_animation]

Another abrupt change that I wanted to avoid is the elimination of a tag. When a tag is deleted from the table, it disappears and can be found, and possibly restored, by clicking on the bin icon on the upper-right corner of the application. This is a perfect example of how a simple animation can solve a big usability issue, since it takes a huge mental leap in order to understand that an entry in the table just got transferred to another place of the application, without having to remember where things go when they get deleted. Also, this problem shows how true it is that we always expect UI’s objects to behave as normal things in the real word: when you throw away something, it doesn’t materialize itself in the trash bin, then it shouldn’t be happening in the virtual world. So how can an animation solve this issue? Nothing too fancy, but a simple notification-style popup that slides in from the right in the upper-right corner of the screen, accomplishing two tasks at once: on one hand, it gives the user the possibility to undo the action, while on the other hand, it suggests, or reminds, where the tag has just gone to, by sliding up towards the bin icon when disappearing.

![Review screen, notification  animation][review_notification_animation]

