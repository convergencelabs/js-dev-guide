# RealTimeString

RealTimeStrings are similar to Javascript strings.  A string is an ordered collection of characters, where each character can be identified by a zero-based index:

```js
String: "Foo Bar"
Indices: 0123456
```

The main interactions with the `RealTimeString` are inserting and removing individual characters or groups of characters at specific indices. For the following examples, assume that the data model looks like the following:

```js
{
  message: "Hello World"
}
```

## Getting the String's Value

The string's value can be obtained using the zero-argument `value()` method.

```js
const message = root.get("message");
console.log(message.value()); // Hello World
```

## Setting the String's Value

The entire string can be set at once using the single argument `value(string)` method. Once called, the string will be equal to the value specified.

```js
const message = root.get("message");
message.value("New Value");
console.log(message.value()); // New Value
```

## Inserting into a String

To insert characters into a string, use the `insert(index, value)` method.  This will insert the specified string at the specified location.

```js
const message = root.get("message");
message.insert(0, "Why ");
message.insert(15, "!");
console.log(message.value()); // Why Hello World!
```

## Removing from a String

To remove existing characters from a string, use the `remove(index, length)` method.  This will remove the specified number of characters from the string, starting from the specified index.

```js
const message = root.get("message");
message.remove(5, 1);
console.log(message.value()); // HelloWorld
```

## Replacing characters in a String

To replace existing characters within a string in an atomic action, use the `splice(index, deleteCount, insertValue)` method.  This will remove the specified number of characters from the string, starting from the specified index, and then insert the specified value at that same index.

```js
const message = root.get("message");
message.splice(6, 5, "Everyone!");
console.log(message.value()); // Hello Everyone!
```

## Other Methods

See the API documentation for full details of the methods of the `RealTimeString`.

| Method | Description |
| --- | --- |
| length\(\) | Returns the current length of the string. |

## Events

See the API documentation for full details of the methods of the RealTimeString.

| Event | Description |
| --- | --- |
| "insert" | Emitted when characters are inserted into the string. |
| "remove" | Emitted when characters are removed from the string. |
| "splice" | Emitted when characters are replaced within the string. |
| "value" | Emitted when the entire string's value is set. |
| "detached" | Emitted when the element is detached from the model. |
