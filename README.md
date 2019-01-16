# docker-simple-ldap

Simple OpenLDAP image based on Alpine Linux. Inspired by [gitphill/ldap-alpine](https://github.com/gitphill/ldap-alpine).

## Pull from DockerHub

```bash
docker pull xgaia/simple-ldap
```

## Or build

```bash
git clone https://github.com/xgaia/docker-simple-ldap.git
cd docker-simple-ldap
docker build . -t simple-ldap
```

## Run

```bash
sudo docker run -d --name myldap \
                -p 389:389 \
                -p 636:636 \
                xgaia/simple-ldap 
```

## Environment variables

Override the following environment variables when running the docker container to customise LDAP:

| VARIABLE | DESCRIPTION | DEFAULT |
| :------- | :---------- | :------ |
| ORGANISATION_NAME | Organisation name | Example |
| SUFFIX | Organisation distinguished name | dc=example,dc=com |
| ROOT_USER | Root username | admin |
| ROOT_PW | Root password | password |
| FIRST_USER | Create a user? | true |
| USER_UID | First user's uid | jdoe |
| USER_GIVEN_NAME | Initial user's given name | John |
| USER_SURNAME | Initial user's surname | Doe |
| USER_EMAIL | Initial user's email | jdoe@example.com |
| USER_PW | Initial user's password | iamjohndoe |

## Data persistance

Mount `/var/lib/openldap/openldap-data` to persist the ldap database.


```bash
sudo docker run -d --name myldap \
                -p 389:389 \
                -p 636:636 \
                -v openldap-data:/var/lib/openldap/openldap-data \
                xgaia/simple-ldap 
```
