FROM ruby:3.2

# Install dependencies
RUN apt-get update -qq && apt-get install -y \
  build-essential \
  libpq-dev \
  nodejs \
  yarn \
  curl \
  postgresql-client

# Set working directory
WORKDIR /app

# Install Rails dependencies
COPY Gemfile Gemfile.lock ./
RUN bundle install

# Add the Rails app
COPY . .

# Add entrypoint
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

# Precompile assets & expose port
EXPOSE 3000

CMD ["sh", "-c", "rm -f tmp/pids/server.pid && bundle exec rails s -b 0.0.0.0"]
