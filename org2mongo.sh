#! /bin/sh

# fetch ripe.db.route
# unpack

wget "ftp://ftp.ripe.net/ripe/dbase/split/ripe.db.organisation.gz"

gzcat ripe.db.organisation.gz | awk 'BEGIN{ORS=""; RS="\n\n+"; FS="\:"} $1 == "organisation" { sub(/^[ \t\r\n]+/, "", $2); org = $2; } $1 == "org-name" {orgname = sub(/^[ \t\r\n]+/, "", $2); print("db.org.insert({ org:\"" org "\", org-name:\"" $2 "\"});\n");}' >> db.org.js

# First delete the entries we already have, then load what we just worked out

mongo routes --eval "db.org.drop()"
mongo routes < db.org.js

# Delete the files

rm db.as-set.js


