//
//  CBTimerView.m
//  chasingbird
//
//  Created by Howard on 2015-08-15.
//  Copyright © 2015 howalee. All rights reserved.
//

#import "CBTimerView.h"
#import "UIView+AutoLayoutHelpers.h"

@implementation CBTimerView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.backgroundColor = [UIColor grayColor];
        
        self.startButton = [UIButton new];
        self.stopButton = [UIButton new];
        self.timerLabel = [UILabel new];
        
        [self.startButton setTitle:@"Start" forState:UIControlStateNormal];
        [self.stopButton setTitle:@"Stop" forState:UIControlStateNormal];
        self.timerLabel.text = @"00:00:00";
        self.timerLabel.textAlignment = NSTextAlignmentCenter;
        self.timerLabel.backgroundColor = [UIColor whiteColor];
        
        for (UIView *view in @[self.startButton, self.stopButton, self.timerLabel]) {
            view.translatesAutoresizingMaskIntoConstraints = NO;
            [self addSubview:view];
        }
        
        NSDictionary *views = @{
                                @"startButton":self.startButton,
                                @"stopButton":self.stopButton,
                                @"timerLabel":self.timerLabel,
                                          };
        
        NSArray *constraints = @[@"H:|-[stopButton]-[startButton]-[timerLabel]-|",
                                 @"V:|-[startButton]-|",
                                 @"V:|-[stopButton]-|",
                                 @"V:|-[timerLabel]-|",
                                            ];
        
        [self addVisualConstraints:constraints withBindings:views andMetrics:nil];
        
        [self pinItem:self.startButton attribute:NSLayoutAttributeRight to:self toAttribute:NSLayoutAttributeCenterX];
        [self pinItem:self.startButton attribute:NSLayoutAttributeWidth to:self.stopButton];
    }
    
    return self;
}

@end
