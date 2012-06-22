// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Note.h instead.

#import <CoreData/CoreData.h>
#import "GVCFoundation.h"

#import "GVCManagedObject.h"

GVC_DEFINE_EXTERN_STR(Note_ENTITY_NAME)


GVC_DEFINE_EXTERN_STR(Note_Attribute_content)

GVC_DEFINE_EXTERN_STR(Note_Attribute_creationDate)

GVC_DEFINE_EXTERN_STR(Note_Attribute_subject)


GVC_DEFINE_EXTERN_STR(Note_Relationship_category)


@class Category;





@interface NoteID : NSManagedObjectID {}
@end

@interface _Note : GVCManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (NoteID*)objectID;



@property (nonatomic, strong) NSString* content;

//- (BOOL)validateContent:(id*)value_ error:(NSError**)error_;



@property (nonatomic, strong) NSDate* creationDate;

//- (BOOL)validateCreationDate:(id*)value_ error:(NSError**)error_;



@property (nonatomic, strong) NSString* subject;

//- (BOOL)validateSubject:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) Category* category;
//- (BOOL)validateCategory:(id*)value_ error:(NSError**)error_;




@end

@interface _Note (CoreDataGeneratedAccessors)

@end

@interface _Note (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveContent;
- (void)setPrimitiveContent:(NSString*)value;




- (NSDate*)primitiveCreationDate;
- (void)setPrimitiveCreationDate:(NSDate*)value;




- (NSString*)primitiveSubject;
- (void)setPrimitiveSubject:(NSString*)value;





- (Category*)primitiveCategory;
- (void)setPrimitiveCategory:(Category*)value;


@end
