# RealTimeBoolean

RealTimeBooleans are similar to JavaScript booleans.  They are a simple data type representing a boolean value:

```js
false
true
```

The methods of the `RealTimeBoolean` simply set the boolean value of the element. For the following examples, assume the data model looks like the following:

```json
{
  "isActive": true
}
```

## Getting the Boolean's Value

The booleans's value can be obtained using the zero argument `value()` method.

```js
const bool = root.get("isActive");
console.log(bool.value()); // true
```

## Setting the Boolean's Value

The boolean value can be set using the single argument `value(boolean)` method. Once called, the boolean will be equal to the value specified.

```js
const bool = root.get("isActive");
bool.value(false);
console.log(bool.value()); // false
```

## Events

See the API documentation for more details of the `RealTimeBoolean` methods and events.

| Event | Description |
| --- | --- |
| "value" | Emitted when the booleans's value is set. |
| "detached" | Emitted when the element is detached from the model. |
