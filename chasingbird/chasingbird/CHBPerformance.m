//
//  CHBPerformance.m
//  chasingbird
//
//  Created by Rock Lee on 2015-10-18.
//  Copyright © 2015 howalee. All rights reserved.
//

#import "CHBPerformance.h"
#import "CHBDeviceHelpers.h"

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
                self.totalDistance = 1500;
                self.flockElapsedDistance = 500;
                self.flockSpeed = 3.6 * 1000 / 3600;
                break;
            case CHBGameLevelSecond:
                self.totalTime = 30 * 60;
                self.totalDistance = 2500;
                self.flockElapsedDistance = 800;
                self.flockSpeed = 4.8 * 1000 / 3600;
                break;
            case CHBGameLevelThird:
                self.totalTime = 40 * 60;
                self.totalDistance = 3500;
                self.flockElapsedDistance = 800;
                self.flockSpeed = 6 * 1000 / 3600;
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

- (void)setCalories:(CGFloat)calories {
    NSAssert([CHBDeviceHelpers sharedInstance].deviceType == CHBDeviceTypeAppleWatch, @"Must be Apple Watch");
    _calories = calories;
    _overallCalories += calories;
}

- (void)setBirdSpeed:(CGFloat)birdSpeed {
    NSAssert([CHBDeviceHelpers sharedInstance].deviceType != CHBDeviceTypeAppleWatch, @"Must not be Apple Watch");
    _birdSpeed = birdSpeed;
    
    _calories = _birdSpeed * 60 / 1000 * 37.5;
    _overallCalories += _calories;
}

- (CGFloat)birdSpeed {
    switch ([CHBDeviceHelpers sharedInstance].deviceType) {
        case CHBDeviceTypeAppleWatch: {
            // 1/37.5*1000/60, CAL -> M/MIN
            CGFloat newSpeed = _calories / 37.5 * 1000 / 60;
            if (newSpeed > _maximumSpeed) {
                _maximumSpeed = newSpeed;
            }
            return newSpeed;
        }
        case CHBDeviceTypeLEO:
        case CHBDeviceTypeSensorTag:
            if (_birdSpeed > _maximumSpeed) {
                _maximumSpeed = _birdSpeed;
            }
            return _birdSpeed;
    }
}

- (CGFloat)averageSpeed {
    return self.birdElapsedDistance / self.elapsedTime;
}

- (NSTimeInterval)leftTime {
    NSTimeInterval leftTime = self.totalTime - self.elapsedTime;
    return leftTime > 0 ? leftTime : 0;
}

@end
