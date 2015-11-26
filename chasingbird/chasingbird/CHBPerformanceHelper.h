//
//  CHBPerformanceHelper.h
//  chasingbird
//
//  Created by Rock Lee on 2015-11-16.
//  Copyright © 2015 howalee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CHBTypes.h"
#import "CHBPerformance.h"

@interface CHBPerformanceHelper : NSObject
+ (instancetype)sharedHelper;
- (void)updateWithPerformance:(CHBPerformance *)performance;

#pragma mark - Overall
@property (nonatomic, assign) NSInteger points;
@property (nonatomic, assign) NSInteger wins;
@property (nonatomic, assign) NSInteger losses;
@property (nonatomic, assign) NSInteger calories;   //KCAL
@property (nonatomic, assign) NSInteger distance;   //M

#pragma mark - Maximum
@property (nonatomic, assign) NSInteger speed;
@property (nonatomic, assign) NSInteger firstLevelPoints;
@property (nonatomic, assign) NSInteger secondLevelPoints;
@property (nonatomic, assign) NSInteger thirdLevelPoints;

#pragma mark - Convenience
- (CHBMapLevelViewsStarMode)starModeWithGameLevel:(CHBGameLevel)level;
- (BOOL)gameLevelShouldActivate:(CHBGameLevel)level;
@end
