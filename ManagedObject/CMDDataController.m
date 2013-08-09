//
//  CMDDataController.m
//  ManagedObject
//
//  Created by Caleb Davenport on 8/9/13.
//  Copyright (c) 2013 Caleb Davenport. All rights reserved.
//

#import "CMDDataController.h"

static dispatch_queue_t __dispatchQueue;
static NSPersistentStore *__persistentStore;
static NSManagedObjectContext *__privateQueueContext;
static NSManagedObjectContext *__mainQueueContext;

@implementation CMDDataController

#pragma mark - NSObject

+ (void)load {
    __dispatchQueue = dispatch_queue_create(NULL, DISPATCH_QUEUE_SERIAL);
    [[NSNotificationCenter defaultCenter]
     addObserverForName:NSManagedObjectContextDidSaveNotification
     object:nil
     queue:nil
     usingBlock:^(NSNotification *note) {
         NSManagedObjectContext *context = [self mainQueueContext];
         if ([note object] == context) {
             context = [context parentContext];
             [context performBlock:^{
                 [context save:nil];
             }];
         }
     }];
}


+ (void)initialize {
    [self persistentStore];
}

#pragma mark - Methods for subclasses

+ (NSManagedObjectModel *)managedObjectModel {
    return [NSManagedObjectModel mergedModelFromBundles:nil];
}


+ (NSURL *)persistentStoreURL {
    NSFileManager *manager = [NSFileManager defaultManager];
    NSURL *URL = [manager URLsForDirectory:NSApplicationSupportDirectory inDomains:NSUserDomainMask][0];
    [manager createDirectoryAtURL:URL withIntermediateDirectories:YES attributes:nil error:nil];
    return [URL URLByAppendingPathComponent:@"CoreData.db"];
}


+ (NSDictionary *)persistentStoreOptions {
    return @{
        NSMigratePersistentStoresAutomaticallyOption : @YES,
        NSInferMappingModelAutomaticallyOption : @YES
    };
}


+ (NSString *)persistentStoreType {
    return NSSQLiteStoreType;
}


+ (NSString *)persistentStoreConfiguration {
    return nil;
}


+ (BOOL)automaticallyResetPersistentStore {
    return NO;
}


#pragma mark - Public

+ (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    static dispatch_once_t token;
    static NSPersistentStoreCoordinator *coordinator;
    dispatch_once(&token, ^{
        NSManagedObjectModel *model = [self managedObjectModel];
        coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];
    });
    return coordinator;
}


+ (NSPersistentStore *)persistentStore {
    dispatch_sync(__dispatchQueue, ^{
        [self persistentStoreWithoutGuard];
    });
    return __persistentStore;
}


+ (NSManagedObjectContext *)mainQueueContext {
    dispatch_sync(__dispatchQueue, ^{
        [self mainQueueContextWithoutGuard];
    });
    return __mainQueueContext;
}


+ (void)resetPersistentStore {
    dispatch_sync(__dispatchQueue, ^{
        
        // Reset contexts
        [__mainQueueContext reset];
        __mainQueueContext = nil;
        [__privateQueueContext reset];
        __privateQueueContext = nil;
        
        // Remove and delete store
        NSPersistentStore *store = [self persistentStoreWithoutGuard];
        NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
        if ([coordinator removePersistentStore:store error:nil]) {
            [[NSFileManager defaultManager] removeItemAtURL:[store URL] error:nil];
            __persistentStore = nil;
            [self persistentStoreWithoutGuard];
        }
    });
}


#pragma mark - Private

+ (NSManagedObjectContext *)privateQueueContext {
    if (__privateQueueContext == nil) {
        __privateQueueContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
        [__privateQueueContext setPersistentStoreCoordinator:[self persistentStoreCoordinator]];
    }
    return __privateQueueContext;
}


+ (NSManagedObjectContext *)mainQueueContextWithoutGuard {
    if (__mainQueueContext == nil) {
        __mainQueueContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
        [__mainQueueContext setParentContext:[self privateQueueContext]];
    }
    return __mainQueueContext;
}


+ (NSPersistentStore *)persistentStoreWithoutGuard {
    if (__persistentStore == nil) {
        NSURL *URL = [self persistentStoreURL];
        NSDictionary *options = [self persistentStoreOptions];
        NSString *configuration = [self persistentStoreConfiguration];
        NSString *type = [self persistentStoreType];
        NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
        __persistentStore = [coordinator addPersistentStoreWithType:type configuration:configuration URL:URL options:options error:nil];
        if (__persistentStore == nil) {
            if ([self automaticallyResetPersistentStore]) {
                [[NSFileManager defaultManager] removeItemAtURL:URL error:nil];
                __persistentStore = [coordinator addPersistentStoreWithType:type configuration:configuration URL:URL options:options error:nil];
            }
        }
    }
    return __persistentStore;
}

@end
