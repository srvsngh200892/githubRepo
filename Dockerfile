FROM ruby:2.6.3
ENV APP_HOME /app
# Installation of dependencies
RUN apt-get update -qq \
  && apt-get install -y \
      # Needed for certain gems
    build-essential \
    libpq-dev \
    nodejs yarn \
    # The following are used to trim down the size of the image by removing unneeded data
  && apt-get clean autoclean \
  && apt-get autoremove -y \
  && rm -rf \
    /var/lib/apt \
    /var/lib/dpkg \
    /var/lib/cache \
    /var/lib/log
# Create a directory for our application
# and set it as the working directory
RUN mkdir $APP_HOME
WORKDIR $APP_HOME
# Add our Gemfile and install gems
ADD Gemfile* $APP_HOME/
RUN bundle install
# Copy over our application code
ADD . $APP_HOME
RUN bundle exec rails assets:precompile
# Run our app
CMD RAILS_ENV=${RAILS_ENV}  bundle exec rails s -p 8080 -b '0.0.0.0'
