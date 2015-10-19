//
//  CHBGameViewController.h
//  chasingbird
//
//  Created by Howard on 2015-08-29.
//  Copyright © 2015 howalee. All rights reserved.
//

#import "CHBViewController.h"
#import "CHBTypes.h"

@interface CHBGameViewController : CHBViewController
@property (nonatomic, assign) BOOL paused;
@property (nonatomic, assign) CHBGameLevel level;
@end
