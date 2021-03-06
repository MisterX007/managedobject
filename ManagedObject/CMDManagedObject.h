//
//  CMDManagedObject.h
//
//  Created by Caleb Davenport on 3/215/11.
//  Copyright (c) 2012 Caleb Davenport.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface CMDManagedObject : NSManagedObject

@property (nonatomic, retain) NSDate *createdAt;

// override this method to provide an entity name other than the class name
+ (NSString *)entityName;

// default sort descriptors
+ (NSArray *)defaultSortDescriptors;

// create object in specified context
+ (instancetype)instanceInContext:(NSManagedObjectContext *)context;

// create a fecth request based on the class
+ (NSFetchRequest *)fetchRequest;
+ (NSFetchRequest *)fetchRequestInContext:(NSManagedObjectContext *)context DEPRECATED_ATTRIBUTE;

// find objects in the specified context with the default sort descriptors
+ (NSArray *)allInContext:(NSManagedObjectContext *)context;
+ (NSArray *)allInContext:(NSManagedObjectContext *)context predicate:(NSPredicate *)predicate;

// find objects in the specified context with the specified sort descriptors and predicate
+ (NSArray *)allInContext:(NSManagedObjectContext *)context sortDescriptor:(NSSortDescriptor *)descriptor;
+ (NSArray *)allInContext:(NSManagedObjectContext *)context sortDescriptors:(NSArray *)descriptors;
+ (NSArray *)allInContext:(NSManagedObjectContext *)context predicate:(NSPredicate *)predicate sortDescriptor:(NSSortDescriptor *)descriptor;
+ (NSArray *)allInContext:(NSManagedObjectContext *)context predicate:(NSPredicate *)predicate sortDescriptors:(NSArray *)descriptors;

// find and find or create with simple key-value pairs
+ (instancetype)findByKey:(NSString *)key value:(id)value inContext:(NSManagedObjectContext *)context;
+ (instancetype)findOrCreateByKey:(NSString *)key value:(id)value inContext:(NSManagedObjectContext *)context;

// count objects in specified context
+ (NSUInteger)countInContext:(NSManagedObjectContext *)context;
+ (NSUInteger)countInContext:(NSManagedObjectContext *)context predicate:(NSPredicate *)predicate;

// delete an object
- (void)delete;

@end
