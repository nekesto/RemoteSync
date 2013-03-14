//
//  SyscStatusTableViewController.m
//  MobileNotes
//
//  Created by David Aspinall on 12-06-24.
//  Copyright (c) 2012 Global Village Consulting. All rights reserved.
//

#import "SyncStatusTableViewController.h"
#import <GVCFoundation/GVCFoundation.h>
#import <GVCUIKit/GVCUIKit.h>
#import <GVCCoreData/GVCCoreData.h>
#import <ERSync/ERSync.h>

#import "GVCAppDelegate.h"

@interface SyncStatusTableViewController ()
@property (strong, nonatomic) NSMutableArray *msgList;
@property (assign) NSUInteger indent;
@end

@implementation SyncStatusTableViewController

@synthesize msgList;
@synthesize indent;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (GVCAppDelegate *)applicationDelegate
{
	return (GVCAppDelegate *)[[UIApplication sharedApplication] delegate];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - status

- (void)addMessage:(NSString *)msg 
{
	if ( [self msgList] == nil )
	{
		[self setMsgList:[[NSMutableArray alloc] initWithCapacity:10]];
	}
	[[self msgList] addObject:msg];
	[[self tableView] gvc_scrollToBottom:YES];
}

- (void)startSync:(NSString *)message
{
	if ( gvc_IsEmpty(message) == NO )
	{
		[self addMessage:message];
	}
	[self setIndent:[self indent]+1];
}

- (void)addStatus:(NSUInteger)item forTotal:(NSUInteger)total statusMessage:(NSString *)msg
{
	if ( gvc_IsEmpty(msg) == NO )
	{
		NSString *message = msg;
		if ( total > 0 )
		{
			message = GVC_SPRINTF(@"Step %d of %d: %@", item, total, msg);
		}
		[self addMessage:message];
	}
}

- (void)endSync:(NSString *)message
{
	[self setIndent:MAX([self indent]-1, 0U)];
	if ( gvc_IsEmpty(message) == NO )
	{
		[self addMessage:message];
	}
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tv 
{
    return 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section 
{
	return nil;
}


	// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tv numberOfRowsInSection:(NSInteger)section 
{
    return [[self msgList] count];
}


	// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tv cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
	GVCMultiLineTableViewCell *cell = [GVCMultiLineTableViewCell gvc_CellWithStyle:UITableViewCellStyleDefault forTableView:tv];
	[[(GVCMultiLineTableViewCell *)cell textView] setText:[[self msgList] objectAtIndex:[indexPath row]]];
	return cell;
}

static CGFloat kHPadding = 10;
static CGFloat kVPadding = 10;
static CGFloat kMargin = 10;

- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath 
{
	CGSize size = CGSizeZero;
	CGFloat maxWidth = [tableView bounds].size.width - (kHPadding*2 + kMargin*2);

	UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
	UILabel *label = [cell textLabel];
	if ( [cell isKindOfClass:[GVCMultiLineTableViewCell class]] == YES)
	{
		label = [(GVCMultiLineTableViewCell *)cell textView];
	}

	size = [[label text] sizeWithFont:[label font] constrainedToSize:CGSizeMake(maxWidth, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
	if (size.height < 20) 
	{
		size.height = 20;
	}
	
	return size.height + kVPadding*2;
}


@end
