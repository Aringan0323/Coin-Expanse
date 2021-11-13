# Coin Expanse

Coin Expanse is an effort to consolidate cryptocurrency trading into a simple and modular GUI that allows users to customize their own widgets to view crypto metrics as well as give them a means to upload custom algorithmic implementations. Currently, the project includes:

1. User profile creation and login (authentication)
2. Home page that includes formatted news cards for 6 random news articles from 20 articles seeded from the last 3 days of crypto news
3. A page with supported cryptocurrencies, which includes links to individual coin pages
4. An about page with convenient highlighting on search
5. A navigation bar, which includes a search bar with custom implementation for each page and logout button
6. Inability to access any page except login/register when not logged in, inability to access login/register when logged in but access to any other page

## Important Setup Notes

Please run the following steps to get this project set up locally (*Note*: **Please** make sure `PostgresQL` is running locally in order to start the development process):

```terminal
~$ bundle install
~$ rails db:drop
~$ rails db:create
~$ rails db:migrate
~$ rails db:seed
~$ rails webpacker:install
```

Note that we recommend dropping and re-creating the database. This is not necessary, except in the case that a schema has been updated. If you are running a local instance on schemas that have not been updated, the `rails db:drop` step can be skipped.

Then, you can start the server by running

```terminal
~$ rails server
```

This will start the server on `localhost:3000`. The port number can be changed by adding `-p xxxx`, where `xxxx` is some other port number (does not have to be 4 digits).

### If MDBootstrap is not working

- Go to `./app/javascript/packs/application.js` and comment any lines that throw errors in the browser console.
- Reload the page to recompile webpacker.
- Uncomment the lines that you commented out previously and reload the page once more.

## Models

A Rails model is a Ruby class which relates to a specific schema in the database. Say you create a person schema with two fields - name:string age:integer. A Model will be created relating to this item in the database which will enable the user to add database records, delete records, or update existing records.

key models:

*coin.rb* - the model for each binance coin, which contains the coins symbol, binance symbol, name
*day_summary.rb* - the model which belongs to each coin in the database, contains various numerical data about each coin, such as the ask price, price change, and previous closing price
*user.rb* - the model for the user, which contains the users username, password, binance api key, email, and date of enrollment.
*news_article.rb* - The model for the news articles that appear on the newsfeed of our main page. It contains the title, name, description, url, image_url, and date of posting of the article.
*portfolio* - belongs to each user, contains the total numerical value of all the coins owned by the user.

## Views

A Rails view is an embedded ruby file which contains ruby as well as html and css and is used to display information to the user in the internet browser. Code inside of these brackets: <%= 'xyz' %> will get executed and rendered out to the browser, and code inside brackets like this: <% 'xyz' %> will only get executed and not rendered to the browser.

**views/home/index.html.erb** - the home view page the user sees after logging in
**views/about/index.html.erb** - the about page with a description about the website
**views/coin/index.html.erb** - the page that displays the supported coins and current market data about them
**views/sessions/login.html.erb** - the page that first gets displayed, asking the user to login
**views/user/new.html.erb** - the page that enables you to create an account

## Planned Views

These views will be introduced to the functionality of our app in the near future/ 

**views/strategy/new.html.erb** - the page which will allow a user to create a new trading strategy
**views/strategy/show.html.erb**  - the page which will show all the users planned strategies
**views/strategy/portfolio.html.erb** - the page will show the user the coins that they own and their numerical values


[See paper prototype for a detailed look into the final project goal](paper_prototype.pdf)

## Dependencies 

The dependencies listed below consist of a mix of gems and apis we use to help create the functionality and setup of our web application.

*Binance API* **(https://github.com/binance/binance-spot-api-docs/blob/master/rest-api.md)** - an official REST API provided by the crypto trading platform Binance. This is where we send our get requests to query for data, as well as make post requests for transactions.
*News api* **https://newsapi.org/** - the api we use to make get requests for up to date crypto news and market changes.
*gem 'net'* **https://github.com/ruby/net-http** - gem used to build http user agents.
*gem 'uri'* **https://github.com/ruby/uri** - URI is a module providing classes to handle Uniform Resource Identifiers.
*gem "binance-ruby"* **https://github.com/Jakenberg/binance-ruby** - "(not yet used) api wrapper for binance queries".
*gem 'json'* **https://github.com/flori/json** - provides an API for parsing JSON from text as well as generating JSON text from arbitrary Ruby objects.
*gem 'seedbank'* **https://github.com/james2m/seedbank** - used to organise the seed files into a folder.
*gem 'digest'* **https://github.com/ruby/digest** - "performs the encryption of user passwords stored in the database".
*gem "chartkick"* **https://github.com/ankane/chartkick** - gem used for organising market data into tables and graphs. 

## Database Schema

The description of how the objects are stored in our database.

User --> has one portfolio -->> has many coins -->> (has_many :day_summaries and has_many :book_tickers)
