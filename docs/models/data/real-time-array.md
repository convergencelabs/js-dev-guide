# RealTimeArray

RealTimeArrays are similar to a Javascript Array.  They are positionally indexed, ordered collections of RealTimeElements. A visual representation of the data might look something like this:

```js
["string", 1, false, null]
```

The main interactions with the `RealTimeArray` are centered around adding, removing, and setting values at specific indices within the array. As expected, indices in the array are zero-based.

## Setting the Array's Value

The entire array can be set at once using the single-argument `value(array)` method. This takes a Javascript array, disposes of all current elements, and replaces them with the supplied ordered collection of values.

```js
realTimeArray.value(["new", "values"]);
```

## Getting the Array's Value

The array's value can be retrieved as a Javascript Array using the no-argument `value()` method.

```js
const jsonArray = realTimeArray.value();
```

## Inserting a Value

To insert a value into the array at a specific position, use the `insert(index, value)` method.  This will insert a new value into the array at the specified index. After the insert, the newly created `RealTimeElement` will occupy the specified index. All other elements after the specified index in the array will be shifted to the right.

```js
const insertedValue = realTimeArray.insert(0, "some value");
```

## Setting a Value

To change an existing value at a specific position in the array, use the `set(index, value)` method.  The array must be of sufficient length such that the index points to an existing location.

```js
realTimeArray.set(2, "new value");
```

## Removing a Value

To remove an existing element from the array at a specific position, use the `remove(index)` method.  Removing a value will cause all elements in the array after the specified index to shift to the left.

```js
realTimeArray.remove(2); 
```

## Moving a Value

It is possible to move an existing element in the array to a new position using the `reorder(from, to)` method. After the move is complete, the element originally at the `from` index will now reside at the `to` index.  Other elements in the array will shift as needed.

```js
realTimeArray.reorder(2, 5);
```

## Other Methods

See the [API documentation](https://docs.convergence.io/js-api/classes/real_time_data.realtimearray.html) for full details of the methods of the `RealTimeArray`.

| Method | Description |
| --- | --- |
| length\(\) | Returns the current length of the array. |
| push\(value\) | Adds a new value to the end of the array. |
| pop\(\) | Removes and returns the last element in the array. |
| unshift\(value\) | Adds a new value to the beginning of the array. |
| shift\(\) | Removes and returns the first element in the array. |
| some\(callback\) | Calls the supplied callback with each element in the array and returns true if the callback returns true for at least one element. |
| every\(callback\) | Calls the supplied callback with each element in the array and returns true if the callback returns true for all elements. |
| find\(callback\) | Calls the supplied callback with each element in the array and returns the first element for which the callback returns true. |
| findIndex\(callback\) | Calls the supplied callback with each element in the array and returns the index of the first element for which the callback returns true. |
| forEach\(callback\) | Calls the supplied callback with each element in the array. |
| elementAt\(path\) | Returns the element in the model corresponding to the relative path supplied. |

## Events

See the [API documentation](https://docs.convergence.io/js-api/interfaces/real_time_data.realtimearrayevents.html) for full details of the `RealTimeArray` events.

| Event | Description |
| --- | --- |
| "insert" | Emitted when a new element is inserted into the array. |
| "remove" | Emitted when an existing element is removed from the array. |
| "set" | Emitted when an existing element is replaced in the array. |
| "reorder" | Emitted when an existing element is reordered within the array. |
| "value" | Emitted when the entire array's value is set. |
| "detached" | Emitted when the array is detached from the model. |
