//
//  CHBHelpers.m
//  chasingbird
//
//  Created by Rock Lee on 2015-09-19.
//  Copyright © 2015 howalee. All rights reserved.
//

#import "CHBHelpers.h"

@implementation CHBHelpers

+ (CGFloat)random {
    return (CGFloat)arc4random() / (CGFloat)UINT32_MAX;
}

+ (CGFloat)randomWithMin:(CGFloat)min max:(CGFloat)max {
    assert(min <= max);
    return (max - min) * [CHBHelpers random] + min;
}

@end
