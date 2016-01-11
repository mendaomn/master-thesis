# Wrap up

i18n, future work and conclusions

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

## Conclusions