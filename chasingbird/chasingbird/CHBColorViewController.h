//
//  CHBColorViewController.h
//  StrayBird
//
//  Created by Rock Lee on 2016-04-19.
//  Copyright © 2016 howalee. All rights reserved.
//

#import "CHBViewController.h"
@class HRColorPickerView, CHBColorViewController;

@protocol CHBColorViewControllerDelegate <NSObject>
- (void)colorViewControllerDidTapDone:(CHBColorViewController*)vc;
@end

@interface CHBColorViewController : CHBViewController
@property (nonatomic, weak) id <CHBColorViewControllerDelegate> delegate;
@property (nonatomic, retain) HRColorPickerView *colorPickerView;
@end

