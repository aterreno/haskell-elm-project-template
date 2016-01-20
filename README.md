# Haskell & Elm project template

## Getting started

### First time setup

    # Install stack
    brew update
    brew install haskell-stack

    # Get the code
    git clone git@github.com:leonidas/haskell-elm-project-template
    cd haskell-elm-project-template

    # Install dependencies (might take a while, uses up to 1 GB of hard disk space)
    stack setup

### Building and running

    # Run tests
    stack test

    # Build and start a development server
    stack build
    stack exec server