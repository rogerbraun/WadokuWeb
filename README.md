## WaDokuJT Web Version

### About

This is the web interface for the WaDokuJT dictionary (http://wadoku-ev.de). 

### License The data is under a creative commons license, the code is under GPL3.

### Installation

If you want to install your own version of this interface, you have to follow these steps:

1. Clone this repository.
2. Run "bundle install"
3. Setup the database with "rake db:setup". This will load the entries from the WaDokuJT file into the database. You may need to adjust /config/database.yml
4. Install a Picky server (http://florianhanke.com/picky/) that indexes the daid field of the WaDokuJT file. Point to it in config/initializers/picky.rb. This is needed for search, if you don't want this change the search behaviour in /app/controllers/search\_controller.rb. You can use the Picky server the wadoku.eu site uses (the one that is preconfigured), but the interface is not guaranteed to be stable, so don't use it for production use.
5. Start the server with "rails s"
6. Open the page in your browser. That's it!

#### Contribute
Contributions are very welcome. If you want to contribute, please fork the project and issue a pull request. Bonus points for specs. 

Some things you could work on: 

- The parser (found in /grammar). It does not yet parse every construct in the original file.
- Ajax support, preferably pjax (https://github.com/defunkt/jquery-pjax).
- DIN-Romanization (see Issue 1)
- Better page layout, nicer look.
- Integration with example sentences, from tatoeba.org or the Tanaka Corpus.

#### Contributors
This repository is maintained by Roger Braun (github.com/rogerbraun).

Other contributers:

- Jiayi Zheng (github.com/thebluber)
