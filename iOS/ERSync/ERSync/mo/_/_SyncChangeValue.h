// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to SyncChangeValue.h instead.

#import <CoreData/CoreData.h>
#import <GVCCoreData/GVCCoreData.h>

extern const struct SyncChangeValueAttributes {
	__unsafe_unretained NSString *name;
	__unsafe_unretained NSString *value;
	__unsafe_unretained NSString *valueType;
} SyncChangeValueAttributes;

extern const struct SyncChangeValueRelationships {
	__unsafe_unretained NSString *changeset;
	__unsafe_unretained NSString *syncEntity;
	__unsafe_unretained NSString *toMany;
	__unsafe_unretained NSString *toOne;
} SyncChangeValueRelationships;

extern const struct SyncChangeValueFetchedProperties {
} SyncChangeValueFetchedProperties;

@class SyncChangeset;
@class SyncEntity;
@class SyncEntity;
@class SyncEntity;





@interface SyncChangeValueID : NSManagedObjectID {}
@end

@interface _SyncChangeValue : GVCManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (SyncChangeValueID*)objectID;





@property (nonatomic, strong) NSString* name;



//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* value;



//- (BOOL)validateValue:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* valueType;



//- (BOOL)validateValueType:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) SyncChangeset *changeset;

//- (BOOL)validateChangeset:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) SyncEntity *syncEntity;

//- (BOOL)validateSyncEntity:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSSet *toMany;

- (NSMutableSet*)toManySet;




@property (nonatomic, strong) SyncEntity *toOne;

//- (BOOL)validateToOne:(id*)value_ error:(NSError**)error_;





@end

@interface _SyncChangeValue (CoreDataGeneratedAccessors)

- (void)addToMany:(NSSet*)value_;
- (void)removeToMany:(NSSet*)value_;
- (void)addToManyObject:(SyncEntity*)value_;
- (void)removeToManyObject:(SyncEntity*)value_;

@end

@interface _SyncChangeValue (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;




- (NSString*)primitiveValue;
- (void)setPrimitiveValue:(NSString*)value;




- (NSString*)primitiveValueType;
- (void)setPrimitiveValueType:(NSString*)value;





- (SyncChangeset*)primitiveChangeset;
- (void)setPrimitiveChangeset:(SyncChangeset*)value;



- (SyncEntity*)primitiveSyncEntity;
- (void)setPrimitiveSyncEntity:(SyncEntity*)value;



- (NSMutableSet*)primitiveToMany;
- (void)setPrimitiveToMany:(NSMutableSet*)value;



- (SyncEntity*)primitiveToOne;
- (void)setPrimitiveToOne:(SyncEntity*)value;


@end
