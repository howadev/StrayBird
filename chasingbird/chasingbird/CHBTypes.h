//
//  CHBTypes.h
//  chasingbird
//
//  Created by Howard on 2015-08-29.
//  Copyright © 2015 howalee. All rights reserved.
//

#import <UIKit/UIKit.h>

#ifndef CHBTypes_h
#define CHBTypes_h

const static CGFloat kCHBEdgeInset = 8.0;
const static CGFloat kCHBRadarScale = 0.8;

static NSString *homeNotification = @"BackToHome";
static NSString *playNotification = @"StartGame";
static NSString *restartNotification = @"RestartGame";
static NSString *deviceConnectedNotification = @"DeviceConnected";

typedef NS_ENUM(NSInteger, CHBDeviceType) {
    CHBDeviceTypeAppleWatch = 0,
    CHBDeviceTypeSensorTag,
};

typedef NS_ENUM(NSInteger, CHBMapLevelViewsStarMode) {
    CHBMapLevelViewStarModeInactive = -1,
    CHBMapLevelViewStarModeNone,
    CHBMapLevelViewStarModeOne,
    CHBMapLevelViewStarModeTwo,
    CHBMapLevelViewStarModeThree,
};

typedef NS_ENUM(NSInteger, CHBGameLevel) {
    CHBGameLevelFirst = 1,
    CHBGameLevelSecond,
    CHBGameLevelThird,
};

typedef NS_ENUM(NSUInteger, CHBWorkoutMode) {
    CHBWorkoutModeSteps = 0,
    CHBWorkoutModeWalkingRunningDistance,
    CHBWorkoutModeBikingDistance,
    CHBWorkoutModeEnergy
};

typedef NS_ENUM(NSInteger, CHBNetState) {
    CHBNetStateNone = 0,
    CHBNetStateDrop,
    CHBNetStateCollision,
    CHBNetStateBreak,
};

#endif /* CHBTypes_h */
