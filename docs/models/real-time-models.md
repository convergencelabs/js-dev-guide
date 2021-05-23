# Real Time Models
The result of the ModelService.open(...) method is a Promise that resolves to a `RealTimeModel` object.  This is the main entry point for working with the model.  The `RealTimeModel` contains all of the data and metadata associated with the model.  As models are changed over time, every individual mutation to the model is tracked.  Every model has a version that starts at zero and is incremented each time a mutation occurs.  Therefore, every state that the model moved through can be referenced by a version number.

## Metadata
The main metadata methods for the model are:

```js
// Returns the collection the model belongs to.
var collectionId = model.collectionId();

// Returns the unique model id within the collection.
var modelId = model.modelId();

// Returns the current version of the model.
var version = model.version();

// Returns the most recent time the model was modified.
var modifiedTime = model.time();

// Returns the time when the model was first created.
var createdTime = model.createdTime();
```

## Model Data
The data in the model is represented by an object tree much like a JSON object.  All of the values in the model are subclasses of the [RealTimeElement](/models/data/real-time-elements.md) class.  Each subclass corresponds to one of the supported data types.  These include:

* **[RealTimeObject](/models/data/real-time-object.md)**
* **[RealTimeArray](/models/data/real-time-array.md)**
* **[RealTimeNumber](/models/data/real-time-number.md)**
* **[RealTimeString](/models/data/real-time-string.md)**
* **[RealTimeBoolean](/models/data/real-time-boolean.md)**
* **[RealTimeDate](/models/data/real-time-date.md)**
* **[RealTimeNull](/models/data/real-time-null.md)**
* **[RealTimeUndefined](/models/data/real-time-undefined.md)**

Each of these types have various methods for accessing and manipulating data. The root of every model is *always* a `RealTimeObject`.  This can be obtained as follows:

```JavaScript
var rootObject = model.root();
```

Depending on the structure of your data you may also wish to directly access data that is nested more deeply in the object structure.  To do this you can use the [model path](/models/overview.html#paths) to directly access a nested element:

```js
var childObject = model.elementAt("emails", 0);
```

The `elementAt()` method will return the element at the specified path, or a `RealTimeUndefined` object if no such element exists. 

Each element also has a unique id within the model.  An element can be accessed directly by its id (without using the path) using the `element(id)` method.

```js
const elementId = model.elementAt("emails", 0).id();
// later
const element = model.element(elementId);
```

## Closing

When you are done working with a model, you must call the close method to release the resources and to stop being notified of changes to the model.  You can also tell if the model has already been closed with the `isOpen()` method.

```JavaScript
model.close().then(() => {
  console.log(isOpen()); // false
});
```

## Collaborators

You can determine which other user sessions have a model open as follows:

```JavaScript
model.collaborators();
```


## Events

See the API documentation for full details of the methods of the RealTimeModel.

| Event | Description |
| --- | --- |
| "closed" | Emitted this model is closed. |
| "delete" | Emitted the model is deleted while open. |
| "modified" | Emitted when the local client has uncommitted changes. |
| "committed" | Emitted when all local changes are committed at the server. |
| "version_changed" | Emitted when the version of the model is changed. |
| "collaborator_opened" | Emitted when a remote collaborator opens the model. |
| "collaborator_closed" | Emitted when a remote collaborator closes the model. |
| "reference" | Emitted when a new element reference is shared. |

