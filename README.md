# Using Heroku

## Setup

[Getting Started with Rails 4](https://devcenter.heroku.com/articles/getting-started-with-rails4)

Create an account on heroku. This will send you an activation email. Activate your account.

	https://www.heroku.com

### Download and install Heroku Toolbelt
[Heroku Toolbelt](https://toolbelt.heroku.com/)  
This will install the 'heroku' command on your computer.  
	`heroku --help`

### Change Directory into your rails app  
	cd wdi_4_rails_demo_heroku

### Heroku Login
 	heroku login
 	
This will ask you to choose a public key to use for heroku. Choose one, _you should have one that used with github_.

### Create a heroku app for this rails project  
	heroku create  

This will create a _strangely_ named app. What's yours?

And it will add heroku as a remote git repository.  
	`git remote -v`  
	heroku  git@heroku.com:agile-badlands-7658.git (fetch)  
heroku  git@heroku.com:agile-badlands-7658.git (push)  
origin  git@github.com:tdyer/wdi_4_rails_hw_tdd_hacker_news.git (fetch)  
origin  git@github.com:tdyer/wdi_4_rails_hw_tdd_hacker_news.git (push)  

### Push you code up to Heroku
	git push heroku master  


__Lot's of output here!!__

- Compiles Ruby and Rails on the remote app "server"

- Runs bundle install
- Warning about old versions of ruby (safely ignored here)

- Asset pipleline setup (more on this later)

- Warning that you haven't explicitly identified the ruby version in
  the Gemfile. See referenced URL later. (No problem, keep going)

- Using the webrick server because there was no procfile found in the
  repo, (more later on this). Webrick is a very slow web server, do
  NOT use in production. (We'll fix this later)

### Run remote migrations and seed the DB on heroku

	heroku run rake db:migrate
	heroku run rake db:seed

### Restart the heroku app
	heroku restart
	
### Lets get some info about ALL heroku apps
	heroku apps:info

#### Lets get some info about a specific heroku app.
	heroku apps:info --app agile-badlands-7658
	
### Lets open the heroku app
	heroku apps:open --app agile-badlands-7658


__The above info and more is in [heroku_setup.txt](heroku_setup.txt)__

## Configuration and Info  
	heroku config -s

### Changing the configuration
	heroku config --help

### Show the logs 

-t option will 'tail', continuously show the log.  

	heroku logs -t

### Process running for your heroku application
	heroku ps

### Show all your releases.

Each time you deploy to heroku you are creating a "release". To see all the releases.  

	heroku releases  

#### Runnin bash on heroku
$ heroku run bash


## Ephemeral Filesystem.
Heroku provides a ephemeral filesystem. This is a serious limitation of heroku. If you save something, like an uploaded image file, it will disappear when your app is restarted or redeployed.

The typical workaround is to save files in cloud storage such as [Amazon S3](https://aws.amazon.com/s3/).

#### run bash on heroku
	heroku run bash  
	touch happy.txt; echo 'is happy' > happy.txt  
	cat happy.txt
	Ctrl-D to get out of heroku bash shell
### run bash again
	 ls -l
	 happy.txt is missing!!
	 
	 
## Postgres on Heroku

[Using the CLI](https://devcenter.heroku.com/articles/heroku-postgresql#using-the-cli)

Show the heroku plan, connections, pg version, data size, tables.  

   `heroku pg:info`

Start Get a psql command for heroku db  
	`heroku pg:psql`

For a specific DB, found by $ heroku config. 

	`heroku pg:psql HEROKU_POSTGRESQL_OLIVE_URL`

To get DB credentials
	`heroku pg:credentials HEROKU_POSTGRESQL_OLIVE_URL`