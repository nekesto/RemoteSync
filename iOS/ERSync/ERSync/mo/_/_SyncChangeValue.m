// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to SyncChangeValue.m instead.

#import "_SyncChangeValue.h"

const struct SyncChangeValueAttributes SyncChangeValueAttributes = {
	.name = @"name",
	.value = @"value",
	.valueType = @"valueType",
};

const struct SyncChangeValueRelationships SyncChangeValueRelationships = {
	.changeset = @"changeset",
	.syncEntity = @"syncEntity",
	.toMany = @"toMany",
	.toOne = @"toOne",
};

const struct SyncChangeValueFetchedProperties SyncChangeValueFetchedProperties = {
};

@implementation SyncChangeValueID
@end

@implementation _SyncChangeValue

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"SyncChangeValue" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"SyncChangeValue";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"SyncChangeValue" inManagedObjectContext:moc_];
}

- (SyncChangeValueID*)objectID {
	return (SyncChangeValueID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic name;






@dynamic value;






@dynamic valueType;






@dynamic changeset;

	

@dynamic syncEntity;

	

@dynamic toMany;

	
- (NSMutableSet*)toManySet {
	[self willAccessValueForKey:@"toMany"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"toMany"];
  
	[self didAccessValueForKey:@"toMany"];
	return result;
}
	

@dynamic toOne;

	






@end
