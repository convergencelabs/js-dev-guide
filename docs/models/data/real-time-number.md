# RealTimeNumber

RealTimeNumbers are similar to Javascript numbers.  They are a simple data type representing a numeric value:

```js
42
10.5
```

The methods of the `RealTimeNumber` simply set the numeric value of the element. For the following examples assume the data model looks like the following:

```js
{
  count: 42
}
```

## Getting the Number's Value

The number's value can be obtained using the zero argument `value()` method.

```js
const num = root.get("count");
console.log(num.value()); // 42
```

## Setting the Number's Value

The numeric value can be set using the single argument `value(number)` method. Once called, the number will be equal to the value specified.

```js
const num = root.get("count");
num.value(44);
console.log(num.value()); // 44
```


## Other Methods

See the API documentation for full details of the methods of the `RealTimeNumber`.

| Method | Description |
| --- | --- |
| add\(num\) | Adds the specified number to this number. |
| subtract\(num\) | Subtracts the specified number from this number. |
| increment\(\) | Increments the value of this number by one. |
| decrement\(\) | Decrements the value of this number by one. |

## Events

See the API documentation for more details of the `RealTimeNumber` events.

| Event | Description |
| --- | --- |
| "delta" | Emitted when the value of the number is increased or decreased, probably by one of the four methods above. |
| "value" | Emitted when the number's value is set. |
| "detached" | Emitted when the element is detached from the model. |
