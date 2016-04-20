//
//  CHBPauseViewController.h
//  chasingbird
//
//  Created by Rock Lee on 2015-10-18.
//  Copyright © 2015 howalee. All rights reserved.
//

#import "CHBViewController.h"
#import "CHBTypes.h"
#import "CHBPerformance.h"
@class CHBPauseViewController;

@protocol CHBPauseViewControllerDelegate <NSObject>
- (void)pauseViewControllerDidTapResume:(CHBPauseViewController*)vc;
@end

@interface CHBPauseViewController : CHBViewController
@property (nonatomic, weak) id <CHBPauseViewControllerDelegate> delegate;
@property (nonatomic, assign) CHBGameLevel level;
@property (nonatomic, assign) BOOL multiplePlayers;
@property (nonatomic, retain) CHBPerformance *performance;
@end
