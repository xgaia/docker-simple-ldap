#! /bin/sh

# Create the config file
export ROOT_PW=$(slappasswd -s "$ROOT_PW_CLEAR")
cat /ldap/slapd.conf | envsubst > /etc/openldap/slapd.conf

# Create organisation file
cat /ldap/organisation.ldif | envsubst > /etc/openldap/organisation.ldif
slapadd -l /etc/openldap/organisation.ldif

# create user file
if $FIRST_USER; then
    export USER_PW=$(slappasswd -s "$USER_PW_CLEAR")
    cat /ldap/user.ldif | envsubst > /etc/openldap/user.ldif
    slapadd -l /etc/openldap/user.ldif
fi

# Add *.ldif in /ldif
for file in /ldif; do
    if [ ${file: -5} == ".ldif" ]; then
        slapadd -l $file 
    fi
done

slapd -d stats -h ldap:///
