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

+ (instancetype)sharedGameKitHelper;
- (void)authenticateLocalPlayer;
@end
