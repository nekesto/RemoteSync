// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Category.m instead.

#import "_Category.h"

GVC_DEFINE_STRVALUE(Category_ENTITY_NAME, Category)

GVC_DEFINE_STRVALUE(Category_Attribute_name, name)

GVC_DEFINE_STRVALUE(Category_Relationship_notes, notes)

@implementation CategoryID
@end

@implementation _Category

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:Category_ENTITY_NAME inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return Category_ENTITY_NAME;
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:Category_ENTITY_NAME inManagedObjectContext:moc_];
}

- (CategoryID*)objectID {
	return (CategoryID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic name;






@dynamic notes;

	
- (NSMutableSet*)notesSet {
	[self willAccessValueForKey:Category_Relationship_notes];
	NSMutableSet *result = [self mutableSetValueForKey:Category_Relationship_notes];
	[self didAccessValueForKey:Category_Relationship_notes];
	return result;
}
	





@end
