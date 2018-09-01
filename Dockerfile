# Set the Docker image you want to base your image off.
# I chose this one because it has Elixir preinstalled.
FROM elixir:latest


# install the latest phoenix 
RUN mix archive.install https://github.com/phoenixframework/archives/raw/master/phoenix_new.ez --force
# Setup Node - Phoenix uses the Node library `brunch` to compile assets.
# The official node instructions want you to pipe a script from the 
# internet through sudo. There are alternatives: 
# https://www.joyent.com/blog/installing-node-and-npm
RUN curl -sL https://deb.nodesource.com/setup_6.x | bash - && apt-get install -y nodejs

# Install other stable dependencies that don't change often

# Compile app
RUN mkdir /app
COPY . /app
WORKDIR /app

# Install Elixir Deps
ADD mix.* ./
RUN MIX_ENV=prod mix local.rebar
RUN MIX_ENV=prod mix local.hex --force
RUN MIX_ENV=prod mix deps.get

# Install Node Deps
WORKDIR /app/assets
RUN npm install

# Compile assets
RUN NODE_ENV=production node node_modules/brunch/bin/brunch build --production
WORKDIR /app
RUN MIX_ENV=prod mix phx.digest


# Install app
RUN cd deps/bcrypt_elixir && make clean && make
RUN MIX_ENV=prod mix compile

# Exposes this port from the docker container to the host machine
EXPOSE 4000

# The command to run when this image starts up
# CMD MIX_ENV=prod mix ecto.migrate && \
  # MIX_ENV=prod mix phoenix.server
CMD MIX_ENV=prod mix ecto.migrate && \
  MIX_ENV=prod  PORT=4000 mix phx.server