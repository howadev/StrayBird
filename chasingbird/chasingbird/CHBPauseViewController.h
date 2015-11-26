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

@interface CHBPauseViewController : CHBViewController
@property (nonatomic, assign) CHBGameLevel level;
@property (nonatomic, assign) BOOL multiplePlayers;
@property (nonatomic, retain) CHBPerformance *performance;
@end
