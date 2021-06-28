# Activities

Activities allow a developer to create different scopes of collaboration that relate to different areas of interest in the application.  It is often the case that users in the system are only directly collaborating with a subset of the other users within a certain part of the application. For example, imagine an IDE-like application where there are a set of "projects", each of which are made up of multiple "files".  A single user connected to the application might not need to collaborate with every other user.  Certain users may be working in the same project or file, and some may not.  The user editing a certain file may not care about who is editing a file in another project.

Participation and shared state can be scoped via an `Activity`.  In this manner, developers have more granular control over who is visibly doing what in the application.  Each activity is uniquely identified in the system by an activity **type** and **id**. Both the type and id are user defined. The **type** is simply a categorization to group similar activities.  Using the IDE example, certain activities might be `"project"` activities and others might be `"file"` activities. Each activity's id must be unique within it type. 

It should also be mentioned that participation in activities is scoped by user session.  This is because the same user may be connected to the system from two different devices, and they may be doing different things on each device.

## Activity Participation
Activity **participation** is described as "presence" for the activity.  That is to say any given session may or may not be participating in the activity.  The set of sessions actively participating in the activity are call the **participants**.

## Activity State
Activity **state** is a way to share information about a session's disposition within the activity. For example, a session may have joined an activity related to a specific project.  Each session might wish to share which files they are currently editing with the other users. Each session can share its state within the activity and publish that information for other sessions to see.


## Activity Service

The main entry point into the activity API is the `ActivityService` which can be obtained from the [ConvergenceDomain](/getting-started):

```js
const activityService = domain.activities();
```

### Creating Activities
The first step in using an activity is to create one. An activity can be created by using the `ActivityService.create(options)`:

```js
domain.activities()
  .create({activityType: "project", activityId: "id"})
  .then(() => console.log("Activity Created!"));
```

Keep in mind that when you create an activity, only the user that created it will have permissions to join the activity by default.  See the section on [Activity Permissions](../permissions/) for complete details. However, if you want any other user to joing and participate an activity a sensible set of world permissions will go a long way:

```js
domain.activities()
  .create({
    activityType: "project", 
    activityId: "id",
    worldPermissions: ["join", "set_state", "view_state"]
  })
  .then(() => console.log("Activity Created!"));
```

### Deleting Activities
When no longer needed, Activities can be deleted using the `ActivityService.remove(type, id)`:

```js
domain.activities()
  .remove("project", "id")
  .then(() => console.log("Activity Removed!"));
```

If users are connected to the Activity when it is removed, they will automatically leave the activity. However, in addition to the normal `leave` event, they will also receive an `deleted` event to let them know that the activity was deleted.

```js
activity.on("delete", (e) => {
  console.log("The activity was deleted while I was joined");
})
```