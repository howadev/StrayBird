//
//  CHBMapLevelView.m
//  chasingbird
//
//  Created by Howard on 2015-08-26.
//  Copyright © 2015 howalee. All rights reserved.
//

#import "CHBMapLevelView.h"
#import "CHBImageView.h"
#import "UIView+AutoLayoutHelpers.h"

@interface CHBMapLevelView ()
@property (nonatomic, retain) CHBImageView *starsView;
@property (nonatomic, retain) CHBImageView *levelView;
@end

@implementation CHBMapLevelView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void)initialize {
    self.starsView = [CHBImageView new];
    self.levelView = [CHBImageView new];
    [self addSubview:self.levelView];
    [self addSubview:self.starsView];
    
    self.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self pinItemFillAll:self.levelView];
    [self pinItemFillHorizontally:self.starsView];
    [self pinItem:self.levelView attribute:NSLayoutAttributeBottom to:self.starsView withOffset:8.0 andScale:1.0];
    [self pinItem:self.levelView attribute:NSLayoutAttributeHeight to:self.starsView withOffset:0.0 andScale:4.0];
    
//    self.backgroundColor = [UIColor redColor];
//    self.levelView.backgroundColor = [UIColor greenColor];
//    self.starsView.backgroundColor = [UIColor blueColor];
}

- (void)setStarMode:(CHBMapLevelViewsStarMode)starMode {
    _starMode = starMode;
    switch (starMode) {
        case CHBMapLevelViewStarModeInactive:
            self.starsView.image = [UIImage imageNamed:@"single_landing_stars_locked"];
            break;
        case CHBMapLevelViewStarModeNone:
            self.starsView.image = [UIImage imageNamed:@"single_landing_stars_0"];
            break;
        case CHBMapLevelViewStarModeOne:
            self.starsView.image = [UIImage imageNamed:@"single_landing_stars_1"];
            break;
        case CHBMapLevelViewStarModeTwo:
            self.starsView.image = [UIImage imageNamed:@"single_landing_stars_2"];
            break;
        case CHBMapLevelViewStarModeThree:
            self.starsView.image = [UIImage imageNamed:@"single_landing_stars_3"];
            break;
    }
}

// NOTE: for now, must set star mode before setting level mode

- (void)setLevel:(CHBGameLevel)level {
    _level = level;
    switch (level) {
        case CHBGameLevelFirst:
            if (self.starMode == CHBMapLevelViewStarModeInactive) {
                self.levelView.image = [UIImage imageNamed:@"single_landing_level1_locked"];
            } else if (self.starMode == CHBMapLevelViewStarModeNone) {
                self.levelView.image = [UIImage imageNamed:@"single_landing_level1_incomplete"];
            } else {
                self.levelView.image = [UIImage imageNamed:@"single_landing_level1_complete"];
            }
            break;
        case CHBGameLevelSecond:
            if (self.starMode == CHBMapLevelViewStarModeInactive) {
                self.levelView.image = [UIImage imageNamed:@"single_landing_level2_locked"];
            } else if (self.starMode == CHBMapLevelViewStarModeNone) {
                self.levelView.image = [UIImage imageNamed:@"single_landing_level2_incomplete"];
            } else {
                self.levelView.image = [UIImage imageNamed:@"single_landing_level2_complete"];
            }
            break;
        case CHBGameLevelThird:
            if (self.starMode == CHBMapLevelViewStarModeInactive) {
                self.levelView.image = [UIImage imageNamed:@"single_landing_level3_locked"];
            } else if (self.starMode == CHBMapLevelViewStarModeNone) {
                self.levelView.image = [UIImage imageNamed:@"single_landing_level3_incomplete"];
            } else {
                self.levelView.image = [UIImage imageNamed:@"single_landing_level3_complete"];
            }
            break;
    }
}

@end
