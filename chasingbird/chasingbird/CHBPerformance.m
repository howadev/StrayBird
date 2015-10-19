//
//  CHBPerformance.m
//  chasingbird
//
//  Created by Rock Lee on 2015-10-18.
//  Copyright © 2015 howalee. All rights reserved.
//

#import "CHBPerformance.h"

__unused static const CGFloat minimumBirdSpeed = 60.0;

@interface CHBPerformance ()

@end

@implementation CHBPerformance

#pragma mark - Variable

//- (CGFloat)birdSpeed {
//    if (_birdSpeed < minimumBirdSpeed) {
//        return minimumBirdSpeed;
//    } else {
//        return _birdSpeed;
//    }
//}

#pragma mark - Calculation Getter

- (CGFloat)calories {
    CGFloat calories = (0.13 * self.birdSpeed - 7.54) * 60 / 60 / 60 * self.elapsedTime;
    return calories > 0 ? calories : 0;
}

- (CGFloat)averageSpeed {
    return self.birdElapsedDistance / self.elapsedTime;
}

- (NSTimeInterval)leftTime {
    NSTimeInterval leftTime = self.totalTime - self.elapsedTime;
    return leftTime > 0 ? leftTime : 0;
}

@end
