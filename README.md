[![General Assembly Logo](https://camo.githubusercontent.com/1a91b05b8f4d44b5bbfb83abac2b0996d8e26c92/687474703a2f2f692e696d6775722e636f6d2f6b6538555354712e706e67)](https://generalassemb.ly/education/web-development-immersive)

# Rails Deployment with Heroku

You've learned a lot about how to build a Rails application over the last few
weeks. Now let's 'go public' and share our apps with the world!

## Prerequisites

-   [ga-wdi-boston/rails-api](https://github.com/ga-wdi-boston/rails-api)
-   [ga-wdi-boston/rails-activerecord-crud](https://github.com/ga-wdi-boston/rails-activerecord-crud)

## Objectives

-   Create a Heroku app from the command line
-   Push the latest code to Heroku
-   Migrate the production database

## Getting Set Up

Before you can begin deploying your applications to Heroku, there are some
 things you'll need to do first.

1.  **Create a Heroku account**, at [https://www.heroku.com](https://www.heroku.com).
    You will be sent an activation email, so be sure to check your inbox so that
    you can activate your account.

1.  **Download and install the Heroku Toolbelt**, found [here](https://toolbelt.heroku.com/).

1.  **Log into Heroku** by running `heroku login` from the console and providing
    your Heroku credentials when asked. Once you log in, if you're prompted
    to add these credentials to your keychain, say yes.

## Deploying to Heroku

Now you're set up to use Heroku. To deploy a new application
 to Heroku:

-   [ ] Run `heroku create` in the command line to create a new (blank) app on
 Heroku.
-   [ ] On your production branch (i.e. `master`), add the `rails_12factor` gem
to the `production` section of your Gemfile if it doesn't already exist there.
-   [ ] Make sure you have specified a ruby version in your Gemfile. It should
    match the version referenced in `.ruby-version`, if that file exists.
-   [ ] Run `bundle install` to download `rails_12facter` and ensure that
`Gemfile.lock` is up-to-date.
-   [ ] Push your latest code to Heroku (`git push heroku master`)
-   [ ] Tell Heroku to run your migration files (`heroku run rake db:migrate`).
If you have any other rake tasks that need to run (e.g. `rake db:seed`), run
those with `heroku run` as well.

Let's look at each of these steps in detail.

### Create a New Heroku App

Go to the root of your repo and run `heroku create`. This will create a
_strangely_ named app, and add a new remote repository to your repo called
_heroku_. You can look more closely at it by typing `git remote -v`. You should
see something like this:

```bash
    heroku  git@heroku.com:agile-badlands-7658.git (fetch)
    heroku  git@heroku.com:agile-badlands-7658.git (push)
    origin  git@github.com:tdyer/wdi_4_rails_hw_tdd_hacker_news.git (fetch)
    origin  git@github.com:tdyer/wdi_4_rails_hw_tdd_hacker_news.git (push)
```

### Add `rails_12factor`

Add the following to your Gemfile, and run `bundle install`.

```ruby
group :production do
     gem 'rails_12factor'
end
```

### Specify a Ruby Version

Next, you should specify the particular version of Ruby that your app is using,
since it may sometimes cause issues (and in any case, Heroku will complain if
you don't).

```diff
# Gemfile
source 'https://rubygems.org'
+ ruby '2.3.0'
```

Every time you edit your `Gemfile`, you must run `bundle install` afterward.
**Always** commit `Gemfile` and `Gemfile.lock` together, and always commit them
immediately after adding a new gem.

### Push `master` to Heroku

Only keep clean, working code on `master`. After you work on a feature and
complete it, merge it into `master`. Push your updated `master` to GitHub, then
deploy to Heroku.

```sh
git checkout master
git merge my-feature # merge your working code
git push # update GitHub
git push heroku master # udpate heroku
```

### Update Heroku's Database

Once you've deployed your code, you can safely run new migrations. You'll need
to do this step every time you have new migrations.

```sh
heroku run rake db:migrate
```

If you have seeds or examples, or if you've updated seeds or examples, you
should also run them on heroku.

```sh
heroku run rake db:seed
heroku run rake db:examples
```

### Check Your Work

Restart your application and check it out in the browser.

```sh
heroku restart
heroku open
```

You'll probably see something like this:

<img width="599" alt="herokuapp_png_1_366x768_pixels" src="https://cloud.githubusercontent.com/assets/388761/13259005/93c9fdf6-da23-11e5-9c90-19c59580944a.png">

That's normal, **unless** you have defined a root route.

## OR you'll see something like this

<img width="599" alt="herokuapp_png_1_366x768_pixels" src="https://i.gyazo.com/46a08819fc5c636ea24178c8b12a406c.png">

### That's okay. Don't Panic. You've got this

Paste the following into your terminal:

```sh
git add config/secrets.yml -f
```

Press enter. Good job!

```sh
git commit
```

#### Now you need to push these changes

Push them to your master and then heroku

```sh
git push origin master
```

```sh
git push heroku master
```

<img width="400" alt="herokuapp_png_1_366x768_pixels" src="http://www.thehinzadventures.com/wp-content/uploads/2015/03/54843046.jpg">

### You're almost there

enter the following into your terminal, one after the other:

```sh
heroku config:set SECRET_TOKEN=$(rake secret)
```

```sh
heroku config:set SECRET_KEY_BASE=$(rake secret)
```

### Change Your App's Name

At any point, you can pick a new name for your app. It must be unique across
all apps deployed to heroku.

```sh
heroku apps:rename newname
```

Your app will become immediately available at it's new subdomain,
`newname.herokuapp.com`.

## Heroku Command Reference

A full list of Heroku commands can be access by running `heroku --help`; below
are some of the more common ones.

|                Behavior                |                                                 Commands                                                 |
| -------------------------------------- | -------------------------------------------------------------------------------------------------------- |
|           `heroku apps:info`           |                                  Get info about ALL of our Heroku apps.                                  |
| `heroku apps:info --app {name_of_app}` |                                  Get info about a specific Heroku app.                                   |
| `heroku apps:open --app {name_of_app}` |            Open any given Heroku app <br> (other than the one we're currently working with.)             |
|            `heroku config`             |                           Environmental variables in your current Heroku app.                            |
|             `heroku logs`              |                                   Logs from the currently running app.                                   |
|              `heroku ps`               |                              Processes running in your heroku application.                               |
|           `heroku releases`            |      Each time you deploy to heroku you are creating a "release". This command shows all releases.       |
|            `heroku pg:info`            | Access Postgres from within Heroku and show the heroku plan, connections, pg version, data size, tables. |
|            `heroku pg:psql`            |                                      ... and open a `psql` console.                                      |
|            `heroku run ...`            |                                    Run a program from within Heroku.                                     |

## WARNING: Ephemeral Filesystem

One serious limitation of Heroku is that it provides an 'ephemeral filesystem';
in other words, if you try to save a new file inside the repo (e.g. an uploaded
image file), it will disappear when your app is restarted or redeployed.

As an example, try running the following commands:

```sh
heroku run bash
touch happy.txt; echo 'is happy' > happy.txt
cat happy.txt
```

Then, hit Ctrl-D to get out of heroku bash shell. If you re-open the shell and
run `ls -l`, `happy.txt` will be missing!

The typical workaround is to save files in cloud storage such as [Amazon
S3](https://aws.amazon.com/s3/); more on this in the near future.

## Additional Resources

-   [Heroku Command Line](https://devcenter.heroku.com/categories/command-line)

## [License](LICENSE)

Source code distributed under the MIT license. Text and other assets copyright
General Assembly, Inc., all rights reserved.
