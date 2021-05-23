# References
Convergence provides a suite of features under the umbrella term "Collaboration Awareness."  A key piece of this is the ability to communicate with other users *about* the data model.  This type of communication often involves transient data which does not belong in the main persisted data model.  An extremely common use case is sharing your cursor in a text document.  This is a crucial piece of information to broadcast so that others can see what you are doing and won't step on your toes.  However, you probably don't care to persist the position of each user's cursor in your data model alongside the `RealTimeString` representing the document.

Enter References.  References are pointers to elements and data within the model. They significantly reduce the complexity of communicating collaborative state that is related to an ever-changing document. 

## Example
For example, if users wish to share cursors within a plain text document represented as a string, it might be natural for them to describe and broadcast their cursor location as an index in the string.  The user may wish to let other users know that their cursor is at "index 43" in the document.  Let's look at an example of where that can get complicated.

An example "document" is shown below. Also assume we have two users, Alice and Bob:

```
"A plain text document."
         ^- Bob's cursor is at index 8
```

Assume that Bob and Alice both start off with the stame state. If Bob places his cursor just before the 't' in the word 'text', he can broadcast his cursor location to Alice as "Bob's cursor is at index 8".  If Alice renders a remote cursor at index 8 she will render it in the correct location.

Assume now that Alice is editing the data concurrently, and that at the very same time Bob has place his cursor at index 8, Alice has inserted some characters into the document.

Bob's Document:
```
"A plain |text document."
         ^- Bob's cursor is at index 8
```
Alice's Document:
```
"A real-t|ime plain text document."
         ^- Bob's cursor is at index 8
```

If Alice were to render Bob's cursor at index 8, it would be pointing to the wrong location. To correct this problem herself, Alice would need to be able to know that when Bob sent his cursor message, he did not know about her changes to the document.  Thus she would need to update the position of the cursor.  This is very complex and would require Alice to know many details about the underlying concurrency control and state management properties of the system.

References solve this problem by giving users a simple mechanism to broadcast pointers to elements and data in the model that are guaranteed to remain consistent in the face of concurrent changes to the data.

## Reference Scope
A real time model may have more than one reference at any given time.  For example, in a plain text document you may wish to share the cursor position, a selection, or the scroll position of the editor.  These are three distinct concepts that all may reference different points within the same `RealTimeElement`.

```js
{
                 v- cursor: 8
  text: "A short |plain text document!"
                 ^---------^ 
                 selection: {start: 8, end: 18}
}
```

Each reference is targeted at a specific `RealTimeModel` element.  In the example above, both references point to the `RealTimeString` at the path `[text]` within the model. To distinguish multiple references within the same element, each reference allows a user-defined "key" which is just a string identifier.  Each reference is also owned by the session that published it.

Therefore, each reference is uniquely identified by three pieces of information:

1. The element (or model) that reference was created from.
2. The "key" (e.g. cursor, selection, viewport, etc.)
3. The `sessionId` of the session where the reference was published.

## Local vs. Remote References

A [local reference](local-references.md) is one that was created by the local session.  For example, if this client would like to share its cursor position, it will create a local reference and then publish the information in that reference for other connected sessions to consume.  

A [remote reference](remote-references.md) is an incoming reference from another session.  The major difference is that you can change the value of a local reference, because you own it.  Remote references are read only, since they represent state published by other users (or sessions).  
