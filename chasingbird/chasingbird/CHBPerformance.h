//
//  CHBPerformance.h
//  chasingbird
//
//  Created by Rock Lee on 2015-10-18.
//  Copyright © 2015 howalee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CHBTypes.h"

@interface CHBPerformance : NSObject

- (instancetype)initWithLevel:(CHBGameLevel)level;
@property (nonatomic, assign) CHBGameLevel level;
@property (nonatomic, assign) NSInteger points;
@property (nonatomic, assign) CHBMapLevelViewsStarMode starMode;

#pragma mark - Constant
@property (nonatomic, assign) NSTimeInterval totalTime;
@property (nonatomic, assign) CGFloat totalDistance;

#pragma mark - Variable
@property (nonatomic, assign) CGFloat birdSpeed;
@property (nonatomic, assign) CGFloat elapsedTime;


#pragma mark - Time Stamp
@property (nonatomic, assign) NSTimeInterval metFlockTime;

#pragma mark - Calculation Getter
@property (nonatomic, readonly) CGFloat maximumSpeed;
@property (nonatomic, readonly) CGFloat averageSpeed;
@property (nonatomic, readonly) NSTimeInterval leftTime;
@property (nonatomic, readonly) CGFloat overallCalories;

@property (nonatomic, assign) CGFloat birdElapsedDistance;
@property (nonatomic, assign) CGFloat flockSpeed;
@property (nonatomic, assign) CGFloat flockElapsedDistance;

#pragma mark - Result Status
@property (nonatomic, assign) BOOL win;

@end
