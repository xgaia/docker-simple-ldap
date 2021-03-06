FROM alpine:3.9
MAINTAINER "xavier.garnier@irisa.fr"

ENV ORGANISATION_NAME "Example"
ENV SUFFIX "dc=example,dc=com"
ENV ROOT_USER "admin"
ENV ROOT_PW_CLEAR "admin"

ENV FIRST_USER=false
ENV USER_UID "jdoe"
ENV USER_GIVEN_NAME "John"
ENV USER_SURNAME "Doe"
ENV USER_EMAIL "jdoe@example.com"
ENV USER_PW_CLEAR "iamjohndoe"

COPY slapd.conf /ldap/slapd.conf
COPY organisation.ldif /ldap/organisation.ldif
COPY user.ldif /ldap/user.ldif
COPY entrypoint.sh /entrypoint.sh

RUN apk add --update --no-cache openldap openldap-back-mdb libintl && \
    apk add --no-cache --virtual build_deps gettext && \
    mkdir -p /run/openldap /var/lib/openldap/openldap-data /ldap /ldif

CMD ["/entrypoint.sh"]
