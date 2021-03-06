//
//  MCAnimationGroup.h
//  POP+MCAnimate
//
//  Created by Matthew Cheok on 3/5/14.
//  Copyright (c) 2014 Matthew Cheok. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <POP.h>

@interface NSObject (MCAnimationGroup)

+ (void)animate:(void (^)(void))animations completion:(void (^)(BOOL finished))completion;

@end

@interface MCAnimationGroup : NSObject

@property (assign, nonatomic, getter = isFinished, readonly) BOOL finished;
@property (copy, nonatomic) void (^completionBlock)(BOOL finished);

- (void)addAnimation:(POPAnimation *)animation;
- (void)removeAnimation:(POPAnimation *)animation finished:(BOOL)finished;

@end
