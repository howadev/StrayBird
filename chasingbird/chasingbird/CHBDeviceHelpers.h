//
//  CHBDeviceHelpers.h
//  chasingbird
//
//  Created by Haohua Li on 2015-12-31.
//  Copyright © 2015 howalee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <LEO/LEODataDelegate.h>
#import "CHBTypes.h"

@protocol CHBDeviceHelpersDelegate <NSObject>
- (void)deviceType:(CHBDeviceType)type didReceiveValue:(CGFloat)value;
@end

@interface CHBDeviceHelpers : NSObject <LEODataDelegate>
@property (nonatomic, weak) id <CHBDeviceHelpersDelegate> delegate;
@property (nonatomic, assign) CHBDeviceType deviceType;
@property (nonatomic, assign) BOOL connected;
+ (instancetype)sharedInstance;
@end
