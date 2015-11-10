//
//  CHBChallengeTableView.m
//  chasingbird
//
//  Created by Rock Lee on 2015-11-09.
//  Copyright © 2015 howalee. All rights reserved.
//

#import "CHBChallengeTableView.h"
#import "CHBChallengeTableViewCell.h"
#import "CHBGameKitHelper.h"

@interface CHBChallengeTableView () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation CHBChallengeTableView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self initialize];
}

- (void)initialize {
    self.clipsToBounds = YES;
    self.backgroundColor = [UIColor clearColor];
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.rowHeight = 100.0;
    self.scrollEnabled = YES;
    self.showsVerticalScrollIndicator = NO;
    
    [self registerNib:[UINib nibWithNibName:@"CHBChallengeTableViewCell" bundle:nil] forCellReuseIdentifier:NSStringFromClass([CHBChallengeTableViewCell class])];
    self.delegate = self;
    self.dataSource = self;
}

#pragma mark - UITableViewDelegate

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.challenges.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CHBChallengeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CHBChallengeTableViewCell class]) forIndexPath:indexPath];
    GKChallenge *challenge = self.challenges[indexPath.row];
    cell.nameLabel.text =  challenge.issuingPlayer.displayName;
    cell.statusLabel.text = challenge.message;
    return cell;
}

@end
