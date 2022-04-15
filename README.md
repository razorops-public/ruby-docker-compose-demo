## Razorops CI/CD pipeline demo with Docker-compose

If you have forked this repo, then connect with Razorops to create your demo pipeline by following the below button

[![Connect](https://github.com/razorops-public/images/blob/main/connect_with_github.svg)](https://dashboard.razorops.com/get-github-installation-link-for-org)

This is an example code to demonstrate how to create [Docker-Compose](https://docs.docker.com/compose/) based pipeline on [Razorops](https://docs.razorops.com/).

It's a Ruby based implementation of [TodoBackend Spec](https://www.todobackend.com/), which implements the API using [Sinatra](http://sinatrarb.com/) framework.

### Local Setup

1. Use `bundle` to install the dependencies -

        bundle install

2. Migrate the database

        export DATABASE_URL=postgres://<user>:<password>/<host>/<database> # replace accordingly
        bundle exec rake nuke_db

You can use sqlite, mysql or any [sequel](http://sequel.jeremyevans.net/) compatible database.

3. To start the server in development mode run - 

        export DATABASE_URL=postgres://..
        bundle exec rake server

### Execute tests

Run following commands to execute the rspec suite - 

        bundle exec rspec

To turn on coverage reports - 

        COVERAGE=true bundle exec rspec


### Using Docker-compose

Use can also use Docker-Compose based setup to bootstrap the project easily -

        docker-compose build
        docker-compose up -d
        docker-compose exec -T web rake nuke_db

To execute the tests - 

        docker-compose exec -T web bundle exec rspec

### CI/CD pipeline

If you're new to Razorops, feel free to fork this repository and use it to [create a project](https://docs.razorops.com/getting_started/).

`.razorops.yaml` contains the pipeline code to build and execute the tests for this project. To know more about how to write and customize, refer to the [documentation](https://docs.razorops.com).

It uses Docker-Compose commands to bootstrap the containers and exec into web container to run the tests. Here is the link of [the pipeline](https://dashboard.razorops.com/apps/delicate-sunset-2750/workflows) workflows page.

### License

Copyright (c) 2021 Razorops LLC

Distributed under the MIT License. See the file LICENSE.md.
