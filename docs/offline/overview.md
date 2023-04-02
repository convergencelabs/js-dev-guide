# Offline

_**Warning**: Offline support is experimental, may change, and has several limitations.  See the limitations section below._

Convergence is first and foremost a realtime collaboration system meant to be connected. However, occasionally a user may be temporarily disconnected due to network connectivity issues, or because they simply want to be offline. Convergence aims to continue to function in these situations. 

At the moment the primary focus of the offline support is the Real Time Data subsystem.  Features:

* Changes to models will be stored offline until they have been acknowledged by the server.
* The user can [subscribe](https://api-docs.convergence.io/classes/real_time_data.modelservice.html#subscribeoffline) to models to have them proactively downloaded to the local client to ensure they are available in case the user goes offline.
* Models can be created, modified, and deleted offline.
* The client will push changes made offline up to the server when connectivity is restored.


# Storage Adapters
Convergence has a persistence abstraction layer that allows the user to configure how offline data is stored. At the moment Convergence only provides a single Storage Adapter that uses [IndexedDB](https://developer.mozilla.org/en-US/docs/Web/API/IndexedDB_API) to store offline data.

# Configuration and Initialization
To configure Convergence for offline support you need to provide a storage adapter in the [options](https://api-docs.convergence.io/interfaces/connection_and_authentication.iconvergenceoptions.html) passed to the ConvergenceDomain.

```typescript
const URL = "https://myhost/namespace/domain";

const options = {
  offline: {
    storage: new IdbStorageAdapter()
  }
};

const domain = new ConvergenceDomain(URL, options);
```

A properly configured domain needs to be initialized for offline support. If this is the case, when the ConvergenceDomain connects offline support is automatically initialized. If you wish to start using the ConvergenceDomain offline without connecting you must call the `initializeOffline()` method.

```typescript
domain.initializeOffline("username");
```

# Limitations

* The same user can not have the same domain open in multiple browser tabs with offline support enabled. Both tabs will attempt to use the same IndexedDB database and will conflict with each other.
* The API of the offline storage system is not yet stable and may change.
* Large numbers of offline models with changes may consume a large amount of memory upon reconnection until all changes are synchronized.
* The chat, activity, and identity APIs do not have offline support.

