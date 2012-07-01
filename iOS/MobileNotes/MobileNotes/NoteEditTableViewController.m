//
//  NoteEditTableViewController.m
//  MobileNotes
//
//  Created by David Aspinall on 12-06-24.
//  Copyright (c) 2012 Global Village Consulting. All rights reserved.
//

#import "NoteEditTableViewController.h"
#import "GVCFoundation.h"
#import "GVCCoreData.h"

#import "Note.h"
#import "Category.h"

@interface NoteEditTableViewController ()

@end

@implementation NoteEditTableViewController

@synthesize popover;
@synthesize note;
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
	[self setPopover:nil];
	[self setNote:nil];
	[self setModel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (void)setNote:(Note *)anote
{
	[[self tableView] endEditing:YES];

	note = anote;
	
    [self setModel:[[GVCDataFormModel alloc] init]];
    [[self model] setDataObject:note];
	
    GVCDataFormSection *section = nil;
	
    section = [[self model] addSectionWithHeader:@"Category" andFooter:nil];
    [section addImmutableFormField:GVCDataFormFieldType_STRING withKeypath:@"category.name" labelKey:CategoryAttributes.name];
    
    section = [[self model] addSectionWithHeader:@"Note" andFooter:nil];
    [section addImmutableFormField:GVCDataFormFieldType_DATE withKeypath:NoteAttributes.creationDate labelKey:NoteAttributes.creationDate];
    [section addFormField:GVCDataFormFieldType_STRING withKeypath:NoteAttributes.subject labelKey:NoteAttributes.subject];
    [section addFormField:GVCDataFormFieldType_STRING withKeypath:NoteAttributes.content labelKey:NoteAttributes.content];

    [section addFormField:GVCDataFormFieldType_BUTTON withKeypath:@"saveAction:" labelKey:GVC_SAVE_LABEL];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - CoreData
- (NSEntityDescription *)entity
{
    return [[self note] entity];
}

- (IBAction)saveAction:(id)sender 
{
	[[self tableView] endEditing:YES];
    GVCCoreDataUIAppDelegate *appDel = [[UIApplication sharedApplication] delegate];
    [appDel saveContext];
}

- (IBAction)cancelAction:(id)sender
{
}

#pragma mark - Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tv 
{
    GVCDataFormModel *m = [self model];
    return [m sectionCount];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section 
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


	// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tv cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
    UITableViewCell *cell = nil;
    
    GVCDataFormField *field = [[self model] fieldAtIndexPath:indexPath];
    if (field != nil )
    {
        switch ([field type]) 
        {
            case GVCDataFormFieldType_STRING:
                if ( [field isMutable] == YES )
                {
                    cell = [self textEditCell:tv withAttribute:[[self entity] gvc_attributeNamedKeypath:[field keypath]] atIndex:indexPath];
                }
                else
                {
                    cell = [self displayCell:tv  withField:field atIndex:indexPath];
                }
				
                break;
                
            case GVCDataFormFieldType_DATE:
                cell = [self dateEditCell:tv withField:field atIndex:indexPath];
                break;
				
            case GVCDataFormFieldType_URL:
//                cell = [self urlEditCell:tv withAttribute:[[self entity] gvc_attributeNamed:[field keypath]] atIndex:indexPath];
                break;

			case GVCDataFormFieldType_BUTTON:
				cell = [self buttonCell:tv withField:field atIndex:indexPath];
                break;

            default:
                break;
        }
    }
	
    return cell;
}

- (NSIndexPath *)tableView:(UITableView *)tv willSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
    GVCDataFormField *field = [[self model] fieldAtIndexPath:indexPath];
    if ((field != nil) && ([field isMutable] == YES))
    {
        [[self tableView] endEditing:YES];
		
        switch ([field type]) 
        {
            case GVCDataFormFieldType_STRING:
                break;
                
            case GVCDataFormFieldType_DATE:
//                [self showDatePicker:tv withAttribute:[[self entity] gvc_attributeNamed:[field keypath]] atIndex:indexPath];
                break;
                
            case GVCDataFormFieldType_URL:
//                [self showCodedVauePicker:tv withAttribute:[[self entity] gvc_attributeNamed:[field keypath]] atIndex:indexPath];
                break;
            default:
                break;
        }
    }
    [tv deselectRowAtIndexPath:indexPath animated:YES];
    return nil;
}

#pragma mark - edit cells
- (void) gvcEditCell:(GVCEditTextFieldCell *)editableCell textChangedTo:(NSString *)newText
{
    NSIndexPath *indexPath = [editableCell editPath];
    GVCDataFormField *field = [[self model] fieldAtIndexPath:indexPath];
    [[self model] setValue:newText forField:field];
}

#pragma mark - display cells
- (UITableViewCell *)displayCell:(UITableView *)tv withField:(GVCDataFormField *)attrib atIndex:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [GVCMultiLineTableViewCell gvc_CellWithStyle:UITableViewCellStyleValue2 forTableView:tv];
    [[cell textLabel] setAdjustsFontSizeToFitWidth:YES];
    [[cell detailTextLabel] setLineBreakMode:UILineBreakModeWordWrap];
	
	NSAttributeDescription *attDesc = [[self entity] gvc_attributeNamedKeypath:[attrib keypath]];
    
    [[cell textLabel] setText:[attDesc gvc_localizedName]];
    [[cell detailTextLabel] setText:[[self note] valueForKeyPath:[attrib keypath]]];
    
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
    NSDate *date = [[self note] valueForKeyPath:[attrib keypath]];
    [[cell detailTextLabel] setText:[date gvc_FormattedStyle:NSDateFormatterMediumStyle]];
    
    [(GVCEditCell *)cell setEditPath:indexPath];
    return cell;
}


- (UITableViewCell *)textEditCell:(UITableView *)tv withAttribute:(NSAttributeDescription *)attrib atIndex:(NSIndexPath *)indexPath
{
    GVCEditTextFieldCell *cell = [GVCEditTextFieldCell gvc_CellWithStyle:UITableViewCellStyleValue2 forTableView:tv];
    
    [[cell textLabel] setText:[attrib gvc_localizedName]];
    [[cell textLabel] setAdjustsFontSizeToFitWidth:YES];
    [[(GVCEditTextFieldCell *)cell textField] setPlaceholder:[attrib name]];
    [[(GVCEditTextFieldCell *)cell textField] setText:[[self note] valueForKey:[attrib name]]];
    
    [(GVCUITableViewCell *)cell setDelegate:self];
    [(GVCEditCell *)cell setEditPath:indexPath];
    
    return cell;
}

- (UITableViewCell *)buttonCell:(UITableView *)tv withField:(GVCDataFormField *)attrib atIndex:(NSIndexPath *)indexPath
{
    GVCButtonCell *cell = [GVCButtonCell gvc_CellWithStyle:UITableViewCellStyleValue2 forTableView:tv];
    
    [(GVCButtonCell *)cell setTitle:[attrib localizedLabelKey]];
    [(GVCButtonCell *)cell addTarget:self action:NSSelectorFromString([attrib keypath])];
	UIImage *newImage = [[UIImage imageNamed:@"blueButton.png"] stretchableImageWithLeftCapWidth:12.0 topCapHeight:0.0];
	[[(GVCButtonCell *)cell button] setBackgroundImage:newImage forState:UIControlStateNormal];

    return cell;
}


@end
