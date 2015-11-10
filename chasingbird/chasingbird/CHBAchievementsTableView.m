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
    self.clipsToBounds = YES;
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

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.achievements.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CHBAchievementsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CHBAchievementsTableViewCell class]) forIndexPath:indexPath];
    GKAchievement *achievement = self.achievements[indexPath.row];
    cell.badgeImageView.highlighted = achievement.completed;
    cell.identifierLabel.text = achievement.identifier;
    cell.progressLabel.text = [NSString stringWithFormat:@"%.0f / 100", achievement.percentComplete];
    return cell;
}

@end
