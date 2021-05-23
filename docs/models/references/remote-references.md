# Remote Reference Lifecycle

Remote references also have a similar lifecycle, the main difference being that you are on the receiving end rather than the sending end.  With remote references you also need to be notified when a new incoming reference is created. This happens when another remote session publishes a reference. In your application you will know where you are making use of local references to share information. At these locations in the model you will want listen for remote reference events. This is covered later in the guide. The lifecycle events for a remote reference are:

1. Set
1. Cleared
1. Disposed

The main difference here is that remote references do not distinguish between references that exist but are not shared. If a session creates a local reference but does not publish it, a remote session will never see that event. Likewise it is not necesssary to know if a reference was unpublished versus disposed. It is only necessary to know that it is not being shared at the moment.

## Example Data model

The rest of this page will use the following data model as an example.  The data model is a simple plain text document stored in the `textField` property of the root object.

```js
{
 textField: "A plain text document"
}

```

## Getting Remote References

When the model is first opened, existing remote references are immediately discoverable. You can either ask the `RealTimeModel` or any child `RealTimeElement` for the references using the `references()` method. This method will return all references for the element.  There is also a variation that allows you to ask for specific references. If you want to look up a specific reference based on a sessionId and reference key, there is also the `reference(sessionId, key)` method. Some examples:

```js
const textField = model.root().get("textField");

// The following three methods return an array of references.

// Get all references
const allRefs = textField.references();

// Get only cursor references
const allCursors = textField.references({key: "cursor"});

// Get all references for a particular session
const session1 = textField.references({sessionId: "1"});

// Getting a single reference by sessionId and key
const session1Cursor = textField.reference("1", "cursor");
```

### "Local" Remote References
Users should be aware that when asking for references, any local references will also be included in the array.  You can tell which references are you own local references by using the `isLocal()` method on the `ModelReference` object.

```js
const sessionId = model.session().sessionId()
// This is just one type of reference you can create on a `RealTimeString`
const localReference = textField.indexReference("cursor");
const ref = textField.reference(sessionId, "cursor");

console.log(ref.isLocal()); // true
```

## Listening to Remote References

Once you have a reference in hand you can listen to the various events they support. An example is below. For simplicity, the example assumes that we are only sharing a single reference type called "cursor".

```js
const textField = model.root().get("textField");

function handleReference(ref) {
  ref.on("set", (e) => {
    const ref = e.reference;
    console.log(`Cursor set for sessionId '${ref.sessionId()}': ${ref.value()}`);
  });
  ref.on("cleared", (e) => {
    const ref = e.reference;
    console.log(`Cursor cleared for sessionId '${ref.sessionId()}'.`);
  });
  ref.on("disposed", (e) => {
    const ref = e.reference;
    console.log(`Cursor disposed for sessionId '${ref.sessionId()}'.`);
  });
}

textField.references().forEach((ref) => {
  handleReference(ref);
});
```

## Listening for new References
You must also be able to listen for new references being published by new remote clients.  Each element (and the model) that support references will fire a "reference" event when a new reference is first published.

```js
const textField = model.root().get("textField");
textField.on("reference", (ref) => {
  handleReference(ref);
});
```





