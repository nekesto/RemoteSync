//
//  SyscStatusTableViewController.h
//  MobileNotes
//
//  Created by David Aspinall on 12-06-24.
//  Copyright (c) 2012 Global Village Consulting. All rights reserved.
//

#import "GVCUIViewWithTableController.h"

@interface SyncStatusTableViewController : GVCUIViewWithTableController

- (void)startSync:(NSString *)message;
- (void)addStatus:(NSUInteger)item forTotal:(NSUInteger)total statusMessage:(NSString *)msg;
- (void)endSync:(NSString *)message;

@end
