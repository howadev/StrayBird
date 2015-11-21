//
//  CHBPerformanceHelper.m
//  chasingbird
//
//  Created by Rock Lee on 2015-11-16.
//  Copyright © 2015 howalee. All rights reserved.
//

#import "CHBPerformanceHelper.h"

@interface CHBPerformanceHelper ()

@end

@implementation CHBPerformanceHelper

- (id)init
{
    self = [super init];
    if (self) {
        [self initialize];
    }
    return self;
}

+ (instancetype)sharedHelper
{
    static CHBPerformanceHelper *sharedPerformanceHelper;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedPerformanceHelper = [[CHBPerformanceHelper alloc] init];
    });
    return sharedPerformanceHelper;
}

- (void)initialize {
    //
}

#pragma mark - Overall

- (NSInteger)points {
    return [[NSUserDefaults standardUserDefaults] integerForKey:@"points"];
}
- (void)setPoints:(NSInteger)points {
    [[NSUserDefaults standardUserDefaults] setInteger:points forKey:@"points"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSInteger)wins {
    return [[NSUserDefaults standardUserDefaults] integerForKey:@"wins"];
}
- (void)setWins:(NSInteger)wins {
    [[NSUserDefaults standardUserDefaults] setInteger:wins forKey:@"wins"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSInteger)losses {
    return [[NSUserDefaults standardUserDefaults] integerForKey:@"losses"];
}
- (void)setLosses:(NSInteger)losses {
    [[NSUserDefaults standardUserDefaults] setInteger:losses forKey:@"losses"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSInteger)calories {
    return [[NSUserDefaults standardUserDefaults] integerForKey:@"calories"];
}
- (void)setCalories:(NSInteger)calories {
    [[NSUserDefaults standardUserDefaults] setInteger:calories forKey:@"calories"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSInteger)distance {
    return [[NSUserDefaults standardUserDefaults] integerForKey:@"distance"];
}
- (void)setDistance:(NSInteger)distance {
    [[NSUserDefaults standardUserDefaults] setInteger:distance forKey:@"distance"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark - Maximum

- (NSInteger)speed {
    return [[NSUserDefaults standardUserDefaults] integerForKey:@"speed"];
}
- (void)setSpeed:(NSInteger)speed {
    [[NSUserDefaults standardUserDefaults] setInteger:speed forKey:@"speed"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSInteger)firstLevelPoints {
    return [[NSUserDefaults standardUserDefaults] integerForKey:@"firstLevelPoints"];
}
- (void)setFirstLevelpoints:(NSInteger)firstLevelPoints {
    [[NSUserDefaults standardUserDefaults] setInteger:firstLevelPoints forKey:@"firstLevelPoints"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSInteger)secondLevelPoints {
    return [[NSUserDefaults standardUserDefaults] integerForKey:@"secondLevelPoints"];
}
- (void)setSecondLevelPoints:(NSInteger)secondLevelPoints {
    [[NSUserDefaults standardUserDefaults] setInteger:secondLevelPoints forKey:@"secondLevelPoints"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSInteger)thirdLevelPoints {
    return [[NSUserDefaults standardUserDefaults] integerForKey:@"thirdLevelPoints"];
}
- (void)setThirdLevelPoints:(NSInteger)thirdLevelPoints {
    [[NSUserDefaults standardUserDefaults] setInteger:thirdLevelPoints forKey:@"thirdLevelPoints"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark - Convenience

- (CHBMapLevelViewsStarMode)starModeWithGameLevel:(CHBGameLevel)level {
    if ([self gameLevelShouldActivate:level] == NO) {
        return CHBMapLevelViewStarModeInactive;
    }
    
    NSInteger points = 0;
    switch (level) {
        case CHBGameLevelFirst:
            points = [self firstLevelPoints];
            break;
        case CHBGameLevelSecond: {
            points = [self secondLevelPoints];
            break;
        }
        case CHBGameLevelThird:
            points = [self thirdLevelPoints];
            break;
    }
    return [self starModeWithPoints:points];
}

- (BOOL)gameLevelShouldActivate:(CHBGameLevel)level {
    switch (level) {
        case CHBGameLevelFirst:
            return YES;
        case CHBGameLevelSecond: {
            CHBMapLevelViewsStarMode starMode = [self starModeWithGameLevel:CHBGameLevelFirst];
            if (starMode == CHBMapLevelViewStarModeInactive || starMode == CHBMapLevelViewStarModeNone) {
                return NO;
            } else {
                return YES;
            }
        }
        case CHBGameLevelThird: {
            CHBMapLevelViewsStarMode starMode = [self starModeWithGameLevel:CHBGameLevelSecond];
            if (starMode == CHBMapLevelViewStarModeInactive || starMode == CHBMapLevelViewStarModeNone) {
                return NO;
            } else {
                return YES;
            }
        }
    }
}

- (CHBMapLevelViewsStarMode)starModeWithPoints:(NSInteger)points {
    if (points < 100) {
        return CHBMapLevelViewStarModeNone;
    } else if (points < 200) {
        return CHBMapLevelViewStarModeOne;
    } else if (points < 300) {
        return CHBMapLevelViewStarModeTwo;
    } else {
        return CHBMapLevelViewStarModeThree;
    }
}

@end
