# Focusing on the user: from useful to usable

Even though the technology involved is powerful and capable of really interesting things, when designing a User Interface, the main goal should always be focusing on the user, finding in the realization of such design that sweet spot between extremely simple and usable and very effective and useful. Achieving the result is not always immediate and easy, and consists in a process of constantly putting the user at the center. In the following, it is explained how I reasoned about this in the most important page of the application, plus some considerations on how animations can improve the overall UX. 

## A UCD-based approach: the Review screen

There are a couple of aspects of the review screen that certainly demonstrate how designing for the user, or User Centered Design (UCD), is a great approach to make more usable products. In fact, some small additions and modification to the global behavior of CAM are entirely due to this way of working, like the “reset filters” button already mentioned, which enhances the user experience by reducing the number of clicks to switch from one filter to the other by a great deal, adopting a single color to highlight the terms in the text instead of using a color per class or category, which greatly improves the readability of the text, or providing affordances for the user to undo an action or rollback to a previous state, for example when she deletes some tags.

![Review screen, removing notification, with possibility to undo][review_screen_notification]

The greatest challenge I am facing designing the new version of CAM is being able of both improving the existing demo and suggest new features to be integrated in the application, so that it could be used as a stand-alone tool in the future. While doing this, I had the chance to modify some aspects of the user’s flow, revisiting the experience. A good example of this is the “add tag” action, which used to consist in the steps:

 - select Class
 - select Label among the ones corresponding to the selected class

This probably makes a lot of sense to a developer who also knows how the taxonomy works, but it doesn’t tell much to a human indexer who usually isn’t trained in those terms. What actually happens during the usage of this function is:

 - the user thinks of a tag she wants to add
 - the user tries to help taxonomists by indicating a class

I made the process more user friendly, by guiding through the tag addition with a wizard, giving also the possibility not to suggest any class, since one could not know what to do with the tag she is thinking of. Also, I got rid of the notion of “class” by using the “type” term, which can be less confusing for some users. In addition to this, I improved the way new tags get integrated in the UI, by adding a “manual entry” type, that can be reached through the filters. As a result, the user has a quick method to revisit what she added, and possibly change her mind.

At this point, the “review” screen was still lacking a couple of fundamental features: a way to submit the modifications and store them on the server, and the possibility to find a tag in the document and easily see its details in the table. A usability problem that I spotted in the old version of CAM was the complete lack of a system to undo just executed actions or rollback past decisions (in other words, to change one’s mind). For instance, when the user deletes a tag, it simply disappears from the application and there’s no way to restore it; or if she adds a couple, they get lost in the midst of the possibly very long list of tags. Finally, by hitting a “done” button, the user would cause an automatic process of storing the modifications, no way back. By analyzing such a situation, I immediately thought of an useful parallel with the shopping carts in e-shopping websites: when you go on Amazon.com, there is no way you can accidently end up buying something you didn’t want, nor it happens that you leave an item out of your order. This is mostly due to the last step of the purchasing process, represented by the shopping cart, which summarizes all the details, the items you are about to shop, prices, and so on; in addition, there’s some confirmation action required in order to proceed further with the order. 
The way I see CAM is greatly linked to this scenario: CAM’s users decide among a catalogue of tags which ones they want, which ones the would discard, and they can even “buy” some tags that are not present in the catalogue itself. Therefore, my suggestion is to add a simple “summary” step, in which the users are presented with a list of the modifications that are about to be permanently stored, with the option to roll back and change their minds.

![Review screen, summary][review_summary]

Another idea that came up aiming at supporting usability of the application is allowing a “right-to-left” interaction, meaning: instead of browsing the resources from left-to-right, starting from the filters, then reading the table, and finally finding the interesting tags in the document, the user might want to be able to quickly spot a tag in the document, and then easily find the tag in the table, without having to scroll a possibly very long list of those. 
The interaction to be realized is simple: clicking on the highlighted tag in the document should somehow cause a further filtering in the table on the left.

## User Experience: Animation as a tool

Contrary to what one may be tempted to believe, animation is not only a way to make things prettier in an interface, but rather it can be a powerful tool in the hands of a good designer: indeed, by making good use of motion techniques and by paying attention on not falling in the trap of cluttering the screen with too many moving elements, it is possible to greatly enhance the usability of a product. 
As humans, when we interact with some piece of software, we tend to assume that it will behave as real things do in the real word. The term behaviour is pretty powerful, but it helps conveying the message that we implicitly think of shapes and UI components as real things, and as such, we expect them to follow the same basic principles: 

 - objects accelerate and decelerate, rather than abruptly stopping when they have reached their destination
 - objects don’t enter in and exit from sight “teleporting” themselves into view

When this implicit pact is broken by a UI element, two things happen in one’s mind:
 
 - first, the user needs to realize that something happened; for instance, a dropdown menu changing from collapsed state to expanded state
 - then, the user’s brain needs to figure out what happened; in this example, it needs to reconstruct all the missing ‘frames’, in order to figure out the change of state

This process is really fast, but it has the negative effect of interrupting the user’s flow and, therefore, it affects the overall experience. 
Thus, keeping in mind these principles, I played with animations and implemented smooth state changes, with the goal of easing the user’s way through the application; indeed, since animated transitions can work as intermediaries between different UI states and can help orientate users, I focused on two major state changes in the “review” screen and studied how I could put all these notions together and help the user understanding not only the sequence of events, but also sorting out causes and effects. 
In the “review” screen, there is the main content, as usual, and some additional filters to act on in a sidebar. This bar isn’t always needed, so it makes sense to hide it behind a button and to show it only when the user really wants to interact with it; however, when visible, it doesn’t overlap the rest of the content, but rather it pushes it on the right, causing a big change in all the elements the user just got used to seeing. In presence of big state changes like this, it is important that the UI doesn’t surprise the user in a negative way, by moving things on the screen without her understanding where they went, or where they came from. I thus decided to animate the scene, so that the user can follow the motion of an element to understand how the before state of the page and the after state relate to each other.

![Review screen, sidebar animation][review_sidebar_animation]

Another abrupt change that I wanted to avoid is the elimination of a tag. When a tag is deleted from the table, it disappears and can be found, and possibly restored, by clicking on the bin icon on the upper-right corner of the application. This is a perfect example of how a simple animation can solve a big usability issue, since it takes a huge mental leap in order to understand that an entry in the table just got transferred to another place of the application, without having to remember where things go when they get deleted. Also, this problem shows how true it is that we always expect UI’s objects to behave as normal things in the real word: when you throw away something, it doesn’t materialize itself in the trash bin, then it shouldn’t be happening in the virtual world. So how can an animation solve this issue? Nothing too fancy, but a simple notification-style popup that slides in from the right in the upper-right corner of the screen, accomplishing two tasks at once: on one hand, it gives the user the possibility to undo the action, while on the other hand, it suggests, or reminds, where the tag has just gone to, by sliding up towards the bin icon when disappearing.

![Review screen, notification  animation][review_notification_animation]


