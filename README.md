# Haskell & Elm project template

## Getting started

### First time setup

    # Install stack
    brew update
    brew install haskell-stack

    # Install the Elm tools
    brew install elm

    # Get the code
    git clone git@github.com:leonidas/haskell-elm-project-template
    cd haskell-elm-project-template

    # Install ghc (might take a while, uses up to 1 GB of hard disk space)
    stack setup

    # Install dependencies
    stack install --only-dependencies

    # Install tools
    npm install

### Building and running

    # Run tests
    stack test

    # Run a Haskell REPL
    stack ghci

    # Start a development server
    npm start
