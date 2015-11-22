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

- (instancetype)initWithLevel:(CHBGameLevel)level {
    self = [super init];
    if (self) {
        switch (level) {
            case CHBGameLevelFirst:
                self.totalTime = 20 * 60;
                self.totalDistance = 1500;
                self.flockElapsedDistance = 500;
                self.flockSpeed = 60;
                break;
            case CHBGameLevelSecond:
                self.totalTime = 30 * 60;
                self.totalDistance = 2500;
                self.flockElapsedDistance = 800;
                self.flockSpeed = 80;
                break;
            case CHBGameLevelThird:
                self.totalTime = 40 * 60;
                self.totalDistance = 3500;
                self.flockElapsedDistance = 800;
                self.flockSpeed = 100;
                break;
        }
    }
    return self;
}

- (CGFloat)birdSpeed {
    // 1/37.5*1000/60, CAL -> M/MIN
    CGFloat newSpeed = _calories / 37.5 * 1000 / 60;
    if (newSpeed > _maximumSpeed) {
        _maximumSpeed = newSpeed;
    }
    return newSpeed;
}

- (CGFloat)averageSpeed {
    return self.birdElapsedDistance / self.elapsedTime;
}

- (NSTimeInterval)leftTime {
    NSTimeInterval leftTime = self.totalTime - self.elapsedTime;
    return leftTime > 0 ? leftTime : 0;
}

@end
