//
//  SyncResetLocalDatabaseOperation.h
//  MobileNoteSync
//
//  Created by David Aspinall on 11-06-28.
//  Copyright 2011 Global Village Consulting Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <GVCFoundation/GVCFoundation.h>
#import <GVCCoreData/GVCCoreData.h>

@interface SyncResetLocalDatabaseOperation : GVCDataOperation

@property (strong, nonatomic) NSManagedObjectModel *model;

@end
