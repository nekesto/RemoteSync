//
//  SyncParseAndLoadOperation.m
//  MobileNoteSync
//
//  Created by David Aspinall on 11-06-28.
//  Copyright 2011 Global Village Consulting Inc. All rights reserved.
//

#import "SyncParseAndLoadOperation.h"

#import "GVCFoundation.h"
#import "SyncPrincipal.h"
#import "SyncEntity.h"
#import "SyncXMLStatus.h"
#import "SyncXMLRecord.h"
#import "SyncXMLProperty.h"
#import "SyncXMLReference.h"

@implementation SyncParseAndLoadOperation

@synthesize model;
@synthesize netOperation;

- (NSDictionary *)xmlDigest
{
	GVCXMLDigester *irony = [[GVCXMLDigester alloc] init];
	switch ([netOperation type]) 
	{
		case SyncOperationType_REGISTER:
			[irony addRule:[GVCXMLDigesterRule ruleForCreateObject:@"SyncXMLStatus"] forNodeName:@"syncs"];
			[irony addRule:[GVCXMLDigesterRule ruleForSetPropertyText:@"principalUUID"] forNodeName:@"principalUUID"];
			[irony addRule:[GVCXMLDigesterRule ruleForSetPropertyText:@"lastSyncString"] forNodeName:@"lastSync"];
			break;
			
		case SyncOperationType_INITIAL:
		case SyncOperationType_FULL:
		case SyncOperationType_DELTA:
		{
			[irony addRule:[GVCXMLDigesterRule ruleForCreateObject:@"SyncXMLStatus"] forPattern:@"^syncs/status"];
			[irony addRule:[GVCXMLDigesterRule ruleForSetPropertyText:@"principalUUID"] forPattern:@"^syncs/status/principalUUID"];
			[irony addRule:[GVCXMLDigesterRule ruleForSetPropertyText:@"lastSyncString"] forPattern:@"^syncs/status/lastSync"];

			[irony addRule:[GVCXMLDigesterRule ruleForCreateObject:@"SyncXMLRecord"] forPattern:@"^syncs/data/[a-zA-Z0-9]*"];
			GVCXMLDigesterElementNamePropertyRule *elnameProp = [[GVCXMLDigesterElementNamePropertyRule alloc] initWithPropertyName:@"recordName"];
			[irony addRule:elnameProp forPattern:@"^syncs/data/[a-zA-Z0-9]*"];
			
			GVCXMLDigesterAttributeMapRule *attMapRule = [[GVCXMLDigesterAttributeMapRule alloc] initWithKeysAndValues:@"updatedDate", @"updatedDateString", @"id", @"recordUUID", @"status", @"recordStatus", nil];
			[irony addRule:attMapRule forPattern:@"^syncs/data/[a-zA-Z0-9]*"];
			

			[irony addRule:[GVCXMLDigesterRule ruleForCreateObject:@"SyncXMLProperty"] forPattern:@"^syncs/data/[a-zA-Z0-9]*/[a-zA-Z0-9]*"];
			[irony addRule:[GVCXMLDigesterRule ruleForParentChild:@"attribute"] forPattern:@"^syncs/data/[a-zA-Z0-9]*/[a-zA-Z0-9]*"];
			GVCXMLDigesterElementNamePropertyRule *attrNameProp = [[GVCXMLDigesterElementNamePropertyRule alloc] initWithPropertyName:@"name"];
			[irony addRule:attrNameProp forPattern:@"^syncs/data/[a-zA-Z0-9]*/[a-zA-Z0-9]*"];
			[irony addRule:[GVCXMLDigesterRule ruleForSetPropertyText:@"value"] forPattern:@"^syncs/data/[a-zA-Z0-9]*/[a-zA-Z0-9]*"];

			[irony addRule:[GVCXMLDigesterRule ruleForCreateObject:@"SyncXMLReference"] forPattern:@"^syncs/data/[a-zA-Z0-9]*/[a-zA-Z0-9]*/[a-zA-Z0-9]*"];
			[irony addRule:[GVCXMLDigesterRule ruleForParentChild:@"relation"] forPattern:@"^syncs/data/[a-zA-Z0-9]*/[a-zA-Z0-9]*/[a-zA-Z0-9]*"];
			GVCXMLDigesterElementNamePropertyRule *relationProp = [[GVCXMLDigesterElementNamePropertyRule alloc] initWithPropertyName:@"recordName"];
			[irony addRule:relationProp forPattern:@"^syncs/data/[a-zA-Z0-9]*/[a-zA-Z0-9]*/[a-zA-Z0-9]*"];
			
			GVCXMLDigesterAttributeMapRule *relMapRule = [[GVCXMLDigesterAttributeMapRule alloc] initWithKeysAndValues:@"updatedDate", @"updatedDateString", @"id", @"recordUUID", @"status", @"recordStatus", nil];
			[irony addRule:relMapRule forPattern:@"^syncs/data/[a-zA-Z0-9]*/[a-zA-Z0-9]*/[a-zA-Z0-9]*"];

			break;
		}
			
		default:
			break;
	}
	
	GVCNetResponseData *respData = [netOperation responseData];
	if ([respData isKindOfClass:[GVCMemoryResponseData class]] == YES) 
	{
		[irony setXmlData:[(GVCMemoryResponseData *)respData responseBody]];
	}
	else if ([respData isKindOfClass:[GVCStreamResponseData class]] == YES) 
	{
		[irony setFilename:[(GVCStreamResponseData *)respData responseFilename]];
	}
	
	@try {
		[irony parse];
	}
	@catch (NSException *exception) {
			// ignore
	}
	
	return ([irony status] == GVC_XML_ParserDelegateStatus_SUCCESS ? [irony digestDictionary] : nil );
}

#pragma mark - convenient Core Data 
- (NSEntityDescription *)entityForName:(NSString *)name
{
	GVC_ASSERT_VALID_STRING(name);

	NSEntityDescription *targetED = [NSEntityDescription entityForName:name inManagedObjectContext:[self managedObjectContext]];
	if ( targetED == nil )
	{
		NSString *msg = GVC_SPRINTF(@"Could not identify target object '%@'", name);
		[self operationDidFailWithError:[NSError gvc_ErrorWithDomain:@"SyncLoad" code:100 localizedDescription:msg]];
	}
	return targetED;
}

- (NSPropertyDescription *)propertyForName:(NSString *)name inEntity:(NSEntityDescription *)ent
{
	GVC_ASSERT_VALID_STRING(name);
	GVC_ASSERT(ent != nil, @"NSEntityDescription is required");

	NSPropertyDescription *prop = [ent gvc_propertyNamed:name];
	if ( prop == nil )
	{
		NSString *msg = GVC_SPRINTF(@"Could not identify target property '%@' in entity '%@'", name,  [ent name]);
		[self operationDidFailWithError:[NSError gvc_ErrorWithDomain:@"SyncLoad" code:100 localizedDescription:msg]];
	}
	return prop;
}

- (NSAttributeDescription *)attributeForName:(NSString *)name inEntity:(NSEntityDescription *)ent
{
	NSPropertyDescription *prop = [self propertyForName:name inEntity:ent];
	if ( [prop isKindOfClass:[NSAttributeDescription class]] == NO )
	{
		NSString *msg = GVC_SPRINTF(@"Could not identify target attribute '%@' in entity '%@.%@'", name,  [ent name], [prop name]);
		[self operationDidFailWithError:[NSError gvc_ErrorWithDomain:@"SyncLoad" code:100 localizedDescription:msg]];
	}
	return (NSAttributeDescription *)prop;
}

- (NSRelationshipDescription *)relationshipForName:(NSString *)name inEntity:(NSEntityDescription *)ent
{
	NSPropertyDescription *prop = [self propertyForName:name inEntity:ent];
	if ( [prop isKindOfClass:[NSRelationshipDescription class]] == NO )
	{
		NSString *msg = GVC_SPRINTF(@"Could not identify target relationship '%@' in entity '%@.%@'", name,  [ent name], [prop name]);
		[self operationDidFailWithError:[NSError gvc_ErrorWithDomain:@"SyncLoad" code:100 localizedDescription:msg]];
	}
	return (NSRelationshipDescription *)prop;
}

- (void)saveContext
{
	NSError *error = nil;
	if ([[self managedObjectContext] hasChanges] == YES)
	{
		if ([[self managedObjectContext] save:&error] == NO)
		{
			[self operationDidFailWithError:error];
			GVC_ASSERT_LOG(@"Save failed: %@\n%@", [error localizedDescription], [error userInfo]);
		} 
	}
}


#pragma mark - main logic

- (void)updateManagedObject:(NSManagedObject *)managed withRecord:(SyncXMLRecord *)candidate
{
	for ( SyncXMLProperty *prop in [[candidate attrbutes] allValues] )
	{
		NSPropertyDescription *propertyDesc = [self propertyForName:[prop name] inEntity:[managed entity]];
		if ( [propertyDesc isKindOfClass:[NSAttributeDescription class]] == YES )
		{
			[managed gvc_setConvertedValue:[prop value] forKey:[prop name]];
		}
		else if ( [propertyDesc isKindOfClass:[NSRelationshipDescription class]] == YES )
		{
			if ( gvc_IsEmpty([prop relations]) == NO )
			{
				for (SyncXMLReference *ref in [prop relations])
				{
					SyncEntity *refEntity = [SyncEntity entityForUUID:[ref recordUUID] context:[self managedObjectContext]];
					NSManagedObject *refObj = [refEntity businessObject];
					if ((refEntity != nil) && (refObj != nil))
					{
						NSString *selectorName = nil;
						SEL selector = nil;
						
						if ([(NSRelationshipDescription *)propertyDesc isToMany] == YES)
						{
							selectorName = GVC_SPRINTF( @"add%@Object:", [[propertyDesc name] gvc_StringWithCapitalizedFirstCharacter] );
							selector = NSSelectorFromString(selectorName);
							if ( [managed respondsToSelector:selector] == YES )
							{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
								[managed performSelector:selector withObject:refObj];
#pragma clang diagnostic pop
							}
						}
						else
						{
							[managed setValue:refObj forKey:[prop name]];
						}
					}
				}
			}
		}
		else
		{
				// WTF
		}
	}

}

- (SyncXMLRecord *)processRecord:(SyncXMLRecord *)candidate
{
	SyncXMLRecord *failed = nil;
	
	BOOL keepTrying = YES;
	NSManagedObject *target = nil;
	NSEntityDescription *targetED = [self entityForName:[candidate recordName]];
	
	SyncEntity *sEntity = [SyncEntity entityForUUID:[candidate recordUUID] context:[self managedObjectContext]];
	if ( sEntity != nil )
	{
		target = [sEntity businessObject];
	}
	
	if ( [[candidate recordStatus] isEqualToString:@"delete"] == YES )
	{
		if ( target != nil )
			[[self managedObjectContext] deleteObject:target];
		
		return nil;
	}

		// ensure all relations can be resolved
	for ( SyncXMLProperty *prop in [[candidate attrbutes] allValues] )
	{
		if ( gvc_IsEmpty([prop relations]) == NO )
		{
			for (SyncXMLReference *ref in [prop relations])
			{
				[self entityForName:[ref recordName]];
				SyncEntity *refEntity = [SyncEntity entityForUUID:[ref recordUUID] context:[self managedObjectContext]];
				if ( refEntity == nil )
				{
					failed = candidate;
					
						// missing target, if is not mandatory then we can keep trying
					NSRelationshipDescription *relation = [self relationshipForName:[prop name] inEntity:targetED];
					if ( [relation isOptional] == NO )
						keepTrying = NO;
				}
			}
		}
	}

	if ( keepTrying == NO )
	{
		return failed;
	}
	
		// ensure all mandatory attributes and relations have values
	for (NSPropertyDescription *prop in [targetED properties])
	{
		if ([prop isOptional] == NO)
		{
				// if target already has a value then ignore
			if ((target == nil) || ([target valueForKey:[prop name]] == nil))
			{
				SyncXMLProperty *canProp = [[candidate attrbutes] objectForKey:[prop name]];
				if ((canProp == nil) || ( ([canProp value] == nil) && ([canProp relations] == nil) ))
				{
						// no values to fulfil
					failed = candidate;
					keepTrying = NO;
				}
			}
		}
	}

	if ( keepTrying == NO )
	{
		return failed;
	}

	if (target == nil)
	{
			// no record yet, but everything should resolve, so insert
		target = [NSEntityDescription insertNewObjectForEntityForName:[targetED name] inManagedObjectContext:[self managedObjectContext]];
	}
	
	if ( target != nil )
	{
		[self updateManagedObject:target withRecord:candidate];
		if ((sEntity == nil) && ([target isInserted] == YES))
		{
				// need to create and update the SyncEntity
			[self saveContext];
			
			sEntity = [SyncEntity insertInManagedObjectContext:[self managedObjectContext]];
			[sEntity setName:[candidate recordName]];
			[sEntity setUuid:[candidate recordUUID]];
			[sEntity setBusinessObject:target];
			[self saveContext];
		}
	}
	
	return failed;
}

- (void)main
{
	[self initializeCoreData];
	
	[super operationDidStart];
	
	NSDictionary *resultsDigest = [self xmlDigest];
	SyncPrincipal *principal = [SyncPrincipal pseudoSingletonInContext:[self managedObjectContext]];
	
	switch ( [netOperation type] )
	{
		case SyncOperationType_REGISTER:
		{
			SyncXMLStatus *xmlSync = [resultsDigest objectForKey:@"syncs"];
			
			[principal setPrincipalId:[xmlSync principalUUID]];
			[principal setLastSync:[xmlSync lastSync]];
			
			break;
		}
		case SyncOperationType_INITIAL:
		case SyncOperationType_FULL:
		case SyncOperationType_DELTA:
		{
			NSMutableArray *processingFailed = [NSMutableArray arrayWithCapacity:0];
			for (NSString *key in [resultsDigest allKeys])
			{
				if ( [key isEqualToString:@"syncs/status"] == NO )
				{
					NSObject *data = [resultsDigest objectForKey:key];
					if ( [data isKindOfClass:[NSArray class]] == YES )
					{
						for (SyncXMLRecord *record in (NSArray *)data)
						{
							SyncXMLRecord *failed = [self processRecord:record];
							if ( failed != nil )
								[processingFailed addObject:failed];
						}
					}
					else
					{
						SyncXMLRecord *failed = [self processRecord:(SyncXMLRecord *)data];
						if ( failed != nil )
							[processingFailed addObject:failed];
					}
				}
				
				NSMutableArray *success = [NSMutableArray arrayWithCapacity:1];
				for (SyncXMLRecord *record in processingFailed)
				{
					SyncXMLRecord *failed = [self processRecord:record];
					if ( failed == nil )
						[success addObject:record];
				}
				[processingFailed removeObjectsInArray:success];
				[self saveContext];
			}
			SyncXMLStatus *xmlSync = [resultsDigest objectForKey:@"syncs/status"];
			
			[principal setLastSync:[xmlSync lastSync]];
			break;
		}
	}
	
	[[self managedObjectContext] save:nil];
	
	[self operationDidFinish];
}

@end
