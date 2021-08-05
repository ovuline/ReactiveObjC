//
//  UITextField+RACSignalSupport.m
//  ReactiveObjC
//
//  Created by Josh Abernathy on 4/17/12.
//  Copyright (c) 2012 GitHub, Inc. All rights reserved.
//

#import "../Headers/Public/UITextField+RACSignalSupport.h"
#import "../Headers/Public/EXTKeyPathCoding.h"
#import "../Headers/Public/EXTScope.h"
#import "../Headers/Public/NSObject+RACDeallocating.h"
#import "../Headers/Private/NSObject+RACDescription.h"
#import "../Headers/Public/RACSignal+Operations.h"
#import "../Headers/Public/UIControl+RACSignalSupport.h"
#import "../Headers/Private/UIControl+RACSignalSupportPrivate.h"

@implementation UITextField (RACSignalSupport)

- (RACSignal *)rac_textSignal {
	@weakify(self);
	return [[[[[RACSignal
		defer:^{
			@strongify(self);
			return [RACSignal return:self];
		}]
		concat:[self rac_signalForControlEvents:UIControlEventAllEditingEvents]]
		map:^(UITextField *x) {
			return x.text;
		}]
		takeUntil:self.rac_willDeallocSignal]
		setNameWithFormat:@"%@ -rac_textSignal", RACDescription(self)];
}

- (RACChannelTerminal *)rac_newTextChannel {
	return [self rac_channelForControlEvents:UIControlEventAllEditingEvents key:@keypath(self.text) nilValue:@""];
}

@end
