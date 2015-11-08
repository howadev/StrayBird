//
//  InterfaceController.m
//  chasingbird.watchapp Extension
//
//  Created by Howard on 2015-08-09.
//  Copyright © 2015 howalee. All rights reserved.
//

#import "InterfaceController.h"
@import HealthKit;
@import WatchConnectivity;

typedef NS_ENUM(NSUInteger, CHBWatchMode) {
    CHBWatchModeDistance = 0,
    CHBWatchModeHeartRate
};

@interface InterfaceController() <HKWorkoutSessionDelegate, WCSessionDelegate>
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceLabel *alertLabel;
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceButton *startButton;
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceButton *endButton;

@property (nonatomic, retain) HKWorkoutSession *workoutSession;
@property (nonatomic, retain) HKHealthStore *healthStore;
@property (nonatomic, retain) HKAnchoredObjectQuery *query;
@property (nonatomic, retain) HKQueryAnchor *anchor;
@property (nonatomic, retain) HKUnit *workoutUnit;
@property (nonatomic, retain) NSString *quantityTypeIdentifier;

@property (nonatomic, assign) CHBWatchMode watchMode;
@end


@implementation InterfaceController

#pragma UI Actions

- (IBAction)startButtonDidTap {
    self.workoutSession = [[HKWorkoutSession alloc] initWithActivityType:HKWorkoutActivityTypeRunning locationType:HKWorkoutSessionLocationTypeIndoor];
    self.workoutSession.delegate = self;
    [self.healthStore startWorkoutSession:self.workoutSession];
}

- (IBAction)endButtonDidTap {
    [self.healthStore endWorkoutSession:self.workoutSession];
}

#pragma Life Cycle

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    
    [self.startButton setHidden:YES];
    
    // Configure session
    
    self.watchMode = CHBWatchModeDistance;
    
    switch (self.watchMode) {
        case CHBWatchModeDistance:
            self.anchor = [HKQueryAnchor anchorFromValue:HKAnchoredObjectQueryNoAnchor];
            self.workoutUnit = [HKUnit unitFromString:@"m"];
            self.healthStore = [HKHealthStore new];
            break;
        case CHBWatchModeHeartRate:
            self.anchor = [HKQueryAnchor anchorFromValue:HKAnchoredObjectQueryNoAnchor];
            self.workoutUnit = [HKUnit unitFromString:@"count/min"];
            self.healthStore = [HKHealthStore new];
            break;
    }
    
    // Configure Connectivity
    
    if ([WCSession isSupported]) {
        WCSession *session = [WCSession defaultSession];
        session.delegate = self;
        [session activateSession];
    }
    
    // Configure UI
    [self.startButton setHidden:NO];
    [self.endButton setHidden:YES];
}

- (void)willActivate {
    [super willActivate];
    
    if ([HKHealthStore isHealthDataAvailable] == NO) {
        self.alertLabel.text = @"Data not available";
        return;
    }
    
    switch (self.watchMode) {
        case CHBWatchModeDistance:
            self.quantityTypeIdentifier = HKQuantityTypeIdentifierDistanceWalkingRunning;
            break;
        case CHBWatchModeHeartRate:
            self.quantityTypeIdentifier = HKQuantityTypeIdentifierHeartRate;
            break;
    }
    HKQuantityType *quantiyType = [HKQuantityType quantityTypeForIdentifier:self.quantityTypeIdentifier];
    NSAssert(quantiyType, @"Quanity type not available");
    
    NSSet *dataTypes = [[NSSet alloc] initWithArray:@[quantiyType]];
    
    [self.healthStore requestAuthorizationToShareTypes:nil readTypes:dataTypes completion:^(BOOL success, NSError * _Nullable error) {
        if (success == NO) {
            self.alertLabel.text = @"Fail to request authorization";
        }
    }];
}

- (void)didDeactivate {
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
        
        if ([[WCSession defaultSession] isReachable]) {
            NSDictionary *applicationDict = @{@"heartrate":valueString};
            [[WCSession defaultSession] sendMessage:applicationDict
                                       replyHandler:^(NSDictionary *replyHandler) {
                                           
                                       }
                                       errorHandler:^(NSError *error) {
                                           
                                       }
             ];
        }
    }
}

- (HKQuery*)createWorkoutStreamingQueryOnDate:(NSDate*)date
{
    HKQuantityType *quantiyType = [HKQuantityType quantityTypeForIdentifier:self.quantityTypeIdentifier];
    
    if (quantiyType == nil) {
        self.alertLabel.text = @"Quanity type not available";
        return nil;
    }
    
    __weak typeof(self) weakSelf = self;
    
    self.query = [[HKAnchoredObjectQuery alloc] initWithType:quantiyType predicate:nil anchor:self.anchor limit:HKObjectQueryNoLimit resultsHandler:^(HKAnchoredObjectQuery * _Nonnull query, NSArray<__kindof HKSample *> * _Nullable sampleObjects, NSArray<HKDeletedObject *> * _Nullable deletedObjects, HKQueryAnchor * _Nullable newAnchor, NSError * _Nullable error) {
        if (newAnchor) {
            weakSelf.anchor = newAnchor;
            [weakSelf updateWorkoutRateWithSamples:sampleObjects];
        }
    }];
    
    if (self.query == nil) {
        self.alertLabel.text = @"Query not available";
        return nil;
    }
    
    self.query.updateHandler = ^(HKAnchoredObjectQuery *query, NSArray<__kindof HKSample *> * __nullable addedObjects, NSArray<HKDeletedObject *> * __nullable deletedObjects, HKQueryAnchor * __nullable newAnchor, NSError * __nullable error) {
        weakSelf.anchor = newAnchor;
        [weakSelf updateWorkoutRateWithSamples:addedObjects];
    };
    
    return self.query;
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

- (void)workoutDidEnd
{
    if (self.query) {
        [self.healthStore stopQuery:self.query];
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
                [self.startButton setHidden:YES];
                [self.endButton setHidden:NO];
                break;
            case HKWorkoutSessionStateEnded:
                [self workoutDidEnd];
                [self.startButton setHidden:NO];
                [self.endButton setHidden:YES];
                break;
            default:
                break;
        }
    });
}

- (void)workoutSession:(HKWorkoutSession *)workoutSession didFailWithError:(NSError *)error
{
    self.alertLabel.text = @"Workout session fail";
}

@end



