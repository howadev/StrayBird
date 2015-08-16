//
//  CBWorkoutController.m
//  chasingbird
//
//  Created by Howard on 2015-08-15.
//  Copyright © 2015 howalee. All rights reserved.
//

#import "CBWorkoutController.h"

@interface CBWorkoutController ()
@property (nonatomic, retain) HKObserverQuery *observerQuery;
@end

@implementation CBWorkoutController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.healthStore = [[HKHealthStore alloc] init];
    }
    return self;
}

#pragma mark - observer query

- (void)fetchWorkoutDataInMode:(CBWorkoutMode)mode startingAt:(NSDate*)date {
    
    NSAssert(mode == CBWorkoutModeWalkingRunningDistance, @"Only support walking+running distance mode for now");
    
    HKSampleType *sampleType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDistanceWalkingRunning];
    
    self.observerQuery = [[HKObserverQuery alloc] initWithSampleType:sampleType
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
        [self _fetchWorkoutDataInMode:mode startingAt:date];
        
        if (completionHandler) {
            completionHandler();
        }
     }];
    
    [self.healthStore executeQuery:self.observerQuery];
}

- (void)stopFetchingWorkoutData {
    [self.healthStore stopQuery:self.observerQuery];
}

#pragma mark - statistics query

- (void)_fetchWorkoutDataInMode:(CBWorkoutMode)mode startingAt:(NSDate*)date {
   
    NSPredicate *predicate = [HKQuery predicateForSamplesWithStartDate:date endDate:[NSDate date] options:HKQueryOptionStrictStartDate];
    
    HKQuantityType *quantityType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDistanceWalkingRunning];
    
    HKStatisticsQuery *query = [[HKStatisticsQuery alloc] initWithQuantityType:quantityType quantitySamplePredicate:predicate options:HKStatisticsOptionCumulativeSum completionHandler:^(HKStatisticsQuery *query, HKStatistics *result, NSError *error) {
        
        HKQuantity *sum = [result sumQuantity];
        
        if (error) {
            NSLog(@"error: %@", error);
        } else {
            double value = [sum doubleValueForUnit:[HKUnit meterUnit]];
            [self.delegate workoutControllerDidGetValue:value inMode:mode];
        }
        
    }];
    
    [self.healthStore executeQuery:query];
}

@end
