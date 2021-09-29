Integrating a separate third-party API into your codebase is not a decision to be taken lightly.  So let's explore how Convergence is architected so you can get an idea of what integration with your application could look like.  We'll also provide some tips on both real-time collaboration UX and distributed data model design so you can get the most out of Convergence.

# System Architecture

The Convergence Collaboration Engine is a server with a socket-based endpoint and a convenient Javascript API for usage in the end-user application.  The JS API is the primary interface for utilizing the real-time capabilities of Convergence, such as mutating data, listening to changes in data (at any level of granularity), broadcasting user interface cues such as a cursor position, and listening to changes in participants' availability.  The client and server code are tightly coupled to provide automatic conflict resolution with both application data and any UI constructs that may be attached (for example, a user's cursor needs to be updated correctly when another user deletes a character in the preceding word).  

<figure class="arch">
  <img src="../assets/images/convergence-arch.svg" alt="Convergence Architecture">
  <figcaption>Figure 1: A very high-level view of an application using Convergence to sync the contents of an HTML &#60;textarea&#62;. The green and purple areas represent two different connected users using the app simultaneously. Note the "magic" happens in the (reconciliation) caption in the Convergence Server.</figcaption>
</figure>

Bundled with the server is a database for automatically and instantly persisting data model changes.  This is not strictly necessary for data synchronization but does allow for powerful tools such as data model history, playback, and undo at the most granular level possible.  However, many applications already have their source of truth, so Convergence provides a REST API for getting just about anything from the system, including a data model's contents.  

## Administration

Bundled with every Convergence deployment (even in the Developer Edition) is the Convergence Administration Console, a web-based tool allowing for easy management of most aspects of Convergence, notably:

- Creating and managing [domains](/domain/overview.html)
- Creating and managing collections and models
- Creating and managing [domain users](/identity/overview.html)
- Configuring per-domain settings for authentication
- Administering permissions at a model, collection, or domain level

## Flexible Persistence

We have found that Convergence performs quite well as the mechanism for synchronizing state during a collaboration session, after which the shared data can be persisted back to the application's database.  Furthermore, several sections of the API deal solely with transient information (Presence, Activities, Chat, etc), and thus accompany this usage pattern very well. 

In this model, the workflow could look something like this:

1. User enters a "room" for collaboration.
1. User retrieves a piece of data from the application server and creates a Convergence `RealTimeModel` with the JSON data as its content.
1. User starts editing the underlying data in the `RealTimeModel` by way of the application UI.
1. Another user enters the collaboration room, and requests the piece of data from Convergence rather than the application server.  
1. Both users' apps listen for "change" events at a very granular level. When remote change events are emitted from the Convergence API, the app updates the visual aspect of the UI tied to a particular part of the JSON subtree that was changed (within the `RealTimeModel`).
1. Both users work on the same data model in this manner.  All changes are made to the `RealTimeModel` and automatically propagated to any interested connected users.
1. To persist the `RealTimeModel`'s data back to the application server, the application could either provide a "Save" button or automatically push the model's contents right before the last user leaves the collaboration room.

# Designing real-time co-editing-enabled applications

When real-time co-editing functionality is desired, many of the typical application design patterns developers have relied on over the years can become problematic.  For instance, most modern web-based applications keep a user's working state in the browser and only periodically push changes to a server.  But when multiple users are modifying data at the same time, this pattern no longer works.

There are a variety of algorithms to accomplish this real-time data synchronization (which have been thoroughly covered elsewhere), but the common thread is a promise of  _eventual consistency_.  That is, _eventually_ all users' states will resolve equivalently.  Even if Joe gets disconnected for a few seconds, on reconnecting all data will be synced (generally, the longer the disconnection, the more difficult it is to do meaningful automatic conflict resolution).  This is a very powerful means of abstracting per-user latency.

Convergence uses an intermediary server to perform this synchronization.  This effectively means that the server is ultimately the "source of truth" for any data going through it.  In typical scenarios, though, all clients (users) will also have the same state within milliseconds.

## Software design patterns/libraries to avoid

The loss of the browser as the single source of truth means that *libraries such as [Redux](https://redux.js.org/) are no longer a good fit*.  Redux was designed to encapsulate all states, but when state changes can come from external sources, it loses much of its value (the Flux pattern does still work well, however).  For example, features such as state playback and history within Redux developer tools will not perform like a developer is accustomed to. With Convergence, the state is lifted out of the browser to the server.  

# Data Model Design

For any non-trivial application, state management is a critical concern.  Convergence thus provides a flexible construct for organizing data: [Real Time Models](/models/overview.html) are essentially distributed data structures for use during a collaboration session.  Anything you can store in JSON you can share in Convergence, with guaranteed conflict resolution on any possible combination of mutations within the tree (typically consisting of nested objects, arrays, and common primitives).  

As when using a relational or object database, getting the data design right for your particular application is critical. The relations between discrete pieces of data are of special importance.  When doing this design work, we can offer a few bits of wisdom:

1. Every single change to a data model is recorded in Convergence.  For instance, if your application is listening for key events in a `<textarea>` and updating a `RealTimeString` (within a larger `RealTimeModel`) on each keystroke, there will be a distinct event saved in Convergence for each character added or deleted.  Generally, this level of granularity is beneficial for both keeping any connected users up to date on what's changing AND allowing for very precise undo and history playback capabilities.
1. Thus, in most applications it is desirable to encapsulate only one application entity within a single data model.  This allows for a cleaner history of changes and makes features like undo and historical playback much easier. 
1. Automatic data synchronization is only possible _within_ a single data model.  So tightly coupled application data should generally co-exist in the same `RealTimeModel`.
1. There is currently no concept of foreign keys linking different `RealTimeModel`s.  Typically, consumers will use GUIDs for model IDs and just add a key-value pair somewhere within the JSON tree whose value is the `RealTimeModel` ID of the related model.

See the [Real Time Models](/models/overview.md) page for additional information.

# What will your integration look like?

Every integration of Convergence will be a bit different, yet there's a good chance we have (or another developer has) contemplated something similar to your use case.  Thus: 

* Please direct technical questions to our [Forum](https://forum.convergence.io) so other developers can benefit.  We monitor it regularly.
* For more urgent questions, click the "Feedback" button in the lower right of this page. This is a direct line to Convergence's founding team.
