tutum-docker-postgresql
=======================

Base docker image to run a PostgreSQL database server


Usage
-----

To create the image `pennassurancesoftware/postgresql`, execute the following command on the tutum-docker-postgresql folder:

	docker build -t pennassurancesoftware/postgresql .

To run the image and bind to port 5432:

	docker run -d -p 5432:5432 pennassurancesoftware/postgresql

The first time that you run your container, a new user `postgres` with all privileges 
will be created in PostgreSQL with a random password. To get the password, check the logs
of the container by running:

	docker logs <CONTAINER_ID>

You will see an output like the following:

	========================================================================
	You can now connect to this PostgreSQL Server using:

	    psql -h <host> -p <port> --username=postgres
	and enter the password 'HHrUZyI6ubWF' when prompted
	    
	Please remember to change the above password as soon as possible!
	========================================================================

In this case, `HHrUZyI6ubWF` is the password assigned to the `postgres` user.

Done!


Setting a specific password for the admin account
-------------------------------------------------

If you want to use a preset password instead of a random generated one, you can
set the environment variable `POSTGRES_PASS` to your specific password when running the container:

	docker run -d -p 5432:5432 -e POSTGRES_PASS="mypass" pennassurancesoftware/postgresql
	
Create Database And Database User
-------------------------------------------------

You can also specify a database that will be created along with a database user that will own the newly created database.

    docker run -d -p 5432:5432 -e USER="my_user" -e PASS="mypass" -e DB="my_db" pennassurancesoftware/postgresql


Mounting the database file volume
---------------------------------

Coming soon!


Migrating an existing PostgreSQL Server
----------------------------------

Coming soon!
