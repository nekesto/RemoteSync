// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to SyncChangeset.m instead.

#import "_SyncChangeset.h"

const struct SyncChangesetAttributes SyncChangesetAttributes = {
	.updatedDate = @"updatedDate",
	.uuid = @"uuid",
};

const struct SyncChangesetRelationships SyncChangesetRelationships = {
	.changes = @"changes",
};

const struct SyncChangesetFetchedProperties SyncChangesetFetchedProperties = {
};

@implementation SyncChangesetID
@end

@implementation _SyncChangeset

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"SyncChangeset" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"SyncChangeset";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"SyncChangeset" inManagedObjectContext:moc_];
}

- (SyncChangesetID*)objectID {
	return (SyncChangesetID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic updatedDate;






@dynamic uuid;






@dynamic changes;

	
- (NSMutableSet*)changesSet {
	[self willAccessValueForKey:@"changes"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"changes"];
  
	[self didAccessValueForKey:@"changes"];
	return result;
}
	






@end
