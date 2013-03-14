// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to SyncChangeset.h instead.

#import <CoreData/CoreData.h>
#import <GVCCoreData/GVCCoreData.h>

extern const struct SyncChangesetAttributes {
	__unsafe_unretained NSString *updatedDate;
	__unsafe_unretained NSString *uuid;
} SyncChangesetAttributes;

extern const struct SyncChangesetRelationships {
	__unsafe_unretained NSString *changes;
} SyncChangesetRelationships;

extern const struct SyncChangesetFetchedProperties {
} SyncChangesetFetchedProperties;

@class SyncChangeValue;




@interface SyncChangesetID : NSManagedObjectID {}
@end

@interface _SyncChangeset : GVCManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (SyncChangesetID*)objectID;





@property (nonatomic, strong) NSDate* updatedDate;



//- (BOOL)validateUpdatedDate:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* uuid;



//- (BOOL)validateUuid:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSSet *changes;

- (NSMutableSet*)changesSet;





@end

@interface _SyncChangeset (CoreDataGeneratedAccessors)

- (void)addChanges:(NSSet*)value_;
- (void)removeChanges:(NSSet*)value_;
- (void)addChangesObject:(SyncChangeValue*)value_;
- (void)removeChangesObject:(SyncChangeValue*)value_;

@end

@interface _SyncChangeset (CoreDataGeneratedPrimitiveAccessors)


- (NSDate*)primitiveUpdatedDate;
- (void)setPrimitiveUpdatedDate:(NSDate*)value;




- (NSString*)primitiveUuid;
- (void)setPrimitiveUuid:(NSString*)value;





- (NSMutableSet*)primitiveChanges;
- (void)setPrimitiveChanges:(NSMutableSet*)value;


@end
