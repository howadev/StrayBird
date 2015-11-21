//
//  CHBAchievementsTableView.m
//  chasingbird
//
//  Created by Rock Lee on 2015-11-09.
//  Copyright © 2015 howalee. All rights reserved.
//

#import "CHBAchievementsTableView.h"
#import "CHBAchievementsTableViewCell.h"
#import "CHBGameKitHelper.h"

@interface CHBAchievementsTableView () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation CHBAchievementsTableView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self initialize];
}

- (void)initialize {
    self.clipsToBounds = NO;
    self.backgroundColor = [UIColor clearColor];
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.rowHeight = 86.0;
    self.scrollEnabled = YES;
    self.showsVerticalScrollIndicator = NO;
    
    [self registerNib:[UINib nibWithNibName:@"CHBAchievementsTableViewCell" bundle:nil] forCellReuseIdentifier:NSStringFromClass([CHBAchievementsTableViewCell class])];
    self.delegate = self;
    self.dataSource = self;
}

#pragma mark - UITableViewDelegate

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    GKAchievementDescription *description = self.descriptions[indexPath.row];
    
    if (self.achievements) {
        for (GKAchievement *achievement in self.achievements) {
            if ([achievement.identifier isEqualToString:description.identifier]) {
                [self.achievementDelegate achievementsTableView:self didSelectAchievement:achievement];
            }
        }
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.descriptions.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CHBAchievementsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CHBAchievementsTableViewCell class]) forIndexPath:indexPath];
    GKAchievementDescription *description = self.descriptions[indexPath.row];
    cell.identifierLabel.text = description.title;
    cell.progressLabel.text = nil;
    
    if (self.achievements) {
        for (GKAchievement *achievement in self.achievements) {
            if ([achievement.identifier isEqualToString:description.identifier]) {
                cell.badgeImageView.highlighted = achievement.completed;
                cell.progressLabel.text = [NSString stringWithFormat:@"%.0f / 100", achievement.percentComplete];
            }
        }
    }
    
    return cell;
}

@end
