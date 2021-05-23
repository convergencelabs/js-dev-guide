# Observing an Activity

In addition to the eventing API, it is possible to interact with an activity participants using an immutable, reactive, observation pattern. Since the participants of the activity cover both the participation and state concepts, the entire activity can be completely described by monitoring the list of participants over time.

## Examples

```js
// Listen on any change
activity.participantsAsObservable().subscribe(participants => {
  console.log(participants); // ActivityParticipant[]
});

// Listen when a new user is added
activity
  .participantsAsObservable()
  .flatMap((participants) => {
      return Rx.Observable.from(participants);
    })
  .groupBy((p) => p.sessionId())
  .subscribe((group) => {
    console.log("new user");
  });
  
```


