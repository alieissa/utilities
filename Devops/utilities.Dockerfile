FROM node:11

RUN apt-get update && apt-get install -y vim

# Not necessary for this container but good practice to always work in users
# home
ENV HOME /root
WORKDIR $HOME

RUN npm i -g eslint

# Utilities repo holds all useful scripts and config files
RUN git clone https://github.com/alieissa/utilities.git

# Temp repo is used to test git commands, git hooks, webhooks, etc.
RUN git clone https://github.com/alieissa/temp.git

