//
//  SyncAccountTableViewController.h
//  MobileNotes
//
//  Created by David Aspinall on 12-06-24.
//  Copyright (c) 2012 Global Village Consulting. All rights reserved.
//

#import <GVCFoundation/GVCFoundation.h>
#import <GVCUIKit/GVCUIKit.h>
#import <GVCCoreData/GVCCoreData.h>
#import <ERSync/ERSync.h>

@interface SyncAccountTableViewController : GVCUIViewWithTableController

@property (strong, nonatomic) GVCDataFormModel *model;

- (SyncPrincipal *)principal;

@end
