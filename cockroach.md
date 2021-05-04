# Migrate schema from postgres

`oc exec -it postgresql-1-tvhx7 pg_dump sampledb > /schema/schema.sql`

Put the schema file online somewhere, e.g. github

# Import into cockroachDB

rsh into cockroach pod

`cockroach sql --certs-dir /cockroach/cockroach-certs`

`use 'tas-application-content-db';`

`import pgdump 'https://raw.githubusercontent.com/deewhyweb/sso-externaldb-2ways/master/schema/schema.sql'`