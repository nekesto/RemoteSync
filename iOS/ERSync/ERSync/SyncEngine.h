//
//  SyncEngine.h
//  MobileNoteSync
//
//  Created by David Aspinall on 11-06-29.
//  Copyright 2011 Global Village Consulting Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface SyncEngine : NSObject 

- (id)initWithEditingContext:(NSManagedObjectContext *)context;
- (void)addSupportedEntity:(NSString *)entityName;

- (NSArray *)syncEntities;

@property (assign) BOOL active;

@end
