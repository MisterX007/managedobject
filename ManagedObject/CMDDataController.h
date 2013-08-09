//
//  CMDDataController.h
//  ManagedObject
//
//  Created by Caleb Davenport on 8/9/13.
//  Copyright (c) 2013 Caleb Davenport. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface CMDDataController : NSObject

+ (NSManagedObjectModel *)managedObjectModel;

+ (NSURL *)persistentStoreURL;

+ (NSDictionary *)persistentStoreOptions;

+ (NSPersistentStoreCoordinator *)persistentStoreCoordinator;

+ (NSPersistentStore *)persistentStore;

+ (NSString *)persistentStoreType;

+ (NSString *)persistentStoreConfiguration;

+ (NSManagedObjectContext *)mainQueueContext;

+ (BOOL)automaticallyResetPersistentStore;

+ (void)resetPersistentStore;

@end
