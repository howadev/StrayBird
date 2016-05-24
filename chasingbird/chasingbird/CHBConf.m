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

+ (NSTimeInterval)netDropInterval {
    return 5 * 60;
}

+ (NSTimeInterval)thunderInterval {
    return 5 * 60;
}

+ (CGFloat)netSpeedWithDropNetTimes:(NSUInteger)times {
    switch (times) {
        case 0:
            return 1.6;
        case 1:
            return 1.7;
        case 2:
            return 1.8;
        default:
            return 1.9;
    }
}

+ (NSString *)initialGroupString
{
    return @"THIRD";
}

+ (CHBGroup)initialGroup
{
    NSString *group = [self initialGroupString];
    if ([group isEqualToString:@"FIRST"]) {
        return CHBGroupFirst;
    } else if ([group isEqualToString:@"SECOND"]) {
        return CHBGroupSecond;
    } else {
        return CHBGroupThird;
    }
}

+ (NSInteger)daysBetweenDate:(NSDate*)fromDateTime andDate:(NSDate*)toDateTime
{
    NSDate *fromDate;
    NSDate *toDate;
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    [calendar rangeOfUnit:NSCalendarUnitDay startDate:&fromDate
                 interval:NULL forDate:fromDateTime];
    [calendar rangeOfUnit:NSCalendarUnitDay startDate:&toDate
                 interval:NULL forDate:toDateTime];
    
    NSDateComponents *difference = [calendar components:NSCalendarUnitDay
                                               fromDate:fromDate toDate:toDate options:0];
    
    return [difference day];
}

+ (NSInteger)daysSinceFirstOpenTime
{
    NSDate *firstOpenTime = [[NSUserDefaults standardUserDefaults] objectForKey:@"FirstOpenTime"];
    return [self daysBetweenDate:firstOpenTime andDate:[NSDate date]];
}

@end
