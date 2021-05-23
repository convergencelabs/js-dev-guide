# Historical Models

Convergence keeps track of all changes to the data made by all users over time.  Historical models can be used to explore the model's history and to see how the data has changed over time. This can be useful for problem solving, auditing, or recovering deleted data. A historical model can be obtained from the [ModelService](model-service.md) using the `history()` method.


```js
const model = modelService.history("modelId");
```

The historical model has roughly the same API as the real time model, except without any of the methods that mutate the data.  The model is essentially read only.

# Metadata
Like the real time model

```js
const model = modelService.history("modelId");

// The collection id of the model.
model.collectionId();

// The model id of the model.
model.modelId();

// Get the version the model is currently at
model.version();

// The time of the last operation that resulted in this version
model.time();

// Gets minimum avialable version for this model
model.minVersion();

// Gets the maximum version of the model when it was opened
model.maxVersion();

// Gets minimum avialable time for this model
model.minTime();

// Gets the maximum time of the model when it was opened
model.maxTime();
```

# Playback

The historical model can move from its current version to any other version.  During this concept of "playback", at each step it will emit an event representing the operation performed at that point in the model's history.  This is just like the `RealTimeModel` does when "live" remote operations arrive -- the events are identical, and your application probably already has the logic to handle them.  Each operation is emitted in sequence.

```js
const model = modelService.history("modelId");

// playTo version 10
model.playTo(10);

// play forward one version
model.forward();

// play forward five versions
model.forward(5);

// play backward one version
model.backward();

// play backward five versions
model.backward(5);
```
