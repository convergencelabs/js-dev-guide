# Local References

Local references have a lifecycle within the model that control how and when information is shared.  The main steps in the lifecycle include:

1. Create
2. Set
3. Share
4. Clear
5. Unshare
6. Dispose

To illustrate this, see the example below using an `IndexReference` in a `RealTimeString`.  We will explain these concepts in more detail later.

```js
const textElement = model.root().get("text");

// Create the reference
const localCursor = model.indexReference("cursor");

// Set the initial cursor location, not shared yet
localCursor.set(24); 

// Share the cursor, now shared.
localCursor.share();

// Clear the cursor.  You could call this when the editor loses focus.
// Other users still know you have a cursor, it's just that it now 
// has no value.  They could then, for example, remove your cursor from 
// the editor UI.
localCursor.clear();

// Set the cursor again
localCursor.set(18);

// Unshare the cursor, no longer shared.
localCusror.unshare();

// Dispose of the local reference when you no longer
// need it.
localCursor.dispose();
```

Between when the reference is created and disposed, it can be shared, unshared, set and cleared multiple times.  There is a distinct difference between set / clear and share / unshare.  Set and clear control whether the reference currently has a value.  Share and unshare determine whether you intend to share a reference (regardless of its value) with other users.  For example, if I have a document open, I always intend to share my cursor, so it is always shared.  My cursor may not have a value (e.g. be cleared) if my editor loses focus.

# Getting Existing Local References

An existing local reference can be retrieved simply by calling the same method that was used to create it.  For example:

```js
const rtString = model.root().get("text");

// Create the reference for the first time
const localCursor = model.indexReference("cursor");

// Gets the existing reference.
const localCursor2 = model.indexReference("cursor");

console.log(localCursor === localCursor2); // true
```