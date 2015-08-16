//
//  CBWorkoutController.h
//  chasingbird
//
//  Created by Howard on 2015-08-15.
//  Copyright © 2015 howalee. All rights reserved.
//

#import <Foundation/Foundation.h>
@import HealthKit;

typedef NS_ENUM(NSUInteger, CBWorkoutMode) {
    CBWorkoutModeSteps = 0,
    CBWorkoutModeWalkingRunningDistance,
    CBWorkoutModeBikingDistance,
    CBWorkoutModeEnergy
};

@interface CBWorkoutController : NSObject
@property (nonatomic, retain) HKHealthStore *healthStore;

- (void)fetchWorkoutDataInMode:(CBWorkoutMode)mode startingAt:(NSDate*)date;
- (void)stopFetchingWorkoutData;
@end
