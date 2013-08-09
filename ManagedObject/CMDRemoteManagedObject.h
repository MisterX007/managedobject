//
//  CMDRemoteManagedObject.h
//  ManagedObject
//
//  Created by Caleb Davenport on 4/21/13.
//  Copyright (c) 2013 Caleb Davenport. All rights reserved.
//

#import "CMDManagedObject.h"

@interface CMDRemoteManagedObject : CMDManagedObject

@property (nonatomic, strong) NSDate *updatedAt;
@property (nonatomic, strong) NSNumber *remoteID;

// easy interface to findOrCreateByKey:value:inContext:
+ (instancetype)findOrCreateByRemoteID:(NSNumber *)remoteID inContext:(NSManagedObjectContext *)context;

// find or create an instance with the given dictionary
+ (instancetype)instanceWithDictionary:(NSDictionary *)dictionary inContext:(NSManagedObjectContext *)context;

// dictionary unpacking
- (void)unpackDictionary:(NSDictionary *)dictionary;
- (BOOL)shouldUnpackDictionary:(NSDictionary *)dictionary;

// parse a date from a dictionary
+ (NSDate *)parseDate:(id)date;

@end
