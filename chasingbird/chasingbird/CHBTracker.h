//
//  CHBTracker.h
//  StrayBird
//
//  Created by Rock Lee on 2016-05-11.
//  Copyright © 2016 howalee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CHBTracker : NSObject
+ (void)start;
+ (void)createEventWithCategory:(NSString*)category action:(NSString*)action;
+ (void)createScreenWithName:(NSString*)name;
+ (void)createTimingWithCategory:(NSString*)category interval:(NSTimeInterval)interval;
@end
