//
//  SyncOperation.m
//  MobileNoteSync
//
//  Created by David Aspinall on 11-06-28.
//  Copyright 2011 Global Village Consulting Inc. All rights reserved.
//

#import "SyncOperation.h"

#import "SyncXMLStatus.h"


@implementation SyncOperation

@synthesize type;

- (id)initForRequest:(NSURLRequest *)req
{
	self = [super initForRequest:req];
	if ( self != nil )
	{
		[self setAcceptableContentTypes:[NSSet setWithObject:@"text/xml"]];
	}
	return self;
}

+ (NSURL *)registerURL:(NSString *)site
{
	NSURL *base = [NSURL URLWithString:site];
	return [base URLByAppendingPathComponent:@"sync/register/new"];
}

+ (NSURL *)indexURL:(NSString *)site
{
	NSURL *base = [NSURL URLWithString:site];
	return [base URLByAppendingPathComponent:@"sync/initial/index"];
}

+ (NSURL *)initialURL:(NSString *)site
{
	NSURL *base = [NSURL URLWithString:site];
	return [base URLByAppendingPathComponent:@"sync/initial/full"];
}

+ (NSURL *)fullSlowURL:(NSString *)site
{
	NSURL *base = [NSURL URLWithString:site];
	return [base URLByAppendingPathComponent:@"sync/slow/full"];
}

+ (NSURL *)fullFastURL:(NSString *)site
{
	NSURL *base = [NSURL URLWithString:site];
	return [base URLByAppendingPathComponent:@"sync/fast/full"];
}


@end
