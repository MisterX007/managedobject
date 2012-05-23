//
//  CMDManagedObject.h
//
//  Created by Caleb Davenport on 3/215/11.
//  Copyright (c) 2012 Caleb Davenport.
//

#import <CoreData/CoreData.h>

@interface CMDManagedObject : NSManagedObject

@property (nonatomic, retain) NSDate *createdAt;

// override this method to provide a model name other than the class name
+ (NSString *)modelName;

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

// count objects in specified context
+ (NSUInteger)countInContext:(NSManagedObjectContext *)context;
+ (NSUInteger)countInContext:(NSManagedObjectContext *)context predicate:(NSPredicate *)predicate;

@end