//
//  CMDManagedObject.h
//
//  Created by Caleb Davenport on 3/215/11.
//  Copyright (c) 2012 Caleb Davenport.
//

#import <CoreData/CoreData.h>

@interface CMDManagedObject : NSManagedObject

@property (nonatomic, retain) NSDate *createdAt;

// override this method to provide an entity name other than the class name
+ (NSString *)entityName;

// create object in specified context
+ (id)instanceInContext:(NSManagedObjectContext *)context;

// create a fecth request based on the class
+ (NSFetchRequest *)fetchRequestInContext:(NSManagedObjectContext *)context;

// find objects in specified context
+ (NSArray *)allInContext:(NSManagedObjectContext *)context;
+ (NSArray *)allInContext:(NSManagedObjectContext *)context sortDescriptor:(NSSortDescriptor *)descriptor;
+ (NSArray *)allInContext:(NSManagedObjectContext *)context sortDescriptors:(NSArray *)descriptors;
+ (NSArray *)allInContext:(NSManagedObjectContext *)context predicate:(NSPredicate *)predicate;
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
