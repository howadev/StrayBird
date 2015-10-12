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
    CHBNetStateNone = 1,
    CHBNetStateDrop,
    CHBNetStateCollision,
    CHBNetStateBreak,
};

#endif /* CHBTypes_h */
