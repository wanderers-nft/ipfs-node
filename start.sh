set -ex
docker-compose up -d

# Wait for the lock to be released
sleep 1

# Files (in order):
# The Wanderers (metadata)
# The Wanderers
# WS16 Posters (metadata)
# WS16 Posters
docker-compose exec -dT ipfs ipfs pin add \
QmNnWrwfAbsnWvyTgGpaYLdh1oAkBR5B74MjwZh8stTL97 \
QmWeXmth66wkCT5RYeBG9p1mnHgzAkTxoAtBdPy3CzE6o8 \
QmY4GnpgS3eF95qShPDGr7zLXwffBbybF2aeY4mqoEZcCm \
Qmbj1YhaGYHAdMBrVum7BAJP5ECJuarLcYaRFdEzDEBFN2 \
--progress