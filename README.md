[![General Assembly Logo](https://camo.githubusercontent.com/1a91b05b8f4d44b5bbfb83abac2b0996d8e26c92/687474703a2f2f692e696d6775722e636f6d2f6b6538555354712e706e67)](https://generalassemb.ly/education/web-development-immersive)

# Rails Deployment with Heroku

You've learned a lot about how to build a Rails application over the last few
weeks. Now let's 'go public' and share our apps with the world!

## Prerequisites

-   [ga-wdi-boston/rails-api](https://github.com/ga-wdi-boston/rails-api)
-   [ga-wdi-boston/rails-activerecord-crud](https://github.com/ga-wdi-boston/rails-activerecord-crud)

## Objectives

By the end of this, developers should be able to:

-   Create a heroku app from the command line
-   Push the latest code to heroku
-   Migrate the production database

## Preparation

1.  No forking is necessary for this talk.

## Set Up A Heroku Account

The first step is creating an account on Heroku, which you can do at
[https://www.heroku.com](https://www.heroku.com). You will be sent an activation
email, so be sure to activate your account.

## Install Heroku Toolbelt

The Heroku Toolbelt can be found [here](https://toolbelt.heroku.com/). Download
and install it.

## Login To Heroku

Run `heroku login`; you should be prompted for the credentials for your Heroku
account. Once you log in, if you're prompted to add the credentials to your
keychain, say yes.

## Deploying to Heroku

Now you're setup to use heroku. Every time you want to deploy a new application,
follow these steps:

-   [ ] Create a heroku app from the command line (`heroku create`)
-   [ ] Add the `rails_12factor` gem to the production group in your Gemfile, if
    it doesn't already exist.
-   [ ] Make sure you have specified a ruby version in your Gemfile. It should
    match the version referenced in `.ruby-version`, if that file exists.
-   [ ] `bundle install` to make sure `Gemfile.lock` is up-to-date.
-   [ ] Push the latest code to heroku (`git push heroku master`)
-   [ ] Migrate the production database (`heroku run rake db:migrate`)
-   [ ] If you have seeds or examples, you may wish to run those with `heroku
    run` as well.

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
+ ruby '2.2.4'
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

## Changing Your App Name

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
if you save something, like an uploaded image file, it will disappear when your
app is restarted or redeployed.

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
