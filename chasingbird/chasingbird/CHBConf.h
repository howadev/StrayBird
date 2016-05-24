//
//  CHBConf.h
//  chasingbird
//
//  Created by Rock Lee on 2015-11-28.
//  Copyright © 2015 howalee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CHBTypes.h"

@interface CHBConf : NSObject
+ (CGFloat)populateRockDuration;
+ (CGFloat)populateCloudDuration;
+ (CGFloat)populateThunderDuration;
+ (CGFloat)populateNetDuration;

+ (CGFloat)moveCloudDuration;
+ (CGFloat)netDropDuration;
+ (CGFloat)checkPointDropDuration;

+ (NSTimeInterval)netDropInterval;
+ (NSTimeInterval)thunderInterval;
+ (CGFloat)netSpeedWithDropNetTimes:(NSUInteger)times;

+ (NSString *)initialGroupString;
+ (CHBGroup)initialGroup;
@end
