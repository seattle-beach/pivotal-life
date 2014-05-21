[![Dependency Status](https://gemnasium.com/pivotal/pivotal-life.svg)](https://gemnasium.com/pivotal/pivotal-life)

# Pivotal Life

A dashboard for Pivots at the office.

## Running Locally

To run the status board locally, do the following:

  Download and install the CloudFoundry CLI tool:

    https://github.com/cloudfoundry/cli

  Clone this repo:

    $ git clone git@github.com:spilth/pivotal-life.git
    $ cd pivotal-life

  Install gems and other dependencies:

    $ bundle
    $ npm install -g coffee-script


  Target the pivotal-life app on the public CloudFoundry deployment:

    $ cf target api.run.pivotal.io

  Log in to CF:
 
    $ cf login
      # Email: pivotal-beach@googlegroups.com
      # Password: Workstation password v3
      # Space: pivotal-life

  Run the app locally using CF environment variables:
   
    $ ./start.sh

Then navigate to <http://localhost:3030/>.


To run Dashing without the environment variables:

    $ dashing start

This will still run on <http://localhost:3030/>, but it won't connect to any of the external services.


## Deploying

### Staging

    $ cf push -f staging-manifest.yml

Navigate to pivotal-life-staging.cfapps.io

### Production

    $ cf push -f manifest.yml

Navigate to pivotal-life.cfapps.io

This app is built on the Dashing framework, which is based on Sinatra.
Check out http://shopify.github.com/dashing for more information.

## Resources

- [Pivotal Tracker Project](https://www.pivotaltracker.com/s/projects/950406)
- [Dashing](http://shopify.github.com/dashing)
- PM: Michael McGinley

