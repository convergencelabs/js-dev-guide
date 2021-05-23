# RealTimeDate

RealTimeDates are similar to JavaScript Dates.  They are a simple data type representing a Date value:

```js
new Date();
new Date("2017-03-15T23:35:34.915Z");
```

The methods of the `RealTimeDate` simply set the Date value of the element. For the following examples, assume the data model looks like the following:

```js
{
  time: new Date("2017-03-15T23:35:34.915Z")
}
```

## Getting the Date's Value

The dates's value can be obtained using the zero argument `value()` method.

```js
const date = root.get("time");
console.log(date.value()); // Wed Mar 15 2017 23:35:34 GMT-0000 (GMT)
```

## Setting the Date's Value

The Date value can be set using the single argument `value(Date)` method. Once called, the Date will be equal to the value specified.

```js
const time = root.get("time");
time.value(new Date("2017-04-16T23:35:34.915Z"));
console.log(time.value()); // Wed Apr 16 2017 23:35:34 GMT-0000 (GMT)
```

## Events

See the API documentation for more details of the `RealTimeDate` methods and events.

| Event | Description |
| --- | --- |
| "value" | Emitted when the Dates's value is set. |
| "detached" | Emitted when the element is detached from the model. |
