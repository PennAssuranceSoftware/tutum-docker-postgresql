#!/bin/bash

if [ -f /.postgres_init_database ]; then
    echo "Database already initialized!"
    exit 0
fi

# Create User/Database
# Echo out info to later obtain by running `docker logs container_name`
USER=${USER:-super}
PASS=${PASS:-$(pwgen -s -1 16)}
echo "DATABASE_USER=$USER"
echo "DATABASE_PASS=$PASS"

echo "Creating the superuser: $USER"
sudo -u postgres psql -q <<-EOF
  DROP ROLE IF EXISTS $USER;
  CREATE ROLE $USER WITH ENCRYPTED PASSWORD '$PASS';
  ALTER USER $USER WITH ENCRYPTED PASSWORD '$PASS';
  ALTER ROLE $USER WITH SUPERUSER;
  ALTER ROLE $USER WITH LOGIN;
EOF


# Create database if requested
  if [ ! -z "$DB" ]; then
    for db in $DB; do
      echo "Creating database: $db"
      sudo -u postgres psql -q <<-EOF
      CREATE DATABASE $db WITH OWNER=$USER ENCODING='UTF8';
      GRANT ALL ON DATABASE $db TO $USER
EOF
    done
  fi

  if [[ ! -z "$EXTENSIONS" && ! -z "$DB" ]]; then
    for extension in $EXTENSIONS; do
      for db in $DB; do
        echo "Installing extension for $db: $extension"
        # enable the extension for the user's database
        sudo -u postgres psql $db <<-EOF
        CREATE EXTENSION "$extension";
EOF
      done
    done
  fi


touch /.postgres_init_database