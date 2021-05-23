# Real Time String References

References in RealTimeStrings are focused on keeping indices up to date as the model changes, both locally and remotely.  The `RealTimeString` supports two types of references: 

* Index Reference
* Range Reference

Both of these references are "multi-valued" meaning that they actually can contain sets of indices or ranges. It should be noted that indices within the string do not point to specific characters in the string, but rather to positions 'between' the characters.  When you insert a character in a string at an index, you are not replacing the current character at an index, but rather are inserting a character just before the existing character.  This is very compatible with the idea of a cursor.  In a text document the cursor lives "in between" the characters.

```js
       
 012345 678910
"Conver|gence"
       ^-cursor
```

Here we would say the cursor is at index 6.  The next character to be typed would now occupy position 6.  If the 'C' were deleted all elements would shift to the left one index.  The cursor would still be between the 'r' and 'g' but would now be at index 5.

# Index References
An `IndexReference` represents one or more indices in the string that must be adjusted while the data is changing.

```js
const textField = model.elementAt("textField");
const cursor = textField.indexReference("cursor");

// set a single value
cursor.value(4);

// get a single value
console.log(cursor.value()); // 4

// set multiple values
cursor.values([4, 10]);

// get multiple values
console.log(cursor.values()); // [4, 10]

cursor.share(); // Others are now aware of these two references
```

# Range References

A range is essentially two indices that together specify a range in the string.  Indices are represented by plain Javascript objects of the shape:

```js
{
  start: 10
  end: 45
}
```
A common use case for ranges are representing selections within the string. Examples of using a `RangeReference` are below:

```js
const textField = model.elementAt("textField");
const selection = textField.rangeReference("selection");

// set a single value (which is a pair of indices)
selection.value({start: 5, end: 30});

// get a single value
console.log(selection.value()); // {start: 5, end: 30}

// set multiple values
selection.values([{start: 4, end: 10}, {start: 40, end: 45}]);

// get multiple values
console.log(selection.values()); // You know the drill

selection.share();
```




