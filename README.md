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
