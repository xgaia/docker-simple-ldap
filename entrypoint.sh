#! /bin/sh

# Create the config file
export ROOT_PW=$(slappasswd -s "${ROOT_PW_CLEAR}")
cat /ldap/slapd.conf | envsubst > /etc/openldap/slapd.conf

# Create organisation once
test_org_file=/var/lib/openldap/openldap-data/.organisation
if [ ! -f ${test_org_file} ]; then
    touch ${test_org_file}
    cat /ldap/organisation.ldif | envsubst > /etc/openldap/organisation.ldif
    slapadd -l /etc/openldap/organisation.ldif
fi

# Insert first user once
test_user_file=/var/lib/openldap/openldap-data/.first_user

if [ ! -f ${test_user_file} ]; then
	if [ ${FIRST_USER} == "true" ]; then
        touch ${test_user_file}
        export USER_PW=$(slappasswd -s "${USER_PW_CLEAR}")
        cat /ldap/user.ldif | envsubst > /etc/openldap/user.ldif
        slapadd -l /etc/openldap/user.ldif
	fi
fi

# Add *.ldif in /ldif
for file in /ldif; do
    if [ ${file: -5} == ".ldif" ]; then
        slapadd -l $file 
    fi
done

slapd -d stats -h ldap:///
