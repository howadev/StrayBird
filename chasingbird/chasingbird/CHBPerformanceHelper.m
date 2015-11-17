//
//  CHBPerformanceHelper.m
//  chasingbird
//
//  Created by Rock Lee on 2015-11-16.
//  Copyright © 2015 howalee. All rights reserved.
//

#import "CHBPerformanceHelper.h"

@implementation CHBPerformanceHelper

- (id)init
{
    self = [super init];
    if (self) {
        [self initialize];
    }
    return self;
}

+ (instancetype)sharedGameKitHelper
{
    static CHBPerformanceHelper *sharedPerformanceHelper;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedPerformanceHelper = [[CHBPerformanceHelper alloc] init];
    });
    return sharedPerformanceHelper;
}

- (void)initialize {
    
}

@end
