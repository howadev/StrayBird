//
//  CHBPerformance.h
//  chasingbird
//
//  Created by Rock Lee on 2015-10-18.
//  Copyright © 2015 howalee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CHBPerformance : NSObject

#pragma mark - Constant
@property (nonatomic, assign) NSTimeInterval totalTime;
@property (nonatomic, assign) CGFloat totalDistance;

#pragma mark - Variable
@property (nonatomic, assign) CGFloat flockSpeed;
@property (nonatomic, assign) CGFloat birdSpeed;
@property (nonatomic, assign) CGFloat elapsedTime;
@property (nonatomic, assign) CGFloat birdElapsedDistance;
@property (nonatomic, assign) CGFloat flockElapsedDistance;

#pragma mark - Time Stamp
@property (nonatomic, assign) NSTimeInterval metFlockTime;
@property (nonatomic, assign) CGFloat maximumSpeed;

#pragma mark - Calculation Getter
@property (nonatomic, readonly) CGFloat calories;
@property (nonatomic, readonly) CGFloat averageSpeed;
@property (nonatomic, readonly) NSTimeInterval leftTime;

#pragma mark - Result Status
@property (nonatomic, assign) BOOL win;

@end
