//
//  CMDManagedObject.m
//
//  Created by Caleb Davenport on 3/215/11.
//  Copyright (c) 2012 Caleb Davenport.
//

#import "CMDManagedObject.h"

@implementation CMDManagedObject

@dynamic createdAt;

#pragma mark - custom model name

+ (NSString *)modelName {
  return NSStringFromClass(self);
}

#pragma mark - create objects

+ (id)instanceInContext:(NSManagedObjectContext *)context {
    NSString *name = [self modelName];
    id instance = [NSEntityDescription insertNewObjectForEntityForName:name inManagedObjectContext:context];
    [(id)instance setCreatedAt:[NSDate date]];
    return instance;
}

#pragma mark - fetch requests

+ (NSFetchRequest *)fetchRequestInContext:(NSManagedObjectContext *)context {
    NSString *name = [self modelName];
    NSEntityDescription *entity = [NSEntityDescription entityForName:name inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entity];
#if __has_feature(objc_arc)
    return request;
#else
    return [request autorelease];
#endif
}

#pragma mark - find objects

+ (NSArray *)allInContext:(NSManagedObjectContext *)context {
    return [self allInContext:context predicate:nil sortDescriptors:nil];
}

+ (NSArray *)allInContext:(NSManagedObjectContext *)context sortDescriptor:(NSSortDescriptor *)descriptor {
    return [self allInContext:context predicate:nil sortDescriptor:descriptor];
}

+ (NSArray *)allInContext:(NSManagedObjectContext *)context sortDescriptors:(NSArray *)descriptors {
    return [self allInContext:context predicate:nil sortDescriptors:descriptors];
}

+ (NSArray *)allInContext:(NSManagedObjectContext *)context predicate:(NSPredicate *)predicate {
    return [self allInContext:context predicate:predicate sortDescriptors:nil];
}

+ (NSArray *)allInContext:(NSManagedObjectContext *)context predicate:(NSPredicate *)predicate sortDescriptor:(NSSortDescriptor *)descriptor {
    return [self allInContext:context predicate:predicate sortDescriptors:[NSArray arrayWithObject:descriptor]];
}

+ (NSArray *)allInContext:(NSManagedObjectContext *)context predicate:(NSPredicate *)predicate sortDescriptors:(NSArray *)descriptors {
    NSFetchRequest *request = [self fetchRequestInContext:context];
    if (descriptors) {
        [request setSortDescriptors:descriptors];
    }
    if (predicate) {
        [request setPredicate:predicate];
    }
    return [context executeFetchRequest:request error:nil];
}

#pragma mark - count objects

+ (NSUInteger)countInContext:(NSManagedObjectContext *)context {
    return [self countInContext:context predicate:nil];
}

+ (NSUInteger)countInContext:(NSManagedObjectContext *)context predicate:(NSPredicate *)predicate {
    NSFetchRequest *request = [self fetchRequestInContext:context];
    if (predicate) {
        [request setPredicate:predicate];
    }
    return [context countForFetchRequest:request error:nil];
}

@end