//
//  NoteEditTableViewController.h
//  MobileNotes
//
//  Created by David Aspinall on 12-06-24.
//  Copyright (c) 2012 Global Village Consulting. All rights reserved.
//

#import "GVCUIViewWithTableController.h"
#import "GVCUIKit.h"

@class Note;

@interface NoteEditTableViewController : GVCUIViewWithTableController

@property (strong, nonatomic) GVCDataFormModel *model;
@property (strong, nonatomic) UIPopoverController *popover;
@property (strong, nonatomic) Note *note;

- (IBAction)saveAction:(id)sender;
- (IBAction)cancelAction:(id)sender;

@end
