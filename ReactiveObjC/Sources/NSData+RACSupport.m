//
//  NSData+RACSupport.m
//  ReactiveObjC
//
//  Created by Josh Abernathy on 5/11/12.
//  Copyright (c) 2012 GitHub, Inc. All rights reserved.
//

#import "../Headers/Public/NSData+RACSupport.h"
#import "../Headers/Public/RACReplaySubject.h"
#import "../Headers/Public/RACScheduler.h"

@implementation NSData (RACSupport)

+ (RACSignal *)rac_readContentsOfURL:(NSURL *)URL options:(NSDataReadingOptions)options scheduler:(RACScheduler *)scheduler {
	NSCParameterAssert(scheduler != nil);
	
	RACReplaySubject *subject = [RACReplaySubject subject];
	[subject setNameWithFormat:@"+rac_readContentsOfURL: %@ options: %lu scheduler: %@", URL, (unsigned long)options, scheduler];
	
	[scheduler schedule:^{
		NSError *error = nil;
		NSData *data = [[NSData alloc] initWithContentsOfURL:URL options:options error:&error];
		if (data == nil) {
			[subject sendError:error];
		} else {
			[subject sendNext:data];
			[subject sendCompleted];
		}
	}];
	
	return subject;
}

@end
