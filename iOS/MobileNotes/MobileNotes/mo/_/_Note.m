// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Note.m instead.

#import "_Note.h"

GVC_DEFINE_STRVALUE(Note_ENTITY_NAME, Note)

GVC_DEFINE_STRVALUE(Note_Attribute_content, content)
GVC_DEFINE_STRVALUE(Note_Attribute_creationDate, creationDate)
GVC_DEFINE_STRVALUE(Note_Attribute_subject, subject)

GVC_DEFINE_STRVALUE(Note_Relationship_category, category)

@implementation NoteID
@end

@implementation _Note

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:Note_ENTITY_NAME inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return Note_ENTITY_NAME;
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:Note_ENTITY_NAME inManagedObjectContext:moc_];
}

- (NoteID*)objectID {
	return (NoteID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic content;






@dynamic creationDate;






@dynamic subject;






@dynamic category;

	





@end
