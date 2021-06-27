# Upgrading Convergence

Upgrading Convergence is fairly straight forward. The first step is simply to deploy a new versions of the Convergence Server.  Generally this involves deploying a new container or installing a new version of the binary distribution.

## Database Updates
When adding new features and fixing bugs it is sometimes required to update the Database structure Convergence uses for persistence.  This can involve both the core Convergence schema (usually named "convergence") as well as the schema for each domain database.

## The Upgrade Process
Starting the upgrade is a simple as starting up a new version of convergence with the same persistence configuration (e.g., pointing to the same database instance.)  If changes to the Convergence schema are required, the new version of the server will automatically detect the need to update the schema and will automatically upgrade the Convergence Schema. It is recommended to watch the console log when first starting up after an upgrade to watch for any potential issues.

The upgrade check will also examine all domains to see if their schema is in need of update. If no domains are in need of update, then the upgrade process is complete.  Any domain that does require an update will be marked as "Upgrade Required". These domains will not be usable until the upgrade is completed.  Please see the next page for the domain upgrade process.

## Backup Prior to Upgrade
It is **strongly recommended** you back up your databases before performing an upgrade. While we try our best to test the upgrade process rigorously, data in the wild can surface issues that were not foreseen.  A failed upgrade can leave the database in a state that might require intimate knowledge of Convergence and Orient DB to correct.  Backing up your data prior to an upgrade is the best defense against data loss or corruption.