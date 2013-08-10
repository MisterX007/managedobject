//
//  CMDRemoteManagedObject.m
//  ManagedObject
//
//  Created by Caleb Davenport on 4/21/13.
//  Copyright (c) 2013 Caleb Davenport. All rights reserved.
//

#import "CMDRemoteManagedObject.h"

@implementation CMDRemoteManagedObject

@dynamic updatedAt;
@dynamic remoteID;

+ (instancetype)findOrCreateByRemoteID:(NSNumber *)remoteID inContext:(NSManagedObjectContext *)context {
    if (remoteID) {
        return [self findOrCreateByKey:@"remoteID" value:remoteID inContext:context];
    }
    return nil;
}

#pragma mark - unpacking

- (void)unpackDictionary:(NSDictionary *)dictionary {
    self.remoteID = dictionary[@"id"];
    self.createdAt = [[self class] parseDate:dictionary[@"created_at"]];
    self.updatedAt = [[self class] parseDate:dictionary[@"updated_at"]];
}

- (BOOL)shouldUnpackDictionary:(NSDictionary *)dictionary {
    if (!self.updatedAt) {
        return YES;
    }
    
    NSDate *updatedAt = [[self class] parseDate:dictionary[@"updated_at"]];
    if (updatedAt && [self.updatedAt compare:updatedAt] == NSOrderedAscending) {
        return YES;
    }
    
    return NO;
}

+ (instancetype)instanceWithDictionary:(NSDictionary *)dictionary inContext:(NSManagedObjectContext *)context {
    NSNumber *remoteID = dictionary[@"id"];
    id object = [self findOrCreateByRemoteID:remoteID inContext:context];
    if ([object shouldUnpackDictionary:dictionary]) {
        [object unpackDictionary:dictionary];
    }
    return object;
}

#pragma mark - dates

+ (NSDate *)parseDate:(id)date {
    if ([date respondsToSelector:@selector(doubleValue)]) {
        return [NSDate dateWithTimeIntervalSince1970:[date doubleValue]];
    }
    return nil;
}

@end
