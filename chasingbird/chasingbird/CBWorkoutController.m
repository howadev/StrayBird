//
//  CBWorkoutController.m
//  chasingbird
//
//  Created by Howard on 2015-08-15.
//  Copyright © 2015 howalee. All rights reserved.
//

#import "CBWorkoutController.h"

@implementation CBWorkoutController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.healthStore = [[HKHealthStore alloc] init];
    }
    return self;
}

- (void)fetchWorkoutDataInMode:(CBWorkoutMode)mode startingAt:(NSDate*)date {
    
    NSAssert(mode == CBWorkoutModeWalkingRunningDistance, @"Only support walking+running distance mode for now");
    
    HKSampleType *sampleType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDistanceWalkingRunning];
    
    HKObserverQuery *query = [[HKObserverQuery alloc] initWithSampleType:sampleType
                                                               predicate:nil
                                                           updateHandler:^(HKObserverQuery *query,
                                                                           HKObserverQueryCompletionHandler completionHandler,
                                                                           NSError *error)
    {
         
        if (error) {
            NSLog(@"*** An error occured while setting up the workout observer. %@ ***", error.localizedDescription);
            return;
        }
         
         // Take whatever steps are necessary to update your app's data and UI
         // This may involve executing other queries
         //[self updateDailyStepCount];
         
        if (completionHandler) {
            completionHandler();
        }
     }];
    
    [self.healthStore executeQuery:query];
}

- (void)stopFetchingWorkoutData {
    
}

@end
