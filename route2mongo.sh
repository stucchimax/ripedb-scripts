#! /bin/sh

# fetch ripe.db.route

wget "ftp://ftp.ripe.net/ripe/dbase/split/ripe.db.route.gz"

gzcat ripe.db.route.gz | awk 'BEGIN{ORS=""} $1 == "route:" {split($2, route, "/");print("db.routes.insert({ route : \"" route[1] "\", mask : " route[2] " , origin : ");} $1 == "origin:" {print("\"" $2 "\"});\n");}'  >> db.routes.js

# fetch ripe.db.route6

wget "ftp://ftp.ripe.net/ripe/dbase/split/ripe.db.route6.gz"

gzcat ripe.db.route6.gz | awk 'BEGIN{ORS=""} $1 == "route6:" {split($2, route, "/");print("db.routes6.insert ({ route : \"" route[1] "\", mask : " route[2] " , origin : ");} $1 == "origin:" {print("\"" $2 "\"});\n");}'  >> db.routes6.js

mongo routes --eval "db.routes.drop()"
mongo routes < db.routes.js

mongo routes --eval "db.routes6.drop()"
mongo routes < db.routes6.js

# Delete the files we just created

rm db.routes.js
rm db.routes6.js

