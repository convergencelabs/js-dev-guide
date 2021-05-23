# Real Time Models
Real-time data is a central component of the Convergence platform and drives many of our other features and functions.  A flexible, efficient, and easy to use distributed data model is a key requirement of any real-time collaboration system.  The Convergence data store can be thought of as a real-time document store which provides features specifically geared towards distributed collaboration. Some of the key attributes of the Convergence Model infrastructure include:

* **Robust Data Structures**: Convergence's data model is essentially JSON on steroids. Whatever you can store in JSON (and more!) can be stored in Convergence.
* **Granular Editing**: Edit any part of the data tree, no matter how deeply nested, at any time.  Describe specific edits you are making to the data structure rather than simply updating it.
* **Conflict Resolution / Micro Merges**: Granular modifications to the model are streamed to the server in realtime from all users.The server then performs micro merges that drastically reduce the scope of conflicts.  Conflicts are resolved automatically and consistently to ensure everyone sees the same thing.
* **Historical Auditing**: Every edit made to the model is tracked.  Go back in time and see what was done by whom and when.  The entire history of the document is stored, so data can never be completely lost.
* **Shareable References**: References to the data can be shared with other users.  These references are kept in sync with the data as it changes in real time.  This greatly simplifies the complexity of shared constructs such as cursors and selections.


# Data Types
Convergence supports all JSON data types:

* Object
* Array
* Number
* String
* Boolean
* Null

> We will be adding support for additional types in the future.  Stay tuned!

An example model might look like the following:

```JSON
{
  "firstName": "Jim",
  "lastName": "Smith",
  "age": 32,
  "address": {
    "street": "125 Maple Av."
    "city": "Somewhereville",
    "state": "MI",
    "zip": "84729-0083"
  },
  "emails": [
    "jsmith@example.com",
    "james.smith@test.com"
  ],
  "married": false,
  "spouse": null
}
```

# Paths
Elements in the document model can be referenced by their **path**, where the path is a list of navigation elements through the document structure.  For example, to reference the first email address in the above model, the path would be `["emails", 0]`.  To reference the zip code, the path would be `["address", "zip"]`.  The path simply identifies object properties or array
indices that must be traversed to arrive at the element of interest in the document.

# Collections
Each Convergence model belongs to a **collection**.  A collection is analogous to a SQL Table, or an Object Database class.  Collections represent sets of related models. For example, in your application you may have an "employee" collection and a "customer" collection which store models representing a particular type of concept in your system.