//
//  CHBDeviceHelpers.m
//  chasingbird
//
//  Created by Haohua Li on 2015-12-31.
//  Copyright © 2015 howalee. All rights reserved.
//

#import "CHBDeviceHelpers.h"

@implementation CHBDeviceHelpers

+ (instancetype)sharedInstance
{
    static CHBDeviceHelpers *sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[CHBDeviceHelpers alloc] init];
    });
    return sharedInstance;
}

#pragma mark - LEODataDelegate
- (void)LEO:(LEOBluetooth *)LEO didSendRepetition:(LEORepetition *)repetition {
    [self.delegate deviceType:self.deviceType didReceiveValue:repetition.cadence];
    NSLog(@"Did receive cadence: %tu", repetition.cadence);
    NSLog(@"Difference from previous cadence: %tu", repetition.cadence - repetition.previousRepetition.cadence);
}

- (void)LEO:(LEOBluetooth *)LEO didUpdateActivity:(LEOActivity)activity {
    //NSLog(@"didUpdateActivity");
}

@end
