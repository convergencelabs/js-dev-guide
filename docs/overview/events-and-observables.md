# Event Emitters and Observables
Events are a critical part of any real-time system.  They are the primary mechanism to be informed of the actions of remote users.  Event systems allow you to register to be  notified of local and remote changes in the system.  Convergence provides two methods for handling events:

* **Event Listeners**: Event listeners allow the consumer to register for one or more named events, and provide a callback function / listener for each.
* **Observable Streams**: Observers, Observables, and stream processing are long-standing design patterns, allowing events to be delivered as composeable and mappable streams.

Each option has its pros and cons.  Convergence supports both to allow developers to choose how they want to interact with the system.


## Event Emitter
The event emitter pattern was popularized by NodeJS.  Consumers register for specific events and provide callback functions that will be called when the events are emitted.

```javascript
var emitter = new SomeEmitter();

// Listen to the 'userMortalityChange' event.
emitter.on("userMortalityChange", (user, isAlive, age) => {
  if(isAlive) {
    console.log(user + " is still kicking at " + age);
  }
});

// emit to the 'userMortalityChange' event.
emitter.emit("userMortalityChange", "John", true, 47);
```

The event emitter pattern is popular, simple, and very easy to use.  However, it is also fairly limited in terms of processing capabilities, requiring significant effort when, for instance, multiple event listeners need to communicate with one another.


## Observable Streams
Observables aren't new.  However, recently the [ReactiveX](http://reactivex.io/) project has re-envisioned and popularized this pattern.  Events are delivered in composeable, powerful, functional streams. Complex compositions and event handling can be reduced to a few lines of code.

```JavaScript
var subject = new SomeSubject();

subject.asObserver()
  .filter((v) => {return v > 5;})
  .map((v) => {return v * 2;})
  .subscribe((v) => {
    console.log(v);
  });

subject.next(4);
subject.next(6);
subject.next(8);

// Will output:
// 12
// 16
```

The Observable pattern is very powerful, but it is not as widely understood and requires a greater learning curve. See [ReactiveX](http://reactivex.io/) for more information.