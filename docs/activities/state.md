# Activity State

Participants of an activity may want to share state information with other participants.  This state information could help raise awareness of what the local user is doing in the activity and to help coordinate actions. State is shared in a unidirectional fashion.  Each session has its own state in the activity. That state can be published to other sessions in the system, but a session can not modify the state of another session.

**Note:** Multiple sessions always have distinct state within an activity even if those sessions belonging to the same user.

Activity state is simply a key-value pair where the keys are strings and the values are any plain Javascript object.  It might be visualized as such:

```json
{
  "openFiles": ["file1", "file2"],
  "available": true,
  "activeFile": "file1"
}
```

## Publishing State
State is set and removed via the `setState()`,  `removeState()`, and `clearState()` methods on an `Activity` object. Publishing can mean adding new key-value pairs, or it can mean overwriting an existing key's value.  *Removing state is preferred over setting states to null* to represent the absence of state, unless null has a special specific meaning in an application.  Some examples are shown below:

```js

// Sets or updates a single key / value pair. This will result in a
// single "state_set" event being fired.
activity.setState("key", "value");

// Sets or updates multiple keys/values at once. This will result
// in multiple "state_set" events being fired.
activity.setState({"key1": "value 1", "key2": "value2"});

// Removes a single key. This will result in a single "state_removed"
// event being fired.
activity.removeState("key");

// Removes multiple state keys. This will result in multiple "state_removed"
// event being fired.
activity.removeState(["key1", "key2"]);

// Clears all state from the activity. This will result in a 
// "state_cleared" event being fired.
activity.clearState();
```

### Local Activity State

You can access the currently published state of the local session via `state()` method. The state is a JavaScript Map so you can easily get individual state element via the Map's `get(key)` method.
 
```js
// Get all state for the local session
const allState = activity.state();

// Get only the viewport key
const viewport = activity.state().get("viewport");
```
 

## Remote Participant Activity State

The `participants()` method returns a set of `ActivityParticipant` objects.  The state for each participant can be obtained using the `ActivityParticipant.state()` method. The state is returned as a JavaScript [Map](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Map) object. Modifying this map will have no affect on the participants stored state.

```js
const participant = activity.participant("someSessionId");

// Get all state for a participant 
const stateMap = participant.state;

// Get just the viewport key for a participant
const stateMap = participant.state.get ("viewport");

// Get all viewports by sessionId
const allViewports = activity.participants().map((p) => {
  return {sessionId: p.sessionId, viewport: p.state.get("viewport")}; 
});
```

## Events

The `Activity` object emits two events that are useful for determining how state is changing over time.

| Event | Description |
| --- | --- |
| `state_set` | Emitted when a joined session sets new state. |
| `state_removed` | Emitted when joined session removes existing state. |
| `state_cleared` | Emitted when joined session clears all existing state. |
| `state_delta` | Emitted to summarize all changes made by a joined session in a single action. |

### Examples

```js
// Called for each individual state key that was set or changed. 
activity.on("state_set", (e) => {
  console.log(e.sessionId, e.key, e.value, e.oldValue);
});

// Called for each individual state key removed.
activity.on("state_removed", (e) => {
  console.log(e.sessionId, e.key, e.oldValue);
});

// Called once when all state is cleared.
activity.on("state_cleared", (e) => {
  console.log(e.sessionId, e.key, e.oldValues);
});

// Called once when for each action the remote user took.
activity.on("state_delta", (e) => {
  console.log(e.sessionId, e.values, e.removed, e.oldValues);
});
```