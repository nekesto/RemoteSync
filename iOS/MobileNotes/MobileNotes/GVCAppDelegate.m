//
//  GVCAppDelegate.m
//  MobileNotes
//
//  Created by David Aspinall on 12-06-21.
//  Copyright (c) 2012 Global Village Consulting. All rights reserved.
//

#import "GVCAppDelegate.h"
#import "GVCMasterViewController.h"
#import "Note.h"
#import "Category.h"

GVC_DEFINE_STRVALUE(SYNC_APP_ID, 0c424873-2f0d-4746-b2d5-1735f51d9f52)
GVC_DEFINE_STRVALUE(SYNC_DEVICE_IPAD, 743E2D47-DDA4-4827-A164-0C61547CD4D5)

@implementation GVCAppDelegate

@synthesize engine;
@synthesize principal;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	[super application:application didFinishLaunchingWithOptions:launchOptions];
	
    // Override point for customization after application launch.
	UISplitViewController *splitViewController = (UISplitViewController *)self.window.rootViewController;
	UINavigationController *navigationController = [splitViewController.viewControllers lastObject];
	splitViewController.delegate = (id)navigationController.topViewController;

	UINavigationController *masterNavigationController = [splitViewController.viewControllers objectAtIndex:0];
	GVCMasterViewController *controller = (GVCMasterViewController *)masterNavigationController.topViewController;
	controller.managedObjectContext = self.managedObjectContext;
	
	[self setEngine:[[SyncEngine alloc] initWithEditingContext:[self managedObjectContext]]];
	[[self engine] addSupportedEntity:[Note entityName]];
	[[self engine] addSupportedEntity:[Category entityName]];

	SyncPrincipal *prince = [SyncPrincipal pseudoSingletonInContext:[self managedObjectContext]];
	if ( prince == nil )
	{
		prince = [SyncPrincipal insertInManagedObjectContext:[self managedObjectContext]];
		[prince setUsername:@"david"];
		[prince setPassword:@"tester"];
		[prince setSite:@"http://localhost:8111/cgi-bin/WebObjects/MobileNotesSync.woa"];
		[self saveContext];
	}
	[self setPrincipal:prince];

    return YES;
}

- (void)syncEngineDidReset
{
	SyncPrincipal *prince = [SyncPrincipal pseudoSingletonInContext:[self managedObjectContext]];
	if ( prince == nil )
	{
		prince = [SyncPrincipal insertInManagedObjectContext:[self managedObjectContext]];
		[prince setUsername:@"david"];
		[prince setPassword:@"tester"];
		[prince setSite:@"http://localhost:8111/cgi-bin/WebObjects/MobileNotesSync.woa"];
		[self saveContext];
	}
	[self setPrincipal:prince];
}

@end
