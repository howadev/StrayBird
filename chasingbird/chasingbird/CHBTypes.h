//
//  CHBTypes.h
//  chasingbird
//
//  Created by Howard on 2015-08-29.
//  Copyright © 2015 howalee. All rights reserved.
//

#ifndef CHBTypes_h
#define CHBTypes_h

typedef NS_ENUM(NSInteger, CHBMapLevelViewsStarMode) {
    CHBMapLevelViewStarModeInactive = -1,
    CHBMapLevelViewStarModeNone,
    CHBMapLevelViewStarModeOne,
    CHBMapLevelViewStarModeTwo,
    CHBMapLevelViewStarModeThree,
};

typedef NS_ENUM(NSInteger, CHBMapLevelViewLevelMode) {
    CHBMapLevelViewLevelModeFirst = 1,
    CHBMapLevelViewLevelModeSecond,
    CHBMapLevelViewLevelModeThird,
};

typedef NS_ENUM(NSUInteger, CHBWorkoutMode) {
    CHBWorkoutModeSteps = 0,
    CHBWorkoutModeWalkingRunningDistance,
    CHBWorkoutModeBikingDistance,
    CHBWorkoutModeEnergy
}; 

#endif /* CHBTypes_h */
