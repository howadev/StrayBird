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
@property (nonatomic, assign) CGFloat originalDistanceToFlock;

#pragma mark - Variable
@property (nonatomic, assign) CGFloat flockSpeed;
@property (nonatomic, assign) CGFloat birdSpeed;
@property (nonatomic, assign) CGFloat elapsedTime;

#pragma mark - Time Stamp
@property (nonatomic, assign) NSTimeInterval metFlockTime;
@property (nonatomic, assign) CGFloat maximumSpeed;

#pragma mark - Getter
@property (nonatomic, readonly) CGFloat elapsedDistance;
@property (nonatomic, readonly) CGFloat calories;
@property (nonatomic, readonly) CGFloat averageSpeed;

@end
