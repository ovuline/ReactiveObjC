//
//  RACPassthroughSubscriber.m
//  ReactiveObjC
//
//  Created by Justin Spahr-Summers on 2013-06-13.
//  Copyright (c) 2013 GitHub, Inc. All rights reserved.
//

#import "RACPassthroughSubscriber.h"
#import "RACCompoundDisposable.h"
#import "RACSignal.h"

@interface RACPassthroughSubscriber ()

// The subscriber to which events should be forwarded.
@property (nonatomic, strong, readonly) id<RACSubscriber> innerSubscriber;

// The signal sending events to this subscriber.
//
// This property isn't `weak` because it's only used for DTrace probes, so
// a zeroing weak reference would incur an unnecessary performance penalty in
// normal usage.
@property (nonatomic, unsafe_unretained, readonly) RACSignal *signal;

// A disposable representing the subscription. When disposed, no further events
// should be sent to the `innerSubscriber`.
@property (nonatomic, strong, readonly) RACCompoundDisposable *disposable;

@end

@implementation RACPassthroughSubscriber

#pragma mark Lifecycle

- (instancetype)initWithSubscriber:(id<RACSubscriber>)subscriber signal:(RACSignal *)signal disposable:(RACCompoundDisposable *)disposable {
	NSCParameterAssert(subscriber != nil);

	self = [super init];

	_innerSubscriber = subscriber;
	_signal = signal;
	_disposable = disposable;

	[self.innerSubscriber didSubscribeWithDisposable:self.disposable];
	return self;
}

#pragma mark RACSubscriber

- (void)sendNext:(id)value {
	if (self.disposable.disposed) return;

	[self.innerSubscriber sendNext:value];
}

- (void)sendError:(NSError *)error {
	if (self.disposable.disposed) return;

	[self.innerSubscriber sendError:error];
}

- (void)sendCompleted {
	if (self.disposable.disposed) return;

	[self.innerSubscriber sendCompleted];
}

- (void)didSubscribeWithDisposable:(RACCompoundDisposable *)disposable {
	if (disposable != self.disposable) {
		[self.disposable addDisposable:disposable];
	}
}

@end
