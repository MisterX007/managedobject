# CMDManagedObject

This class helps perform common Core Data tasks like fetching and counting objects by removing the need to worry about entity descriptions, manually creating fetch requests, and handling context interactions for you.

## Installation

- Add `GCMDManagedObject.h`, `GCMDManagedObject.m` and `CoreData.framework` to your project
- Make every object in your model inherit from an abstract `GCManagedObject` object
- Add a date attribute called `createdAt` to your `GCManagedObject` object
- Make all of your managed object source files inherit from `CGManagedObject`
