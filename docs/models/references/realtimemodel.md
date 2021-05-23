# Real Time Model References

References can also be set at the model level to simply manage and publish a set of elements. 
// TODO provide better example


# Element References
An element reference represents one or more elements in the model that must be adjusted while the data is changing. If an element in a reference is detached from the model, it will be removed from the reference.

```js
const selected = model.elementReference("selected");

const element1 = model.elementAt("e1");
const element2 = model.elementAt("e2");

// set a single value
selected.set(element1);
// get a single value
console.log(selected.value().path()); // e1

// set multiple values
selected.set([element1, element2]);
// get multiple values
console.log(selected.values().map((e) => {return e.path();})); // ["e1", "e2"]

selected.share();
```
