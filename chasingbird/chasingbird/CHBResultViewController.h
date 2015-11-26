//
//  CHBResultViewController.h
//  chasingbird
//
//  Created by Rock Lee on 2015-10-18.
//  Copyright © 2015 howalee. All rights reserved.
//

#import "CHBViewController.h"
#import "CHBTypes.h"
#import "CHBPerformance.h"

@interface CHBResultViewController : CHBViewController
@property (nonatomic, assign) CHBGameLevel level;
@property (nonatomic, retain) CHBPerformance *performance;
@property (nonatomic, assign) BOOL multiplePlayers;
@end
