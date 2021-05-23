# Real Time Elements

Each piece of data in a RealTimeModel is represented by a `RealTimeElement`. Convergence provides enhanced versions of the most common JavaScript data types. These provide an intuitive interface for real-time collaborative editing.  Mutations to the data are applied locally, immediately and synchronously.  Those changes are then distributed to other users asynchronously.  Similarly, the local data types will receive and process mutations from other users in the system and notify the local consumer of those changes. 

All data types inherit from the `RealTimeElement` class. The currently supported data types are:

* **[RealTimeObject](../real-time-object/)**
* **[RealTimeArray](../real-time-array/)**
* **[RealTimeNumber](../real-time-number/)**
* **[RealTimeString](../real-time-string/)**
* **[RealTimeBoolean](../real-time-boolean/)**
* **[RealTimeDate](../real-time-date/)**
* **[RealTimeNull](../real-time-null/)**
* **[RealTimeUndefined](../real-time-undefined/)**

All Real Time data types share several common concepts and API methods -- let's discuss the most important ones:

## Type Identifiers

Each element is aware of what type of data it represents.  For convenience, each `RealTimeElement` has a `type()` method which will return a string value indicating what time of data it represents. These are:

| Element | Type String |
| --- | --- |
| RealTimeArray | "array" |
| RealTimeBoolean | "boolean" |
| RealTimeDate | "date" |
| RealTimeNumber | "number" |
| RealTimeNull | "null" |
| RealTimeObject | "object" |
| RealTimeString | "string" |
| RealTimeUndefined | "undefined" |

## Path

As [previously discussed](../../overview/#paths), at any given time each data element exists at a certain place in the model.  The location of the element within the model is called the **path**.  The current path of an element can be obtained by using the `path()` method.  Conversely, this path can be passed to the `elementAt` method in the `RealTimeModel` class to get the element.

```JavaScript
const realTimeString = model.root().get("email")
const path = realTimeString.path();
realTimeString === model.elementAt(path);
```

## Element Id

Every data element within a model has an id that uniquely identifies it from all other elements in that model. The id of an element can be obtained using the `id()` method. Elements can also be looked up by their element id directly from the RealTimeModel object.

```JavaScript
const elementId = model.elementAt("emails", 0).id();
const element = model.element(elementId);
```

## Getting and Setting Values

While working with the model, data is represented by a tree of RealTimeElements. However, external toolkits will want to interact with plain javascript values. For example, when setting the value of a text input field, a raw string value will be needed rather than the `RealTimeString`. Likewise, the result of collecting data from a user might be a raw boolean, which needs to be set as the value of a `RealTimeBoolean`.

To get the raw value of a `RealTimeElement` use the `value()` method:

```JavaScript
const rtFirstName = model.elementAt("firstName");
const firstName = firstName.value();
console.log(firstName === 'jim'); // true
```

The `value()` method will always return the _current_ value of the element at the time it was called.  This value will be static and not updated further.

Most RealTimeElements have methods that allow granular manipulation of their data (see the documentation for each data type for specifics).  In some cases it may be desirable to simply set the entire value. The `value(val)` method can be used for this purpose on *any* `RealTimeElement`. The value provided must match the type of `RealTimeElement` \(e.g. a string for RealTimeString, etc\).

```JavaScript
const rtFirstName = model.elementAt("firstName");
rtFirstName.value("Bob");

console.log('Bob' === rtFirstName.value()); // true
```

## Attached vs Detached

During the time that a `RealTimeElement` is active and part of a model, it is said to be "**attached**".  When a model is first loaded, all elements are in the attached state.  However, when a value is removed from the model it becomes **detached**.  There are several ways an element can be removed from the model.  A common way is if the element is contained in a RealTimeObject or RealTimeArray and is removed via an API call.  For example:

```js
const root = model.root();
const firstName = root.get("firstName");
console.log(firstName.isAttached()); // prints: true

root.remove("firstName");
console.log(firstName.isAttached()); // prints: false
console.log(firstName.isDetached()); // prints: true
```

An element that becomes detached is no longer synchronized with the server and other clients editing the model.  If you try to call methods that mutate the element once it becomes detached, the API will throw an error.  However, you can still use the `value()` method to access the value of the data at the time it was detached.

## Setting Data: Replacement vs. In-Place 

When wanting to set the entire value of an element, the user often has two options:  Setting the value of the RealTimeElement directly or setting the value from its parent.  Consider the following data model:

```json
{
  "firstName": "Bob"
}
```

The root of the model is, as always, an instance of `RealTimeObject`.  It has one key, "firstName", that points to a `RealTimeString` that contains the value "Bob".  The main difference between the two options is that if you set the value from the element itself, the element will remain attached.  If you set the value from its parent, the existing value will be detatched and replaced by an entirely new element.  To illustrate the difference in options:

### 1. In-Place Set

An in-place set occurs *AT* the element you are trying to set the value of and uses the `value()` method:

```js
const root = model.root();
const firstName = root.get("firstName");
console.log(firstName.value()); // Bob
console.log(firstName.id()); // 1:fjr

firstName.value("Robert");
console.log(firstName.isAttached()); // true
console.log(firstName.value()); // Robert
console.log(root.get("firstName").id()); // 1:fjr
```

As you can see, the element is still attached.  It is still present at the "firstName" key of the models' root object and has the same `id`.

### 2. Replacement Set

A "replacement set" occurs at the parent of the element which contains the value you are trying to set the value of:

```js
const root = model.root();
const firstName = root.get("firstName");
console.log(firstName.value());      // Bob
console.log(firstName.id());         // 1:frj

root.set("firstName", "Robert");
console.log(firstName.isAttached()); // false
console.log(firstName.value());      // "Bob"

const newFirstName = root.get("firstName");
console.log(newFirstName.value());   // Robert
console.log(newFirstName.id());      // 1:aui
```

As you can see, the original `RealTimeString` element that held the first name has been detached and an entirely new `RealTimeString` has been created and set within the root object at the `firstName` key.  While in this example we set the `firstName` to 'Robert' which maintained a `RealTimeString` at that key, we could have just as easily set `firstName` to the boolean value `true`.  In that case, the new value at `firstName` would not even be a `RealTimeString` anymore; it would be a `RealTimeBoolean`.  "replace" method like set, must remove the original value from the model and replace it with a new one.

### Implications

There are two implications to a replacement set:

1. Any listeners on the original value will not be attached to the new value.  Therefore, if listeners are still needed at that point in the model, they must be reattached to the new element in the model.
2. An entirely new RealTimeElement needs to be created.  This requires the generation of a new element Id and serializing the new value to the server and each other connected client.  This is less efficient than an in-place set.

Therefore, the in-place set should be preferred where possible. In general:


> Edit data at the most precise point in the model, using the most granular method available. It is more efficient with fewer potential "gotchas."


## Common Methods

See the API documentation for full details of the methods of the `RealTimeElement`.

| Method | Description |
| --- | --- |
| model\(\) | Gets the model the element belongs to. |
| id\(\) | Gets the unique (within the model) element id. |
| path\(\) | Gets the current location in the model. |
| parent\(\) | Get the parent model element. Will be null for the root object. |
| isAttached\(\) | Returns true if the model element is attached to the model. |
| isDetached\(\) | Returns true if the model element is not attached to the model. |
| toJSON\(\) | Gets a pure JSON representation of the model element. |
| value\(\) | Gets the JavaScript value of the model element. |
