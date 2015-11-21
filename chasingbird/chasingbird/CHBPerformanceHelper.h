//
//  CHBPerformanceHelper.h
//  chasingbird
//
//  Created by Rock Lee on 2015-11-16.
//  Copyright © 2015 howalee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CHBPerformanceHelper : NSObject
+ (instancetype)sharedHelper;
@property (nonatomic, assign) NSInteger points;
@property (nonatomic, assign) NSInteger wins;
@property (nonatomic, assign) NSInteger losses;
@property (nonatomic, assign) NSInteger calories;   //KCAL
@property (nonatomic, assign) NSInteger distance;   //M

@property (nonatomic, assign) NSInteger speed;
@end
