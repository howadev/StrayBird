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
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceButton *startButton;
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceButton *endButton;

@property (nonatomic, retain) HKWorkoutSession *workoutSession;
@property (nonatomic, retain) HKHealthStore *healthStore;
@property (nonatomic, retain) HKQueryAnchor *anchor;
@property (nonatomic, retain) HKUnit *workoutUnit;
@end


@implementation InterfaceController

#pragma UI Actions

- (IBAction)startButtonDidTap {
    [self.healthStore startWorkoutSession:self.workoutSession];
}

- (IBAction)endButtonDidTap {
    [self.healthStore endWorkoutSession:self.workoutSession];
}

#pragma Life Cycle

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    
    // Configure interface objects here.
    
    self.workoutSession = [[HKWorkoutSession alloc] initWithActivityType:HKWorkoutActivityTypeRunning locationType:HKWorkoutSessionLocationTypeIndoor];
    self.workoutSession.delegate = self;
    
    self.anchor = [HKQueryAnchor anchorFromValue:HKAnchoredObjectQueryNoAnchor];
    self.workoutUnit = [HKUnit unitFromString:@"m"];
    
    self.healthStore = [HKHealthStore new];
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
    
    if ([HKHealthStore isHealthDataAvailable] == NO) {
        self.alertLabel.text = @"Data not available";
        return;
    }
    
    HKQuantityType *quantiyType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierDistanceWalkingRunning];
    
    if (quantiyType == nil) {
        self.alertLabel.text = @"Quanity type not available";
        return;
    }
    
    NSSet *dataTypes = [[NSSet alloc] initWithArray:@[quantiyType]];
    
    [self.healthStore requestAuthorizationToShareTypes:nil readTypes:dataTypes completion:^(BOOL success, NSError * _Nullable error) {
        if (success == NO) {
            self.alertLabel.text = @"Fail to request authorization";
        }
    }];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

#pragma Workout Data

- (void)updateWorkoutRateWithSamples:(NSArray*)samples
{
    HKQuantitySample *sample = [samples firstObject];
    if (sample) {
        NSString *valueString = [NSString stringWithFormat:@"%f", [sample.quantity doubleValueForUnit:self.workoutUnit]];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.alertLabel.text = valueString;
        });
    }
}

- (HKQuery*)createWorkoutStreamingQueryOnDate:(NSDate*)date
{
    HKQuantityType *quantiyType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierDistanceWalkingRunning];
    
    if (quantiyType == nil) {
        self.alertLabel.text = @"Quanity type not available";
        return nil;
    }
    
    HKAnchoredObjectQuery *query = [[HKAnchoredObjectQuery alloc] initWithType:quantiyType predicate:nil anchor:self.anchor limit:HKObjectQueryNoLimit resultsHandler:^(HKAnchoredObjectQuery * _Nonnull query, NSArray<__kindof HKSample *> * _Nullable sampleObjects, NSArray<HKDeletedObject *> * _Nullable deletedObjects, HKQueryAnchor * _Nullable newAnchor, NSError * _Nullable error) {
        if (newAnchor) {
            self.anchor = newAnchor;
            [self updateWorkoutRateWithSamples:sampleObjects];
        }
    }];
    
    if (query == nil) {
        self.alertLabel.text = @"Query not available";
        return nil;
    }
    
    query.updateHandler = ^(HKAnchoredObjectQuery *query, NSArray<__kindof HKSample *> * __nullable addedObjects, NSArray<HKDeletedObject *> * __nullable deletedObjects, HKQueryAnchor * __nullable newAnchor, NSError * __nullable error) {
        self.anchor = newAnchor;
        [self updateWorkoutRateWithSamples:addedObjects];
    };
    
    return query;
}

- (void)workoutDidStartOnDate:(NSDate*)date
{
    HKQuery *query = [self createWorkoutStreamingQueryOnDate:date];
    if (query) {
        [self.healthStore executeQuery:query];
    } else {
        self.alertLabel.text = @"Cannot start query";
    }
}

- (void)workoutDidEndOnDate:(NSDate*)date
{
    HKQuery *query = [self createWorkoutStreamingQueryOnDate:date];
    if (query) {
        [self.healthStore stopQuery:query];
        self.alertLabel.text = @"Stop Running";
    } else {
        self.alertLabel.text = @"Cannot end query";
    }
}

#pragma HKWorkoutSessionDelegate

- (void)workoutSession:(HKWorkoutSession *)workoutSession
      didChangeToState:(HKWorkoutSessionState)toState
             fromState:(HKWorkoutSessionState)fromState
                  date:(NSDate *)date
{
    dispatch_async(dispatch_get_main_queue(), ^{
        switch (toState) {
            case HKWorkoutSessionStateRunning:
                [self workoutDidStartOnDate:date];
                break;
            case HKWorkoutSessionStateEnded:
                [self workoutDidEndOnDate:date];
                break;
            default:
                break;
        }
    });
}

- (void)workoutSession:(HKWorkoutSession *)workoutSession didFailWithError:(NSError *)error
{
    //self.alertLabel.text = @"Workout session fail";
    NSLog(@"%@", error);
}

@end



