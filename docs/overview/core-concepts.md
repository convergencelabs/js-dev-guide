# Core Concepts

At the heart of Convergence is a **collaborative distributed data model** that allows users to both simultaneously modify data and see each other's changes in real time. While this is a critical capability, when starting to build a collaborative application it quickly becomes  apparent that this alone is not sufficient to provide a useful collaborative experience.  Thus, Convergence provides several supporting APIs that address the core aspects of meaningful collaboration.

* **Real-time Distributed Data**: This is where it all begins: The ability for multiple people to work together on the same data at the same time. Convergence stands out here due to its sophisticated distributed data model.  Most distributed systems use simple last-write-wins semantics, have limited data types, and lack support for intuitive resolutions when modifying data concurrently.  Convergence has a data model sophisticated enough to provide the shared, consistent outcomes that users expect.

* **Users and Identity**: As soon as another user can edit your data in real time, you will want to be able to know about these other users.  This requires user management, authentication and identity functionality to ask *who* is on the other end of the collaboration. Convergence offers multiple ways to view and manage users through a single API.

* **Presence**: Users will need to know the answers to questions like _who is working on this data with me?_ and _who is online and available?_.  This concept is called presence and is a key attribute of any collaborative system.  However, for successful collaboration, presence goes beyond simply being able to create a buddy list. Convergence provides a robust set of features for presence so that developers don't have to build it themselves.

* **Collaboration Awareness**: When people work together in the same location, there are social conventions alongside visual and auditory cues that help us anticipate what one another may do.  This helps us avoid conflicts and leads to more effective collaboration.  Those cues are often missing when collaborating remotely on shared content in an application.  Convergence has several features that support collaborative cues.  While our conflict resolution is robust, it's best to avoid it in the first place!

* **Chat & Messaging**: Even with all of the aforementioned concepts in place, users will still need to communicate in order to effectively coordinate their actions, ask questions, and resolve conflicts.  This should be possible directly within the application.  Embedding combination concepts like chat and messaging directly in your app will lead to more effective and collaborative expedience for you users.

While many of these concepts are partially covered by existing APIs, developers must spend a significant amount of time researching, learning, and gluing together multiple solutions.  Furthermore, most of these APIs lack critical functionality because they were not developed with real-time collaboration in mind.  Convergence has developed an integrated set of features purpose built to support real-time collaboration, saving you time and money.

