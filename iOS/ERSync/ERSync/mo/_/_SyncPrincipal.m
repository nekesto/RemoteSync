// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to SyncPrincipal.m instead.

#import "_SyncPrincipal.h"

const struct SyncPrincipalAttributes SyncPrincipalAttributes = {
	.lastSync = @"lastSync",
	.password = @"password",
	.principalId = @"principalId",
	.site = @"site",
	.username = @"username",
	.uuid = @"uuid",
};

const struct SyncPrincipalRelationships SyncPrincipalRelationships = {
};

const struct SyncPrincipalFetchedProperties SyncPrincipalFetchedProperties = {
};

@implementation SyncPrincipalID
@end

@implementation _SyncPrincipal

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"SyncPrincipal" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"SyncPrincipal";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"SyncPrincipal" inManagedObjectContext:moc_];
}

- (SyncPrincipalID*)objectID {
	return (SyncPrincipalID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic lastSync;






@dynamic password;






@dynamic principalId;






@dynamic site;






@dynamic username;






@dynamic uuid;











@end
