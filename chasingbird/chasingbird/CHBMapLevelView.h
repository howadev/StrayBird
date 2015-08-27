//
//  CHBMapLevelView.h
//  chasingbird
//
//  Created by Howard on 2015-08-26.
//  Copyright © 2015 howalee. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, CHBMapLevelViewsStarMode) {
    CHBMapLevelViewStarModeInactive = -1,
    CHBMapLevelViewStarModeNone,
    CHBMapLevelViewStarModeOne,
    CHBMapLevelViewStarModeTwo,
    CHBMapLevelViewStarModeThree,
};

typedef NS_ENUM(NSInteger, CHBMapLevelViewLevelMode) {
    CHBMapLevelViewLevelModeFirst = 1,
    CHBMapLevelViewLevelModeSecond,
    CHBMapLevelViewLevelModeThird,
};

@interface CHBMapLevelView : UIView
@property (nonatomic, assign) CHBMapLevelViewsStarMode starMode;
@property (nonatomic, assign) CHBMapLevelViewLevelMode levelMode;
@end
