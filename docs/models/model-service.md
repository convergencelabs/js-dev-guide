# Model Service
The model service is the main entry point into all of the functionality around models and real time data.  Once connected to a domain, the model service can easily be obtained from the domain as follows:

```JavaScript
const modelService = domain.models();
```

## Create a Model
To create a new model you can simply call the ```create(options)``` method on the model service.  For example, to create a new Employee:

### Simple Example
```JavaScript
modelService.create({collection: "employee"}).then(modelId => {
  console.log("model created with Id: " + modelId);
});
```

### Complex Example
```JavaScript
modelService.create({
  collection: "employee", 
  data: {
    id: "1834-4",
    fname: "John",
    lname: "Doe",
    username: "jdoe"
  },
  overrideCollectionWorldPermissions: false,
  worldPermissions: {read: true, write: false, remove: false, manage: false},
  userPermissions: { 
    "ted": {read: true, write: false, remove: false, manage: false}
  }
}).then(modelId => {
  console.log("model created!");
}).catch(err => {
  console.error("no dice, buddy:", err);
});
```

### Options
| Option | Type | Required | Description |
| --- | --- | --- | --- |
| collection  | string | yes | The collection the model should be created in. |
| id  | string | no | The id to assign to the model. If not supplied, an id will be generated. |
| data  | object or function | no | The initial data to set as the root of the model. This can either be an object or a function that returns an object. If not supplied, an empty model will be created. |
| overrideCollectionWorldPermissions | boolean | no | Whether the model should override the collection's world permissions. Defaults to false. |
| worldPermissions | ModelPermissions | no | The world permissions to set. Defaults to the collections permissions. |
| userPermissions | {[key: string]: ModelPermissions} | no | The user permissions to set. |


## Open an Existing Model
To work with an existing model in real time you must open it.  To open a model use the ```open(modelId)``` method:

```JavaScript
modelService.open("970b09ee-f2b5-4d19-b3dc-e8fef87bf65c").then(model => {
  console.log("model", model.modelId(), "opened");
});
```

## Opening Model with Auto Create
There are situations where you may want to create and open a model all in one step. Or it may be the case that you want to open a specific model and create it if doesn't exist, but just open it if it does. You can use the `openAutoCreate(options)` method to achieve this. If the model exists, it will just be opened. If the model does not exist, the supplied options will be used to create the model, and then it iwll be opened.

### Simple Example
```JavaScript
modelService.openAutoCreate({collection: "employee"}).then(model => {
  console.log("model created!");
}).catch(err => {
  console.error("no dice, buddy:", err);
});
```

### Complex Example
```JavaScript
modelService.openAutoCreate({
  collection: "employee", 
  data: {
    id: "1834-4",
    fname: "John",
    lname: "Doe",
    username: "jdoe"
  },
  overrideCollectionWorldPermissions: false,
  worldPermissions: {read: true, write: false, remove: false, manage: false},
  userPermissions: { 
    "ted": {read: true, write: false, remove: false, manage: false}
  },
  ephemeral: false
}).then(model => {
  console.log("model created!");
}).catch(err => {
  console.error("no dice, buddy:", err);
});
```

### Options
| Option | Type | Required | Description |
| --- | --- | --- | --- |
| collection  | string | yes | The collection the model should be created in. |
| id  | string | no | The id to assign to the model. If not supplied, an id will be generated. |
| data  | object or function | no | The initial data to set as the root of the model. This can either be an object or a function that returns an object. If not supplied, an empty model will be created. |
| overrideCollectionWorldPermissions | boolean | no | Whether the model should override the collection's world permissions. Defaults to false. |
| worldPermissions | ModelPermissions | no | The world permissions to set. Defaults to the collections permissions. |
| userPermissions | {[key: string]: ModelPermissions} | no | The user permissions to set. |
| ephemeral | boolean | no | If set to true, the model will be deleted as soon as the last collaborator closes it. |

## Note about race conditions
Programming in real-time collaborative scenarios requires extra diligence about race conditions.  One example is a potential race condition around multiple people creating models at the same time.  It may be intuitive to do something like this:

```javascript
if (exists(myModelId)) {
  // open
} else {
//  create
}
```

but what if someone else created the model between when you tested for existence and you then created it?  You end up having to write something like this:

```javascript 
if (exists(myId)) {
  // open
} else {
 try {
  create
  } catch (e) {
    if (e is an already exists error) {
      // open
    } else {
       // actual error
    }
  }
}

```

which is ugly to say the least.  The `openAutoCreate` method was created to avoid this sort of thing.

## Remove a Model
To remove an existing model you can call the ```remove(modelId)``` method on the model service.  For example:

```JavaScript
modelService.remove("970b09ee-f2b5-4d19-b3dc-e8fef87bf65c").then(() => {
  console.log("John was canned :(");
});
```
