# Studio Melipone’s Docker container for Ruby 2.1.1

The container is based on phusion/baseimage-docker and has ruby 2.1.1 installed. It is intended for local development.

Services installed and running:

 - Postgresql 9.1
 - Redis
 - Memcache

**How it works**

You rails application needs to be mounted to /rails_app or the container won’t work properly.
You’ll need to have a `docker` directory at the root of your project. Inside this directory, create a `bundler` directory and a `run.sh` script.
Write any commands needed to boot your app in the `run.sh` script and know that the following commands are executed automatically before invoking the `run.sh` script:

 - bundle install
 - rake db:create
 - rake db:migrate

**How to use**

Just run the container like this (example with our Tadaam app):

    $ docker run -t -i -v ~/Coding/tadam:/rails_app -p 3000:3000 -p 3001:3001 studiomelipone/ruby:2.1

This will automatically boot our Rails app and forward ports 3000 and 3001 to the host.

**Persistant DB**

It is possible to keep the DB between runs, just mount a directory that Postgresql will use at `/var/lib/postgresql`. Example:

    $ docker run -t -i -v ~/Coding/tadam:/rails_app -v ~/Coding/tadam/docker/postgresql:/var/lib/postgresql -p 3000:3000 -p 3001:3001 studiomelipone/ruby:2.1

Don’t worry about an empty directory on the first run, the container will create a new PG database for you.

**Accessing the DB**

A role for `root` is created automatically and has all the permissions on the DB. So a typical `database.yml` could look like this:

    development:
      adapter: postgresql
      encoding: unicode
      database: tadaam_development
      pool: 5
      username: root
