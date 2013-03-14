//
//  SyncParseAndLoadOperation.h
//  MobileNoteSync
//
//  Created by David Aspinall on 11-06-28.
//  Copyright 2011 Global Village Consulting Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

#import <GVCCoreData/GVCCoreData.h>

#import "SyncOperation.h"

@interface SyncParseAndLoadOperation : GVCDataOperation
{
    NSManagedObjectModel *model;
	SyncOperation *netOperation;
}

@property (strong, nonatomic) NSManagedObjectModel *model;
@property (strong, nonatomic) SyncOperation *netOperation;
    

@end
