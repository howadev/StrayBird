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

@synthesize birdSpeed = _birdSpeed;

- (instancetype)initWithLevel:(CHBGameLevel)level {
    self = [super init];
    if (self) {
        self.level = level;
        switch (level) {
            case CHBGameLevelFirst:
                self.totalTime = 20 * 60;
                self.totalDistance = 150;
                self.flockElapsedDistance = 500;
                self.flockSpeed = 3.6 * 1000 / 3600 / 2;
                break;
            case CHBGameLevelSecond:
                self.totalTime = 30 * 60;
                self.totalDistance = 2500;
                self.flockElapsedDistance = 800;
                self.flockSpeed = 4.8 * 1000 / 3600 / 2;
                break;
            case CHBGameLevelThird:
                self.totalTime = 40 * 60;
                self.totalDistance = 3500;
                self.flockElapsedDistance = 800;
                self.flockSpeed = 6 * 1000 / 3600 / 2;
                break;
        }
    }
    return self;
}

- (NSInteger)points {
    switch (self.starMode) {
        case CHBMapLevelViewStarModeThree:
            return 300;
        case CHBMapLevelViewStarModeTwo:
            return 200;
        case CHBMapLevelViewStarModeOne:
            return 100;
        default:
            return 0;
    }
}

- (CHBMapLevelViewsStarMode)starMode {
    if (!self.win) {
        return CHBMapLevelViewStarModeNone;
    }
    
    switch (self.level) {
        case CHBGameLevelFirst:
            if (self.metFlockTime < 7 * 60) {
                return CHBMapLevelViewStarModeThree;
            } else if (self.metFlockTime < 10 * 60) {
                return CHBMapLevelViewStarModeTwo;
            } else {
                return CHBMapLevelViewStarModeOne;
            }
        case CHBGameLevelSecond:
            if (self.metFlockTime < 12 * 60) {
                return CHBMapLevelViewStarModeThree;
            } else if (self.metFlockTime < 15 * 60) {
                return CHBMapLevelViewStarModeTwo;
            } else {
                return CHBMapLevelViewStarModeOne;
            }
        case CHBGameLevelThird:
            if (self.metFlockTime < 20 * 60) {
                return CHBMapLevelViewStarModeThree;
            } else if (self.metFlockTime < 25 * 60) {
                return CHBMapLevelViewStarModeTwo;
            } else {
                return CHBMapLevelViewStarModeOne;
            }
    }
}

- (void)setBirdElapsedDistance:(CGFloat)birdElapsedDistance {
    _birdElapsedDistance = birdElapsedDistance;
    
    _overallCalories = 50 * birdElapsedDistance / 1000;
}

- (CGFloat)averageSpeed {
    return self.birdElapsedDistance / self.elapsedTime;
}

- (NSTimeInterval)leftTime {
    NSTimeInterval leftTime = self.totalTime - self.elapsedTime;
    return leftTime > 0 ? leftTime : 0;
}

@end
