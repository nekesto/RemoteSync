//
//  SyncOperation.h
//  MobileNoteSync
//
//  Created by David Aspinall on 11-06-28.
//  Copyright 2011 Global Village Consulting Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <GVCFoundation/GVCFoundation.h>

typedef enum _SyncOperationType {
	SyncOperationType_REGISTER,
	SyncOperationType_INITIAL,
	SyncOperationType_FULL,
	SyncOperationType_DELTA
} SyncOperationType;

@interface SyncOperation : GVCHTTPOperation

@property (assign) SyncOperationType type;

+ (NSURL *)registerURL:(NSString *)site;
+ (NSURL *)indexURL:(NSString *)site;
+ (NSURL *)initialURL:(NSString *)site;
+ (NSURL *)fullSlowURL:(NSString *)site;
+ (NSURL *)fullFastURL:(NSString *)site;

@end
