FROM node:11

RUN apt-get update && apt-get install -y vim

# Not necessary for this container but good practice to always work in users
# home
ENV HOME /root
WORKDIR $HOME

# Expose ports between 2000 and 9000. Use -p option when running to expose to host
EXPOSE 2000-9000
RUN npm i create-react-app jest jest-cli enzyme  -g
RUN npm i -g eslint

# Utilities repo holds all useful scripts and config files
RUN git clone https://github.com/alieissa/utilities.git

# Temp repo is used to test git commands, git hooks, webhooks, etc.
RUN git clone https://github.com/alieissa/temp.git

