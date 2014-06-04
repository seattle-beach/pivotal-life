[![Build Status](https://travis-ci.org/pivotal/pivotal-life.svg)](https://travis-ci.org/pivotal/pivotal-life) [![Dependency Status](https://gemnasium.com/pivotal/pivotal-life.svg)](https://gemnasium.com/pivotal/pivotal-life)

# Pivotal Life

A dashboard for Pivots at the office.

## Requirements

- [Ruby](https://www.ruby-lang.org/en/)
- [Bundler](http://bundler.io/)
- [NodeJS](http://nodejs.org/) & [npm](https://www.npmjs.org/)
- [PhantomJS](http://phantomjs.org)
- [CloudFoundry Command-Line Interface](https://github.com/cloudfoundry/cli)

On Mac you can install NodeJs, PhantomJs and CloudFoundry with the following:

    $ brew install node
    $ brew install phantomjs
    $ brew install cloudfoundry-cli

## Setup

To checkout and run the project locally:

    $ git clone git@github.com:spilth/pivotal-life.git
    $ cd pivotal-life
    $ bundle
    $ npm install -g coffee-script

### Environment Variables

To run the dashboard you will need a `.env` file with various tokens and keys.  The fastest way to do this is by pulling them down from Cloud Foundry.

First, target the pivotal-life app on the public Cloud Foundry deployment:

    $ cf api api.run.pivotal.io

Then log in to Cloud Foundry:
 
    $ cf login

Select the `pivotallabs` org.

Note: You will need to belong to the `pivotallabs` org and have access to the `pivotal-life` space.

Next, build a `.env` file using the Cloud Foundry settings:
   
    $ ./populate-dotenv.sh

### Running

Now run the local server:
    
    $ bundle exec dashing start

Then navigate to <http://localhost:3030/>.

## Deploying

Once you are logged in to Cloud Foundry, per above, do the following:

### Staging

    $ cf push -f staging-manifest.yml

Navigate to <http://pivotal-life-staging.cfapps.io/>

### Production

    $ cf push -f manifest.yml

Navigate to <http://pivotal-life.cfapps.io/>

## Resources

- [Pivotal Tracker Project](https://www.pivotaltracker.com/s/projects/950406)
- [Dashing](http://shopify.github.com/dashing)
- PM: Michael McGinley

