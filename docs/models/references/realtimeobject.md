# Real Time Object References

References within RealTimeObjects are focused on maintaining a list of properties in the object consistent with the data model as it changes.

# Property References
An property reference represents one or more properties in the object that must be adjusted while the data is changing.  For example, imagine a diagram editor app where there are a few shapes on the canvas.  Communicating the selection of such a shape would be important, and it falls in the realm of transient data, so it would make sense to track using a reference.  

In the example, each shape may be an object within a "shapes" object, whose key is an unique ID.

```js
const rtShapes = model.elementAt("shapes");
const selectedRef = rtShapes.propertyReference("selected");

// add a selected shape
selectionRef.value("circle1");
selectionRef.share();
```

Listen to remote selections:
```js
const rtShapes = model.elementAt("shapes");
const selectionRefs = rtShapes.references({key: "selected"});
if(selectionRefs.length > 0) {
  selectionRefs[0].on("set", (e) => {
    console.log('Selected shapes': e.values());
  });
}
```
