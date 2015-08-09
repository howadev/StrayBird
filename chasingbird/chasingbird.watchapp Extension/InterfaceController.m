//
//  InterfaceController.m
//  chasingbird.watchapp Extension
//
//  Created by Howard on 2015-08-09.
//  Copyright © 2015 howalee. All rights reserved.
//

#import "InterfaceController.h"
@import HealthKit;

@interface InterfaceController() <HKWorkoutSessionDelegate>
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceLabel *alertLabel;

@end


@implementation InterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];

    // Configure interface objects here.
    
    HKWorkoutSession *workoutSession = [[HKWorkoutSession alloc] initWithActivityType:HKWorkoutActivityTypeRunning locationType:HKWorkoutSessionLocationTypeIndoor];
    workoutSession.delegate = self;
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
    
    NSLog(@"Hello world");
    
    if ([HKHealthStore isHealthDataAvailable] == NO) {
        self.alertLabel.text = @"Data not available";
        return;
    }
    
    HKQuantityType *quantiyType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierHeartRate];
    
    if (quantiyType == nil) {
        self.alertLabel.text = @"Quanity type not available";
        return;
    }
    
    NSSet *dataTypes = [[NSSet alloc] initWithArray:@[quantiyType]];
    HKHealthStore *healthStore = [HKHealthStore new];
    [healthStore requestAuthorizationToShareTypes:nil readTypes:dataTypes completion:^(BOOL success, NSError * _Nullable error) {
        if (success == NO) {
            self.alertLabel.text = @"Fail to request authorization";
        }
    }];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

#pragma HKWorkoutSessionDelegate

- (void)workoutSession:(HKWorkoutSession *)workoutSession
      didChangeToState:(HKWorkoutSessionState)toState
             fromState:(HKWorkoutSessionState)fromState
                  date:(NSDate *)date
{
    
}

- (void)workoutSession:(HKWorkoutSession *)workoutSession didFailWithError:(NSError *)error
{
    
}

@end



