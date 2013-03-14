//
//  NoteEditTableViewController.h
//  MobileNotes
//
//  Created by David Aspinall on 12-06-24.
//  Copyright (c) 2012 Global Village Consulting. All rights reserved.
//

#import <GVCFoundation/GVCFoundation.h>
#import <GVCUIKit/GVCUIKit.h>
#import <GVCCoreData/GVCCoreData.h>
#import <ERSync/ERSync.h>

@class Note;

@interface NoteEditTableViewController : GVCUIViewWithTableController

@property (strong, nonatomic) GVCDataFormModel *model;
@property (strong, nonatomic) UIPopoverController *popover;
@property (strong, nonatomic) Note *note;

- (IBAction)saveAction:(id)sender;
- (IBAction)cancelAction:(id)sender;

@end
