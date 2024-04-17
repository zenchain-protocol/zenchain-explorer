# Zenchain Explorer Backend

Zenchain Explorer is a comprehensive block explorer and analytics platform tailored for the Zenchain blockchain. Originating as a fork from Blockscout, the Zenchain Explorer has undergone significant enhancements to improve functionality and ease of deployment across various operating systems.

The Zenchain Explorer ecosystem consists of the following components:

* Zenchain Explorer Backend (**the current repository**)
* Zenchain Explorer Frontend <https://github.com/zenchain-protocol/zenchain-explorer-frontend>
* Zenchain Explorer Rust Services <https://github.com/zenchain-protocol/zenchain-explorer-rs>

# Development environment configuration

The process of setting up the development environment for Zenchain Explorer Backend, which is built using Elixir, differs depending on the operating system in use. This tutorial is designed to guide you through the preparation of your development environment, tailored to each of these operating systems.

## Dependencies

To successfully compile your code, it's essential to first install the required dependencies, with the installation process varying depending on your operating system.

### Git

Git is needed to get code from repositories.

#### Linux/WSL (Windows Subsystem for Linux)

Follow the instructions based on your Linux distribution (WSL by default installs Ubuntu) <https://git-scm.com/download/linux>

#### MacOS

Install Homebrew <https://brew.sh> and execute the following command:

```bash
brew install git
```

#### Windows

Download and execute the installer based on your architecture <https://git-scm.com/download/win>

### Asdf

#### Linux/WSL (Windows Subsystem for Linux)

`curl` package is needed, you can install it executing the following command (Ubuntu as reference):

```bash
sudo apt install -y curl
```

clone the Asdf repository with the following command:

```bash
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.14.0
```

edit the `~/.bashrc` file appending the following lines:

```bash
. "$HOME/.asdf/asdf.sh"
. "$HOME/.asdf/completions/asdf.bash"
```

install needed plugins executing the following commands:

```bash
asdf plugin add erlang
asdf plugin add elixir
asdf plugin add nodejs
```

#### MacOS

`curl` and `coreutils` packages are needed, you can install them executing the following commands:

```bash
brew install coreutils curl
```

clone the Asdf repository with the following command:

```bash
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.14.0
```

create/edit the `~/.bash_profile` file appending the following lines:

```bash
. "$HOME/.asdf/asdf.sh"
. "$HOME/.asdf/completions/asdf.bash"
```

install needed plugins executing the following commands:

```bash
asdf plugin add erlang
asdf plugin add elixir
asdf plugin add nodejs
```

### PostgreSQL

#### Linux/WSL (Windows Subsystem for Linux)

Install PostgreSQL with the following command:

```bash
sudo apt install postgresql
```

alter `postgres` password:

```bash
sudo -u postgres psql template1
ALTER USER postgres with encrypted password 'postgres';
```

create the environment variable used by the backend as connection string:

```bash
export DATABASE_URL=postgresql://postgres:postgres@localhost:5432/zenchain-explorer
```

#### MacOS

Install PostgreSQL with the following command:

```bash
brew install postgresql@15 libpq
brew link --force libpq
```

alter `MAC_USER` password:

```bash
ALTER USER MAC_USER with encrypted password 'postgres';
```

create the environment variable used by the backend as connection string:

```bash
export DATABASE_URL=postgresql://MAC_USER:postgres@localhost:5432/zenchain-explorer
```

### Additional dependencies

#### Linux/WSL (Windows Subsystem for Linux)

Execute the following command (Ubuntu as reference):

```bash
sudo apt install -y libssl-dev make automake autoconf libncurses5-dev gcc g++ inotify-tools
```

## How to compile

Create a new folder, open it in the terminal and execute:

```text
git clone https://github.com/zenchain-protocol/zenchain-explorer-backend
```

Open `zenchain-explorer-backend` folder and execute:

```bash
asdf install
mix local.hex --force
mix do deps.get, local.rebar --force, deps.compile
```

## Docker based development

You can also build and run all within Docker directly.

Edit the following environment variables:
* [common-backend.env](docker-compose/envs/common-backend.env) 
* [common-frontend.env](docker-compose/envs/common-frontend.env) 
* [common-smart-contract-verifier.env](docker-compose/envs/common-smart-contract-verifier.env) 
* [common-stats.env](docker-compose/envs/common-stats.env) 
* [common-visualizer.env](docker-compose/envs/common-visualizer.env) 

and then execute:

### All

```bash!
cd docker-compose
docker compose up -d
```

### Only backend

```bash!
cd docker-compose
docker compose -f external-frontend.yml up -d
```

starts containers and starts listening using the port `80`.

# Start the application locally

Generate a new authentication encryption key:

```bash
mix phx.gen.secret
```

set the key into the `SECRET_KEY_BASE` environment variable:

```bash
export SECRET_KEY_BASE=KEY
```

Install Node.js packages:

```bash
cd apps/block_scout_web/assets
npm install && node_modules/webpack/bin/webpack.js --mode production
cd -
```

Generate local SSL certificate for development:

```bash
cd apps/block_scout_web
mix phx.gen.cert zenchain-explorer zenchain-explorer.local
```

Edit [common-backend.env](docker-compose/envs/common-backend.env) variables and execute the following script to export all:

```bash
./export-backend-env.sh
```

You can now start the application for development with the following command:

```bash
mix phx.server
```
