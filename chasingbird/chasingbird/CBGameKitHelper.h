//
//  CBGameKitHelper.h
//  chasingbird
//
//  Created by Howard on 2015-08-22.
//  Copyright © 2015 howalee. All rights reserved.
//

#import <Foundation/Foundation.h>
@import GameKit;

extern NSString *const PresentAuthenticationViewController;

@interface CBGameKitHelper : NSObject
@property (nonatomic, readonly) UIViewController *authenticationViewController;
@property (nonatomic, readonly) NSError *lastError;
@property (nonatomic, retain) NSString *leaderboardIdentifier;

+ (instancetype)sharedGameKitHelper;
- (void)authenticateLocalPlayer;
- (void)reportScore:(NSInteger)score;
@end
