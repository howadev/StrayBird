//
//  CHBAchievementsTableView.h
//  chasingbird
//
//  Created by Rock Lee on 2015-11-09.
//  Copyright © 2015 howalee. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CHBAchievementsTableViewDelegate <NSObject>
- (void)achievementsTableViewDidGetViewController:(UIViewController*)viewController;
@end

@interface CHBAchievementsTableView : UITableView
@property (nonatomic, weak) id <CHBAchievementsTableViewDelegate> achievementDelegate;
@property (nonatomic, retain) NSArray *achievements;
@end
