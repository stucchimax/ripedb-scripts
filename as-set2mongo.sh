#! /bin/sh

# fetch ripe.db.route
# unpack

wget "ftp://ftp.ripe.net/ripe/dbase/split/ripe.db.as-set.gz"

gzcat ripe.db.as-set | awk 'BEGIN{ORS=""} $1 == "asSet:" { asset = $2; } $1 == "members:" { for (i = 2; i <= NF; i++) {sub(/,/, "", $i); print("db.asSet.insert({ asSet : \"" asset "\" , member : \"" $i "\"});\n");}}' >> db.as-set.js

# First delete the entries we already have, then load what we just worked out

mongo routes --eval "db.asSet.drop()"
mongo routes < db.as-set.js

# Delete the files

rm db.as-set.js

