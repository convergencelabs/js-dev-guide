# RealTimeObject

RealTimeObjects are much like regular objects in Javascript.  They are key-value pairs where the keys are strings. A visual representation of the data might look something like this:

```JavaScript
{
  "key1": "value",
  "key2": false
}
```

The main interactions with the `RealTimeObject` center around getting and setting data by their named keys.

## Getting the Object's Value

The entire object can be retrieved as a Javascript Object using the zero argument `value()` method.

```JavaScript
const jsonObject = realTimeObj.value();
```

## Setting the Object's Value

The entire object can be set at once using the single argument `value(object)` method.  The value method takes a Javascript Object, disposes of all current key-value pairs currently in the object, and replaces them with the key-value pairs in the passed-in parameter.

```JavaScript
realTimeObj.value({newKey: "newValue"});
JSON.stringify(realTimeObj.value()); // {"newKey": "newValue"}
```

## Getting a Value at a Key

Values can be accessed in the object via their key using the `get(key)` method.  The get method takes the key of the value and will return the `RealTimeElement` at that key.

```JavaScript
const myValue = realTimeObj.get("key1");
```

## Setting a Value at a Key

You can set the value of an existing or new key in the object via the `set(key, value)` method. If a value already exists with the supplied key it will be overwritten, otherwise a new key-value pair will be added to the object. The newly created `RealTimeElement` will be returned from the `set` method.

```JavaScript
const newValue = realTimeObj.set("newKey", 5);
console.log(newValue.value()) // 5
```

## Removing a Value at a Key

Values can be removed from the object using the `remove(key)` method.  The `remove` method takes the key of the value to remove, removes that value from the object and returns the RealTimeValue that was removed.

```JavaScript
const myValue = realTimeObj.remove("key1");
```


## Other Common Methods

See the API documentation for a full specification of the `RealTimeObject`.

| Method | Description |
| --- | --- |
| forEach\(callback\) | Executes the supplied callback for each key-value pair in the object. |
| keys\(\) | Returns all the keys currently set in the object. |
| hasKey\(key\) | Returns true if there is a value set at the specified key. |

## Events

See the API documentation for a full specification of the `RealTimeObject` events.

| Event | Description |
| --- | --- |
| "set" | Emitted when a value is set in the `RealTimeObject`. |
| "remove" | Emitted when a value is removed from the `RealTimeObject`. |
| "value" | Emitted when the entire `RealTimeObject` is set. |
| "detached" | Emitted when the element is detached from the model. |
