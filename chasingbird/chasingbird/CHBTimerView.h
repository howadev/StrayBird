//
//  CBTimerView.h
//  chasingbird
//
//  Created by Howard on 2015-08-15.
//  Copyright © 2015 howalee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CHBTimerView : UIView
@property (nonatomic, retain) UIButton *startButton;
@property (nonatomic, retain) UIButton *stopButton;
@property (nonatomic, retain) UILabel *timerLabel;

- (void)setTimerLabelWithSeconds:(NSUInteger)seconds;
@end
