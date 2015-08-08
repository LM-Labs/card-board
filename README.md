## card-board

'Card Board' is an image based message board. It is currently live at phxtech.us. The topics (or 'cards') are listed from most recently updated, to least recently updated in two columns. 'Open' can be pressed on individual cards to view their content and their replies. Users can make new cards, or reply to existing ones, only after they sign up and verify their email.

## Navigating these directories

Client contains the files of the application. 
* index.coffee contains the main page, as well as the router to the other views of the image board. 
* cardsView.coffee is the page element presenting the topics as columns
* cardTemplate.coffee is the presentation of a single topic as it appears in cardsView.coffee
* confirm.coffee is a splash page the user is directed to after they register an account
* functionsOfConvenience.coffee is a module containing many functions that are useful in other areas. These functions do things like, format numbers and arrange text.
* login.coffee is the login page. It is also where a user can register an account.
* makeCard.coffee is the page view for making a new topic.
* specificCard.coffee is the page view for one specific topic. 

The other views include making another topic, viewing a specific topic, loging in, and a splash page after you register an account.

gulpfile.coffee transpiles the coffeescript, jade, and stylus files of client, and combines the coffeescript into one file. gulpfile.coffee outputs to the directory 'public'. The content of public is page-loadable. The files in the root directory are copies of the files from public.  Most of the other files in the root directory are web assets. server.coffee was used during production to locally host the application. 

