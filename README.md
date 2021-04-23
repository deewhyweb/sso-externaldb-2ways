## Using the operator

Create project

Install postgres

`oc new-app --name=postgresql --template=postgresql-persistent -p  POSTGRESQL_USER=user -p POSTGRESQL_PASSWORD=pass`

Create secret

`oc apply -f keycloak-db-secret.yml`

Install Operator

Deploy RHSSO with external db flag

## Using the template

Install RHSSO74 from template

Install postgres

`oc new-app --name=postgresql --template=postgresql-persistent -p  POSTGRESQL_USER=user -p POSTGRESQL_PASSWORD=pass`

`oc create configmap extensions --from-file=extensions`

`oc apply -f db-env-cm.yml`

`oc set env --from=configmap/db-env dc/sso`

`oc set volumes dc/sso --add --overwrite=true --name=extensions --mount-path=/opt/eap/extensions -t configmap --configmap-name=extensions --default-mode='0755' `

## Test Postgres db

Login to the postgres pod terminal

```

psql

\c sampledb

\dt

```