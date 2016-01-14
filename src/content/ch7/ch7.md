# Wrap up: i18n, future work and conclusions

In order to conclude the description of the CAM project, it is worth mentioning how the application is internationalized; in addition, since Mondeca believes in the future of such a product, some considerations on the future work that can be done to further improve the experience are included in this final chapter.

## i18n

A special effort required on my side has been internationalizing CAM in order to enable translation of the app at two different levels: the goal is to support multiple languages in both the UI's text and labels, and in the underlying data; for instance, a French document can be then reviewed with in English, meaning the labels for classes, entities and annotations will be displayed in the selected language.

### The UI level

On the UI, my approach consists in relying on a configuration file, more precisely a JSON structure, containing all the labels that are used in the interface; the configuration allows to plug in as many translations as needed, under the form of additional JSON structures. 
From a technical point of view, I created a _Translations_ module to set up all the supported languages; in addition, the _translate_ Angular's filter is used in order to enable dynamic change of language, via a simple pop-up window. What this means is that, at any point in time, the user can select another language and see the whole application translated in almost no time.
The benefits of the selected solution are the possibility for a non-technical member of the company to review, and easily change, the copywriting, or to an external translator to quickly add a new language by simply providing the key/value pairs (e.g. 'HELLO': 'Salut'), which can be very important when a company needs to move fast and to adapt their product to the customer's needs.

### The data level

As already mentioned, the underlying system can be tuned to analyze resources in different languages; in addition to this, the taxonomy can, and usually does, contain labels in different languages: the _House_ entity therefore will have a `label_en` _House_, a `label_fr` _Maison_ and a `label_de` _Haus_, depending on the configuration. By exploiting this information, the web application allows the user to change the language for the data, by choosing among the available ones advertised by the annotation server.
The implementation is pretty straightforward: the web server lists the available languages at bootstrap time, then sends every label in multiple languages in order to avoid having the client requesting the data twice, the UI displays data in the selected (or default) language. 
Therefore, I simply introduced a _i18n_ module, which handles default language, current language, corner cases such as _no language_ and provides a simple `extractName` method to be used by the views to extract the label in the correct language from the given entity or class or else. 

## Future work

I am certain that the results obtained during the course of this project are satisfactory and manage to reach most of the goals that were established in the planning phase; however, there is still plenty of room for further improvement. On the front-end side, extensive testing hasn't been put in place, due to timing constraints and lack of a proper testing strategy, and it is my strong belief that a sane and methodical approach would be great for every software project, especially for one of a medium size such as CAM (possibly undergoing frequent changes and bug fixes, according to customers needs). 

Along the same lines, user testing or other opinions collection mechanism would benefit greatly the overall user experience of the UI: indeed, one should not forget that most, if not all, of the design decisions have been taken basing on common sense, engineers' knowledge of the product and Sales and Product Managers' understanding of the customers needs and of the market's condition. While such an approach may be valuable, it is strongly encouraged to research the actual needs and typical uses of the application, when trying to build a solid UX for a product.

On the back-end side, where the magic happens, I suggest that the team considers three core new features, that will increase the effectiveness of CAM as a tool: first of all, the **tag auto-completion** when adding a new tag, a new feature which would consist in showing to the user a series of options of entities that already exist in the adopted taxonomy, whenever she is willing to create a new tag for a given document. This would solve the problem that currently presents itself, for instance, if one tries to add _Paris, City_, since the system would not know whether the user is thinking of _Paris, France_ or _Paris, Texas, USA_. This sort of disambiguation mechanism is usually delegated to the user herself, who needs to go and explore the different fields of the two _Paris_es, in order to figure out the right tag. My suggestion is to transfer such a reasoning onto the machine, by simply comparing attributes of the ambiguous options: in this way, the user could be shown a selection between _Paris, City (France, Europe)_ and _Paris, City (Texas, USA)_.

The second feature that I strongly suggest to take into consideration is the **cluster-based aboutness assessment** algorithm that has been mentioned in Chapter 3. Indeed, by means of small modifications to the original algorithm, which today is used to produce relevancy scores for the detected terms, one could easily extract a list of "clusters", that basically represents the most "relevant" topics or semantic areas that are observed in the analyzed resource. It would be require minor effort to make this work, but could provide a valuable extra to the CAM's dashboard.

Finally, as most of the people working on the project already acknowledge, a **persistence** mechanism is strongly recommended: meaning, there should be a way for the users to quit the application, log back in some time later, and resume what they were doing. Such a possibility would increase the app's value as a standalone tool by a great amount, since, on one hand, it will considerably improve the usability of the product, and on the other hand, it would open to new interesting capabilities, such as long-term statistics over the documents' analysis results. 

