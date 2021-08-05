//
//  NSArray+RACSequenceAdditions.m
//  ReactiveObjC
//
//  Created by Justin Spahr-Summers on 2012-10-29.
//  Copyright (c) 2012 GitHub. All rights reserved.
//

#import "../Headers/Public/NSArray+RACSequenceAdditions.h"
#import "../Headers/Private/RACArraySequence.h"

@implementation NSArray (RACSequenceAdditions)

- (RACSequence *)rac_sequence {
	return [RACArraySequence sequenceWithArray:self offset:0];
}

@end
