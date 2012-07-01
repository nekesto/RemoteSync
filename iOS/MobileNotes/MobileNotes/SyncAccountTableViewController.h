//
//  SyncAccountTableViewController.h
//  MobileNotes
//
//  Created by David Aspinall on 12-06-24.
//  Copyright (c) 2012 Global Village Consulting. All rights reserved.
//

#import "GVCUIViewWithTableController.h"
#import "GVCUIKit.h"

#import "ERSync.h"

@interface SyncAccountTableViewController : GVCUIViewWithTableController

@property (strong, nonatomic) GVCDataFormModel *model;

- (SyncPrincipal *)principal;

@end
