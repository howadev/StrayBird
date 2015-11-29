//
//  CHBConf.m
//  chasingbird
//
//  Created by Rock Lee on 2015-11-28.
//  Copyright © 2015 howalee. All rights reserved.
//

#import "CHBConf.h"

@implementation CHBConf

+ (CGFloat)populateRockDuration {
    return 5.0;
}

+ (CGFloat)populateCloudDuration {
    return 1.5;
}

+ (CGFloat)populateThunderDuration {
    return 5 * 60;
}

+ (CGFloat)populateNetDuration {
    return 5 * 60;
}

+ (CGFloat)moveCloudDuration {
    return 5;
}

+ (CGFloat)netDropDuration {
    return 2.0;
}

+ (CGFloat)checkPointDropDuration {
    return 8.0;
}

@end
