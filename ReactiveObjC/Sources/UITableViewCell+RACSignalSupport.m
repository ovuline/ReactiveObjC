//
//  UITableViewCell+RACSignalSupport.m
//  ReactiveObjC
//
//  Created by Justin Spahr-Summers on 2013-07-22.
//  Copyright (c) 2013 GitHub, Inc. All rights reserved.
//

#import "../Headers/Public/UITableViewCell+RACSignalSupport.h"
#import "../Headers/Private/NSObject+RACDescription.h"
#import "../Headers/Public/NSObject+RACSelectorSignal.h"
#import "../Headers/Public/RACSignal+Operations.h"
#import "../Headers/Public/RACUnit.h"
#import <objc/runtime.h>

@implementation UITableViewCell (RACSignalSupport)

- (RACSignal *)rac_prepareForReuseSignal {
	RACSignal *signal = objc_getAssociatedObject(self, _cmd);
	if (signal != nil) return signal;

	signal = [[[self
		rac_signalForSelector:@selector(prepareForReuse)]
		mapReplace:RACUnit.defaultUnit]
		setNameWithFormat:@"%@ -rac_prepareForReuseSignal", RACDescription(self)];
	
	objc_setAssociatedObject(self, _cmd, signal, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
	return signal;
}

@end
