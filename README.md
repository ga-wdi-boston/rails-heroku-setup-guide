![General Assembly Logo](http://i.imgur.com/ke8USTq.png)

# Deploying to Heroku
You've learned a lot about how to build a Rails application over the last few weeks. Now let's 'go public' and share our apps with the world!

## Instructions

Fork and follow along.

## Objectives

By the end of this lesson, students should be able to:

- Create a heroku app from the command line
- Push the latest code to heroku
- Migrate the production database

## Set Up A Heroku Account (Do Once)
### Heroku.com
The first step is creating an account on Heroku, which you can do at [https://www.heroku.com](https://www.heroku.com). You will be sent an activation email, so be sure to activate your account.

### Heroku Toolbelt
The Heroku Toolbelt can be found [here](https://toolbelt.heroku.com/). Download and install it.

### Log into Heroku from your console.
Run `heroku login`; you should be prompted for the credentials for your Heroku account. Once you log in, if you're prompted to add the credentials to your keychain, say yes.

## Set Up Your Heroku App (Do Each Time)
### Create a new Heroku app for your project
Go to the root of your repo and run `heroku create`. This will create a _strangely_ named app, and add a new remote repository to your repo called _heroku_. You can look more closely at it by typing     `git remote -v`

```bash
    heroku  git@heroku.com:agile-badlands-7658.git (fetch)
    heroku  git@heroku.com:agile-badlands-7658.git (push)
    origin  git@github.com:tdyer/wdi_4_rails_hw_tdd_hacker_news.git (fetch)
    origin  git@github.com:tdyer/wdi_4_rails_hw_tdd_hacker_news.git (push)
```

### Test Your App in 'Production' Mode
Although many tools are easy to use in a development context, they may not be able to support the demands of a fully-operational app. This is why our Rails apps give us the option of having one set of tools and settings for development and another for production. Since our apps will be live on Heroku, the Heroku app will use whatever we've set as our 'production' settings. So before we even think about pushing, we should probably test-run our app locally in production mode.

First, add the following to your Gemfile, and run `bundle install`.

```ruby
group :production do
     gem 'rails_12factor'
     gem 'puma'
end
```

> It also might be a good idea to specify the particular version of Ruby that your app is using, since it may sometimes cause issues (and in any case, Heroku will complain if you don't).

We've been using a server called WEBrick so far, and although it's fine for fiddling around, it's performance isn't stellar, and it's not great at handling heavy loads. In production mode, we're going to swap it out for another server called Puma.

To tell Heroku that we want to run Puma, we also need to create a file called a _Procfile_ in the root of our repo.

`touch Procfile`

Inside it, we should put the following:

```bash
web: bundle exec puma -t 5:5 -p ${PORT:-3000} -e ${RACK_ENV:-development}
```

Next, if you don't have one already, create a `.gitignore` file. Heroku apps have environmental variables which live outside of the app, and you can set these either through the web interface or through the console (`heroku config`). In order to effectively simulate Heroku on our local machines, we'll also need those environmental variables. However, some of those variables will need to be secret! So, in addition to creating a new file to hold those variables, we'll need to make sure that it **_NEVER_** gets added to our commits.

> ****THIS IS VERY IMPORTANT! COMMITTING SECRETS CAN COST YOU THOUSANDS OF DOLLARS, AND POTENTIALLY YOUR JOB!****

Somewhere inside your `.gitignore`, add the following line: `.env`. Then, and _only then_, create a new file called `.env` in the root of your repo. Add the following content to it:

```bash
# Settings for production environment
SECRET_KEY_BASE= #(some secret key for production - generate it by running `RAILS_ENV=production rake secret`)
RACK_ENV=development
PORT=3000
```

As you can see from the comment above, in order to generate a secret key for our database, you'll need to run the command `RAILS_ENV=production rake secret`. This will spit out a long key into your console - copy the entire key and use it as the value of `SECRET_KEY_BASE`.

Once all of this is done, **check again** that Git is unaware of `.env` by running `git status` - if `.env` shows up on that list, stop what you're doing and get help, because you've done something wrong.

Next, create a new role in postgres for your app, and in that role, create a new 'production' database for your app.

#### Console

```bash
psql -d postgres
```

#### Postgres Console


`postgres=# create role <app_name> login createdb;`

`postgres=# \q`
```

##### Console

```bash
RAILS_ENV=production bundle exec rake db:create
```

Finally, download a gem called foreman (`gem install foreman`), which we'll be using to run our app. To start it, enter : `foreman start`.

If everything works correctly when you run the app with foreman, it should also work on Heroku!

## Deploy To Heroku
Now that we've tested our code locally, let's push our code up to the remote repo on Heroku.


`git push heroku master`


### Remotely run migrations and seed Heroku's database.


`heroku run rake db:migrate`

`heroku run rake db:seed`


### Restart and open the current app on Heroku


`heroku restart && heroku open`

### At any point you can change you apps name with the following command:

`heroku apps:rename newname`

Your app will become immediately available at it's new subdomain:

`newname.herokuapp.com`


## For Reference
### Heroku Commands
A full list of Heroku commands can be access by running `heroku --help`; below are some of the more common ones.

Behavior                               | Commands
:------------------------------------: | :------------------------------------------------------------------------------------------------------:
`heroku apps:info`                     | Get info about ALL of our Heroku apps.
`heroku apps:info --app {name_of_app}` | Get info about a specific Heroku app.
`heroku apps:open --app {name_of_app}` | Open any given Heroku app <br> (other than the one we're currently working with.)
`heroku config`                        | Environmental variables in your current Heroku app.
`heroku logs`                          | Logs from the currently running app.
`heroku ps`                            | Processes running in your heroku application.
`heroku releases`                      | Each time you deploy to heroku you are creating a "release". This command shows all releases.
`heroku pg:info`                       | Access Postgres from within Heroku and show the heroku plan, connections, pg version, data size, tables.
`heroku pg:psql`                       | ... and open a `psql` console.
`heroku run ...`                       | Run a program from within Heroku.

### WARNING : Ephemeral Filesystem!
One serious limitation of Heroku is that it provides an 'ephemeral filesystem'; if you save something, like an uploaded image file, it will disappear when your app is restarted or redeployed.

As an example, try running the following commands:

`heroku run bash`

`$ touch happy.txt; echo 'is happy' > happy.txt`

`$ cat happy.txt`

Then, hit Ctrl-D to get out of heroku bash shell. If you re-open the shell and run `ls -l`, `happy.txt` will be missing!

The typical workaround is to save files in cloud storage such as [Amazon S3](https://aws.amazon.com/s3/); more on this in the near future.

### Additional Reading
- [https://devcenter.heroku.com/categories/command-line](https://devcenter.heroku.com/categories/command-line)
