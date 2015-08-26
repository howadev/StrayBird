//
//  CBGameKitHelper.m
//  chasingbird
//
//  Created by Howard on 2015-08-22.
//  Copyright © 2015 howalee. All rights reserved.
//

#import "CHBGameKitHelper.h"

NSString *const PresentAuthenticationViewController = @"present_authentication_view_controller";

@implementation CHBGameKitHelper {
    BOOL _enableGameCenter;
}

- (id)init
{
    self = [super init];
    if (self) {
        _enableGameCenter = YES;
    }
    return self;
}

+ (instancetype)sharedGameKitHelper
{
    static CHBGameKitHelper *sharedGameKitHelper;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedGameKitHelper = [[CHBGameKitHelper alloc] init];
    });
    return sharedGameKitHelper;
}

- (void)authenticateLocalPlayer
{
    GKLocalPlayer *localPlayer = [GKLocalPlayer localPlayer];
    
    localPlayer.authenticateHandler  =
    ^(UIViewController *viewController, NSError *error) {
    
        [self setLastError:error];
        
        if(viewController != nil) {
            [self setAuthenticationViewController:viewController];
        } else if([GKLocalPlayer localPlayer].isAuthenticated) {
            _enableGameCenter = YES;
            
            [[GKLocalPlayer localPlayer] loadDefaultLeaderboardIdentifierWithCompletionHandler:^(NSString *leaderboardIdentifier, NSError *error) {
                
                if (error != nil) {
                    NSLog(@"%@", [error localizedDescription]);
                }
                else{
                    _leaderboardIdentifier = leaderboardIdentifier;
                }
            }];
        } else {
            _enableGameCenter = NO;
        }
    };
}

- (void)setAuthenticationViewController:(UIViewController *)authenticationViewController
{
    if (authenticationViewController != nil) {
        _authenticationViewController = authenticationViewController;
        [[NSNotificationCenter defaultCenter]
         postNotificationName:PresentAuthenticationViewController
         object:self];
    }
}

- (void)setLastError:(NSError *)error
{
    _lastError = [error copy];
    if (_lastError) {
        NSLog(@"GameKitHelper ERROR: %@",
              [[_lastError userInfo] description]);
    }
}

- (void)reportScore:(NSInteger)score {
    if (_enableGameCenter && [_leaderboardIdentifier isEqual:@"score_board"]) {
        GKScore *_score = [[GKScore alloc] initWithLeaderboardIdentifier:_leaderboardIdentifier];
        _score.value = score;
        
        [GKScore reportScores:@[_score] withCompletionHandler:^(NSError *error) {
            if (error != nil) {
                NSLog(@"%@", [error localizedDescription]);
            } else {
                NSLog(@"reprot score successfully: %@", _score);
                if (score >= 5) {
                    [self updateAchievements];
                }
            }
        }];
        
        
    }
}

-(void)updateAchievements{

    GKAchievement *scoreAchievement = [[GKAchievement alloc] initWithIdentifier:@"finish_five_times"];
    scoreAchievement.percentComplete = 100.0;
    
    [GKAchievement reportAchievements:@[scoreAchievement] withCompletionHandler:^(NSError *error) {
        if (error != nil) {
            NSLog(@"%@", [error localizedDescription]);
        }
    }];
}

-(void)resetAchievements{
    [GKAchievement resetAchievementsWithCompletionHandler:^(NSError *error) {
        if (error != nil) {
            NSLog(@"%@", [error localizedDescription]);
        }
    }];
}

@end
