//
//  CHBAchievementsTableView.h
//  chasingbird
//
//  Created by Rock Lee on 2015-11-09.
//  Copyright © 2015 howalee. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GKAchievement, GKAchievementDescription;

@protocol CHBAchievementsTableViewDelegate <NSObject>
- (void)achievementsTableView:(UITableView*)tableView didSelectAchievement:(GKAchievement*)achievement;
@end

@interface CHBAchievementsTableView : UITableView
@property (nonatomic, weak) id <CHBAchievementsTableViewDelegate> achievementDelegate;
@property (nonatomic, retain) NSArray<GKAchievementDescription*> *descriptions;
@property (nonatomic, retain) NSArray<GKAchievement*> *achievements;
@end
