# Client Logging
The Convergence JavaScript client has a built-in logging framework that allows for detailed logging of the client operation. The logging framework facilitates status, error, and debug logging.  The [API Documentation](https://docs.convergence.io/js-api/classes/convergence.html#configurelogging) contains specific information on the available options. Logs are output to the JavaScript console.

## Loggers
Log messages within the client are output to specific loggers. The loggers categorize related messages into groups that can be turned on and off independently.

| Logger      | Description |
| ----------- | ----------- |
| `protocol`   | Protocol messages between the client and server. |
| `connection` | High level connection and authentication related logs. |
| `socket`     | Low level WebSocket connection messages. |
| `activities.activity`   | Logs related to individual activities. |
| `activities.service`   | Logs related to the activity service. |
| `models`   | Logs related to the RealTimeModel subsystem. |
| `storage`   | Logs related to the offline storage system. |


## Log Levels
Log messages are output at log levels. The level describes the severity of the log messages.  When configuring loggers, you can set the threshold of the messages that it will output. The table below is the priority order of the log levels.  For example, if the log level of a logger is set to INFO, then log messages output at the INFO, WARN, and ERROR levels will be output, but DEBUG and TRACE messages will not be output. 

| LEVEL       | Description |
| ----------- | ----------- |
| `SILENT`    | No log messages will be output. |
| `ERROR`     | Error messages that represent incorrect usage or a failure of the system. |
| `WARN`      | Represents a warning that could indicate an issue but is no necessarily a fatal issue.|
| `INFO`      | Represent information that might be in interest to users and developers. |
| `DEBUG`     | Information that is likely of interest to developer when debugging their application. |
| `TRACE`     | Information that is likely only of interest to a developer working on Convergence itself. |

## Configuration
The logging system can be configured using the static `Convergence.configureLogging()` method.

```ts
Convergence.configureLogging({
  // Configures the default log level if not otherwise specified.
  root: LogLevel.ERROR, 
  
  // Configures specific loggers to output at a specific level.
  loggers: {
    "connection": LogLevel.DEBUG
  }
});
```