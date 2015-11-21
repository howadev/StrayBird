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

#pragma mark - Metrics

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

- (NSInteger)speed {
    return [[NSUserDefaults standardUserDefaults] integerForKey:@"speed"];
}
- (void)setSpeed:(NSInteger)speed {
    [[NSUserDefaults standardUserDefaults] setInteger:speed forKey:@"speed"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
