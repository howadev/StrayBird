//
//  CHBPerformance.m
//  chasingbird
//
//  Created by Rock Lee on 2015-10-18.
//  Copyright © 2015 howalee. All rights reserved.
//

#import "CHBPerformance.h"

static const CGFloat minimumBirdSpeed = 60.0;

@interface CHBPerformance ()

@end

@implementation CHBPerformance

#pragma mark - Variable

- (CGFloat)birdSpeed {
    if (_birdSpeed < minimumBirdSpeed) {
        return minimumBirdSpeed;
    } else {
        return _birdSpeed;
    }
}

#pragma mark - Calculation Getter

- (CGFloat)calories {
    return (0.13 * self.birdSpeed - 7.54) * 60 / 60 / 60 * self.elapsedTime;
}

- (CGFloat)averageSpeed {
    return self.birdElapsedDistance / self.elapsedTime;
}

- (NSTimeInterval)leftTime {
    NSTimeInterval leftTime = self.totalTime - self.elapsedTime;
    return leftTime > 0 ? leftTime : 0;
}

@end
