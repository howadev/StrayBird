//
//  CBWorkoutController.h
//  chasingbird
//
//  Created by Howard on 2015-08-15.
//  Copyright © 2015 howalee. All rights reserved.
//

#import <Foundation/Foundation.h>
@import HealthKit;

typedef NS_ENUM(NSUInteger, CHBWorkoutMode) {
    CHBWorkoutModeSteps = 0,
    CHBWorkoutModeWalkingRunningDistance,
    CHBWorkoutModeBikingDistance,
    CHBWorkoutModeEnergy
};

@protocol CHBWorkoutControllerDelegate <NSObject>
- (void)workoutControllerDidGetValue:(double)value inMode:(CHBWorkoutMode)mode;
@end

@interface CHBWorkoutController : NSObject
@property (nonatomic, weak) id <CHBWorkoutControllerDelegate> delegate;
@property (nonatomic, retain) HKHealthStore *healthStore;

- (void)fetchWorkoutDataInMode:(CHBWorkoutMode)mode startingAt:(NSDate*)date;
- (void)stopFetchingWorkoutData;
@end
