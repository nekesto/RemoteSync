//
//  SyncResetLocalDatabaseOperation.m
//  MobileNoteSync
//
//  Created by David Aspinall on 11-06-28.
//  Copyright 2011 Global Village Consulting Inc. All rights reserved.
//

#import "SyncResetLocalDatabaseOperation.h"


@implementation SyncResetLocalDatabaseOperation

@synthesize model;

- (void)main
{
	[self initializeCoreData];
	
	[super operationDidStart];
	NSArray *entities = [model entities];
	for (NSEntityDescription *entity in entities)
	{
		[self operationProgress:([entities indexOfObject:entity] + 1) forTotal:[entities count] statusMessage:GVC_SPRINTF(@"Deleting all records from %@", [entity name])];
		
		NSFetchRequest *request = [[NSFetchRequest alloc] init];
		[request setEntity:entity];
		
		NSArray *array = [[self managedObjectContext] executeFetchRequest:request error:nil];
		for (NSManagedObject *mo in array)
		{
			[[self managedObjectContext] deleteObject:mo];
		}
	}
	[[self managedObjectContext] save:nil];
	
	[self operationDidFinish];
}

@end
