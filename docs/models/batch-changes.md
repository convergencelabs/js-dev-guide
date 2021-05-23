# Batch Changes

Normally, changes made to a `RealTimeModel` are individually sent to the server immediately once executed via the API. However, in certain cases it may be necessary to group multiple discrete changes together into an atomic unit that is sent to the server all at the same time, like a database transaction.  For example, the semantics of your application data model may require changes to two different parts of the model at the same time to maintain integrity.  In this case, the changes need to all be executed atomicly to maintain integrity.  The `RealTimeModel` class provides several methods for this.

```js
const root = model.root();

model.startBatch();
root.set("firstName", "John");
root.set("lastName", "Doe");
model.completeBatch();
```

When `startBatch()` is called, subsequent model changes will be queued.  When `completeBatch()` is called, all pending changes will be sent. Note that only one batch can be in progress at one time. You can determine if a batch is in progress by calling `RealTimeModel.isBatchStarted()`.

```js
const root = model.root();

console.log(model.isBatchStarted()); // false
model.startBatch();
console.log(model.isBatchStarted()); // true
// perform some mutations
model.completeBatch();
console.log(model.isBatchStarted()); // false
```

Since the batch is intended to be an atomic set, all calls including `startBatch()`, `completeBatch()`, and every mutation in between *must happen in the same execution loop* (or thread) such that no other incoming events can be interleaved.

After calling `startBatch()` you must perform at least on mutation before calling `completeBatch()`. If you call `completeBatch()` without performing data mutation an Error will be thrown. Instead you can call `cancelBatch()` to signify that you no longer wish to perform a batch operation. However, once you issue an operation after calling `startBatch()`, the batch can not be canceled. If you wish to know how many mutations are currently queued in the batch you can call the `batchSize()` method.
