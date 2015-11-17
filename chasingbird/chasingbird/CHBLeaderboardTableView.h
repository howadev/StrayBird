//
//  CHBLeaderboardTableView.h
//  chasingbird
//
//  Created by Rock Lee on 2015-11-09.
//  Copyright © 2015 howalee. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GKScore;

@protocol CHBLeaderboardTableViewDelegate <NSObject>
- (void)leaderboardTableView:(UITableView*)tableView didSelectScore:(GKScore*)score;
@end

@interface CHBLeaderboardTableView : UITableView
@property (nonatomic, weak) id <CHBLeaderboardTableViewDelegate> leaderboardDelegate;
@property (nonatomic, retain) NSArray *scores;
@end
