# Server Logging
The Convergence Server uses the [Apache Log4j 2](https://logging.apache.org/log4j/2.x/) logging framework for logging. Please consult the [Log4J 2 Configuration Documentation](https://logging.apache.org/log4j/2.x/manual/configuration.html) for details on configuring Log4J.  

Generally speaking, Log4J can be configured by placing a `log4j2.yml` on the classpath. An example `log4j2.yml` file is shown below.  The three most relevant loggers are the following:

* `com.convergencelabs`: Configures logging from Convergence itself.
* `com.orientechnologies`: Configures logging for the OrientDB server and or client.
* `akka`: Configures logging for the Akka distributed computing framework.

```xml
<?xml version="1.0" encoding="UTF-8"?>
<Configuration status="WARN" shutdownHook="disable">
  <Appenders>
    <Console name="Console" target="SYSTEM_OUT">
      <PatternLayout pattern="%d{HH:mm:ss} %-5level %logger{1} - %msg%n"/>
    </Console>
  </Appenders>
  <Loggers>
    <Root level="warn"><AppenderRef ref="Console"/></Root>
    <Logger name="com.convergencelabs" level="info" />
    <Logger name="com.orientechnologies" level="error" />
    <Logger name="akka" level="warn" />
  </Loggers>
</Configuration>
```

Where to place the file depends on how you are deploying the server. Each distribution comes with a `log4j2.xml` file. If you locate this file and edit it or replace it you can configure the logging for the system.