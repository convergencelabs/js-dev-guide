# Database Persistence
Convergence uses the open source [OrientDB](https://orientdb.org/) database to store persistence data. Convergence uses OrientDB 3.0.X.  Other versions are not supportd. 

At present time there is not a great deal of documentation on the OrientDB schema.  However, the overall schema structure can be gleaned from the schema installation scrips referenced below.  Persistence options that configure how to connect to the database can be found documented at the path `convergence.persistence` in the [server configuration](https://github.com/convergencelabs/convergence-server/blob/master/src/main/resources/reference.conf)

## The Convergence Database
Convergence stores server level information (e.g., user, roles, which domains exist, etc.) in a single database usually named `convergence`.  It's schema can be found on [GitHub here](https://github.com/convergencelabs/convergence-server/tree/master/src/main/resources/com/convergencelabs/convergence/server/db/schema/convergence/schemas).  The most current schema will have the highest version.  You can check the tag for your release and view the most recent schema file.  Configuration for the Convergence schema can be found under the [`convergence.persistence.convergence-database`](https://github.com/convergencelabs/convergence-server/blob/master/src/main/resources/reference.conf) configuration key.

## Domain Databases
Each domain within Convergence has its own database within OrientDB.  Domain schema can be found on [GitHub here](https://github.com/convergencelabs/convergence-server/tree/master/src/main/resources/com/convergencelabs/convergence/server/db/schema/domain/schemas).  The most current schema will have the highest version number.  Again, you can check the tag for your release and view the most recent schema file.  Configuration for the Convergence schema can be found under the [`convergence.persistence.domain-databases`](https://github.com/convergencelabs/convergence-server/blob/master/src/main/resources/reference.conf) configuration key.

When you create a new domain, a new database with the latest schema will be provisioned.  Likewise, when you delete a domain, all of its data will be deleted by deleting the database.

## Proper Shutdown
It is highly recommended that you shut down OrientDB cleanly.  For example, on Linux / Unix it is recommended to send a SIGTERM signal to the process rather than a SIGKILL.  SIGTERM will allow OrientDB to shutdown gracefully, closing transactions and flushing data to disk before terminating.  While rare, unclean shutdowns of the database can lead to unrecoverable data corruption.