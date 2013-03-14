// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to SyncEntity.m instead.

#import "_SyncEntity.h"

const struct SyncEntityAttributes SyncEntityAttributes = {
	.dataToken = @"dataToken",
	.name = @"name",
	.status = @"status",
	.updatedDate = @"updatedDate",
	.uuid = @"uuid",
};

const struct SyncEntityRelationships SyncEntityRelationships = {
	.changes = @"changes",
	.toManyChanges = @"toManyChanges",
	.toOneChanges = @"toOneChanges",
};

const struct SyncEntityFetchedProperties SyncEntityFetchedProperties = {
};

@implementation SyncEntityID
@end

@implementation _SyncEntity

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"SyncEntity" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"SyncEntity";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"SyncEntity" inManagedObjectContext:moc_];
}

- (SyncEntityID*)objectID {
	return (SyncEntityID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic dataToken;






@dynamic name;






@dynamic status;






@dynamic updatedDate;






@dynamic uuid;






@dynamic changes;

	
- (NSMutableSet*)changesSet {
	[self willAccessValueForKey:@"changes"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"changes"];
  
	[self didAccessValueForKey:@"changes"];
	return result;
}
	

@dynamic toManyChanges;

	
- (NSMutableSet*)toManyChangesSet {
	[self willAccessValueForKey:@"toManyChanges"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"toManyChanges"];
  
	[self didAccessValueForKey:@"toManyChanges"];
	return result;
}
	

@dynamic toOneChanges;

	
- (NSMutableSet*)toOneChangesSet {
	[self willAccessValueForKey:@"toOneChanges"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"toOneChanges"];
  
	[self didAccessValueForKey:@"toOneChanges"];
	return result;
}
	






@end
