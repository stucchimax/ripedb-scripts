# ripedb-scripts

This is a set of scripts to import information from the RIPE Database (http://www.ripe.net/whois).

The use of these scripts can be to import data into a local DB for later analysis, or to have a series of data to generate local config files (especially from route/route6 objects).

## route2mongo.sh

This script takes route and route6 objects from the database and puts them into a local mongoDB database

## as-set2mongo.sh

This script takes the as-set objects from the database and puts them into a local mongoDB database
