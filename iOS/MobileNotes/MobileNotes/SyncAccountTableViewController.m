//
//  SyncAccountTableViewController.m
//  MobileNotes
//
//  Created by David Aspinall on 12-06-24.
//  Copyright (c) 2012 Global Village Consulting. All rights reserved.
//

#import "SyncAccountTableViewController.h"
#import "GVCAppDelegate.h"

@interface SyncAccountTableViewController ()

@end

@implementation SyncAccountTableViewController

@synthesize model;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - CoreData
- (NSEntityDescription *)entity
{
    return [[self principal] entity];
}

- (SyncPrincipal *)principal
{
	GVCAppDelegate *appDel = [[UIApplication sharedApplication] delegate];
	return [appDel principal];
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	
    [self setModel:[[GVCDataFormModel alloc] init]];
    [[self model] setDataObject:[self principal]];

	GVCDataFormSection *section = nil;
    section = [[self model] addSectionWithHeader:@"Login" andFooter:nil];
    [section addFormField:GVCDataFormFieldType_STRING withKeypath:SyncPrincipal_Attribute_username labelKey:SyncPrincipal_Attribute_username];
    [section addFormField:GVCDataFormFieldType_PASSWORD withKeypath:SyncPrincipal_Attribute_password labelKey:SyncPrincipal_Attribute_password];
    [section addFormField:GVCDataFormFieldType_URL withKeypath:SyncPrincipal_Attribute_site labelKey:SyncPrincipal_Attribute_site];

	section = [[self model] addSectionWithHeader:@"Sync" andFooter:nil];
    [section addImmutableFormField:GVCDataFormFieldType_DATE withKeypath:SyncPrincipal_Attribute_lastSync labelKey:SyncPrincipal_Attribute_lastSync];
    [section addImmutableFormField:GVCDataFormFieldType_STRING withKeypath:SyncPrincipal_Attribute_principalId labelKey:SyncPrincipal_Attribute_principalId];
    [section addImmutableFormField:GVCDataFormFieldType_STRING withKeypath:SyncPrincipal_Attribute_uuid labelKey:SyncPrincipal_Attribute_uuid];

}

#pragma UITableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tv 
{
    GVCDataFormModel *m = [self model];
    return [m sectionCount];
}

- (NSString *)tableView:(UITableView *)tv titleForHeaderInSection:(NSInteger)section 
{
    GVCDataFormSection *dataSection = [[self model] sectionAtIndex:section];
	return (dataSection == nil ? nil : [dataSection headerText]);
}


	// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tv numberOfRowsInSection:(NSInteger)section 
{
    GVCDataFormSection *dataSection = [[self model] sectionAtIndex:section];
	return (dataSection == nil ? 0 : [dataSection formFieldCount]);
}

- (UITableViewCell *)tableView:(UITableView *)tv cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
    UITableViewCell *cell = nil;
    
    GVCDataFormField *field = [[self model] fieldAtIndexPath:indexPath];
    if (field != nil )
    {
        switch ([field type]) 
        {
            case GVCDataFormFieldType_STRING:
            case GVCDataFormFieldType_PASSWORD:
            case GVCDataFormFieldType_URL:
                if ( [field isMutable] == YES )
                {
                    cell = [self textEditCell:tv withField:field atIndex:indexPath];
                }
                else
                {
                    cell = [self displayCell:tv  withField:field atIndex:indexPath];
                }
				
                break;
				
            case GVCDataFormFieldType_DATE:
                cell = [self dateEditCell:tv withField:field atIndex:indexPath];
                break;
				
				
            default:
                break;
        }
    }
	
    return cell;
}

#pragma mark - edit cells
- (void) gvcEditCell:(GVCEditTextFieldCell *)editableCell textChangedTo:(NSString *)newText
{
    NSIndexPath *indexPath = [editableCell editPath];
    GVCDataFormField *field = [[self model] fieldAtIndexPath:indexPath];
    [[self model] setValue:newText forField:field];
    GVCCoreDataUIAppDelegate *appDel = [[UIApplication sharedApplication] delegate];
    [appDel saveContext];
}

#pragma mark - display cells
- (UITableViewCell *)displayCell:(UITableView *)tv withField:(GVCDataFormField *)attrib atIndex:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [GVCMultiLineTableViewCell gvc_CellWithStyle:UITableViewCellStyleValue2 forTableView:tv];
    [[cell textLabel] setAdjustsFontSizeToFitWidth:YES];
    [[cell detailTextLabel] setLineBreakMode:UILineBreakModeWordWrap];
	
	NSAttributeDescription *attDesc = [[self entity] gvc_attributeNamedKeypath:[attrib keypath]];
    
    [[cell textLabel] setText:[attDesc gvc_localizedName]];
    [[cell detailTextLabel] setText:[[self model] dataValueForField:attrib]];
    
    return cell;
}

- (UITableViewCell *)dateEditCell:(UITableView *)tv withField:(GVCDataFormField *)attrib atIndex:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [GVCEditDateCell gvc_CellWithStyle:UITableViewCellStyleValue2 forTableView:tv];
	if ( [attrib isMutable] == YES )
		[cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
	
	NSAttributeDescription *attDesc = [[self entity] gvc_attributeNamedKeypath:[attrib keypath]];
    [[cell textLabel] setText:[attDesc gvc_localizedName]];
    [[cell textLabel] setAdjustsFontSizeToFitWidth:YES];
    NSDate *date = [[self model] dataValueForField:attrib];
    [[cell detailTextLabel] setText:[date gvc_FormattedStyle:NSDateFormatterFullStyle]];
    
    [(GVCEditCell *)cell setEditPath:indexPath];
    return cell;
}


- (UITableViewCell *)textEditCell:(UITableView *)tv withField:(GVCDataFormField *)attrib atIndex:(NSIndexPath *)indexPath
{
    GVCEditTextFieldCell *cell = [GVCEditTextFieldCell gvc_CellWithStyle:UITableViewCellStyleValue2 forTableView:tv];
    
	NSAttributeDescription *attDesc = [[self entity] gvc_attributeNamedKeypath:[attrib keypath]];
    [[cell textLabel] setText:[attDesc gvc_localizedName]];
    [[cell textLabel] setAdjustsFontSizeToFitWidth:YES];
	
    [[(GVCEditTextFieldCell *)cell textField] setText:[[self model] dataValueForField:attrib]];
    [[(GVCEditTextFieldCell *)cell textField] setSecureTextEntry:( [attrib type] == GVCDataFormFieldType_PASSWORD )];
		
    [(GVCUITableViewCell *)cell setDelegate:self];
    [(GVCEditCell *)cell setEditPath:indexPath];
    
    return cell;
}

@end
