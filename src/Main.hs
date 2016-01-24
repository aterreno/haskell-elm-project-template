{-# LANGUAGE OverloadedStrings #-}

module Main where

import Web.Scotty
import Network.Wai.Middleware.Cors

import System.Posix.Process (getProcessID)

server :: ScottyM ()
server = do
    middleware simpleCors

main :: IO ()
main = do
    getProcessID >>= writeFile "pids/backend.pid" . show

    scotty 9000 server
