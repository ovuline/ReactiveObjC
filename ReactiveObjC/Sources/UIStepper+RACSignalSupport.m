//
//  UIStepper+RACSignalSupport.m
//  ReactiveObjC
//
//  Created by Uri Baghin on 20/07/2013.
//  Copyright (c) 2013 GitHub, Inc. All rights reserved.
//

#import "../Headers/Public/UIStepper+RACSignalSupport.h"
#import "../Headers/Public/EXTKeyPathCoding.h"
#import "../Headers/Private/UIControl+RACSignalSupportPrivate.h"

@implementation UIStepper (RACSignalSupport)

- (RACChannelTerminal *)rac_newValueChannelWithNilValue:(NSNumber *)nilValue {
	return [self rac_channelForControlEvents:UIControlEventValueChanged key:@keypath(self.value) nilValue:nilValue];
}

@end
