//
//  MCDecayAnimation.m
//  POP+MCAnimate
//
//  Created by Matthew Cheok on 29/4/14.
//  Copyright (c) 2014 Matthew Cheok. All rights reserved.
//

#import "MCDecayAnimation.h"
#import "MCVelocityProxyInternal.h"

#import <objc/runtime.h>

static char kDecayAnimationProxyKey;

@implementation NSObject (MCDecayAnimation)

@dynamic decayDeceleration;

- (MCDecayAnimation *)mc_decayAnimationProxy {
	MCDecayAnimation *proxy = objc_getAssociatedObject(self, &kDecayAnimationProxyKey);
	if (!proxy) {
		proxy = [[MCDecayAnimation alloc] initWithObject:self];
		objc_setAssociatedObject(self, &kDecayAnimationProxyKey, proxy, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
	}
	return proxy;
}

- (instancetype)decay {
	return (id)[self mc_decayAnimationProxy];
}

- (CGFloat)decayDeceleration {
	return [self mc_decayAnimationProxy].deceleration;
}

- (void)setDecayDeceleration:(CGFloat)decayDeceleration {
	[self mc_decayAnimationProxy].deceleration = decayDeceleration;
}

@end

@implementation MCDecayAnimation

- (instancetype)initWithObject:(id)object {
	self = [super initWithObject:object];
	if (self) {
		_deceleration = 0.998;
	}
	return self;
}

+ (NSString *)propertyNameForSelector:(SEL)selector {
    return [self propertyNameFromGetterSelector:selector];
}

- (POPPropertyAnimation *)propertyAnimation {
	POPDecayAnimation *animation = [POPDecayAnimation animation];
	animation.deceleration = self.deceleration;

    id velocity = [self.object mc_velocityProxy].velocity;
	if (velocity) {
		animation.velocity = velocity;
        [self.object mc_velocityProxy].velocity = nil;        
	}

	return animation;
}

@end


