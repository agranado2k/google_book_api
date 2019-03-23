[![Build Status](https://travis-ci.org/agranado2k/google_book_api.svg?branch=master)](https://travis-ci.org/agranado2k/google_book_api)
# Google Book API 


## Development draft

### Configuration

##### Step 1
- Create Docker image to ruby (alpine)
- Create Ruby project web without db and coffee script
- Install RSpec to Rails and create first dummy test
- Deploy in Heroku to docker container
- Configure secret key in Heroku env
- Configure Google Book Api key 
- Configure travisCI to CI/CD

##### Step 2
- Include and configure Rubocop
- Include gem audit
- Create README with badgets and first project description

### Pre-Development
- play with Google Books API
- get credentials
- configure credentials in Heroku environment
- configure credentials in Docker container to local environment

### Develpment
##### Features
- use [Google Books API](https://developers.google.com/books/docs/overview)
- Type in a query and display a list of books matching that query.
- Each item in the list should include the book's author, title, and publishing company, as well as a
picture of the book.
- From each list item, you should also be able to navigate to more information about the book,
but this information does not necessarily need to appear on a page within your application.
jIn other words, this could link out to an external site with more information about that particular book.

##### Request Call Example
https://www.googleapis.com/books/v1/volumes?q=sail&maxResults=10&startIndex=10&key={api_key}
use maxResults and startIndex to paginate
pay attention to q, it can have multiple term ==> sail+"atlantico sul"

##### Keep in mind
- We don't need database
- Include Google Analytics in the end
