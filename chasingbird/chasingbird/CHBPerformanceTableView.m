//
//  CHBPerformanceTableView.m
//  chasingbird
//
//  Created by Rock Lee on 2015-10-18.
//  Copyright © 2015 howalee. All rights reserved.
//

#import "CHBPerformanceTableView.h"
#import "CHBPerformanceTableViewCell.h"

@interface CHBPerformanceTableView () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation CHBPerformanceTableView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self initialize];
}

- (void)initialize {
    self.clipsToBounds = YES;
    self.backgroundColor = [UIColor clearColor];
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.rowHeight = 50.0;
    self.scrollEnabled = NO;
    
    [self registerNib:[UINib nibWithNibName:@"CHBPerformanceTableViewCell" bundle:nil] forCellReuseIdentifier:NSStringFromClass([CHBPerformanceTableViewCell class])];
    self.delegate = self;
    self.dataSource = self;
}

#pragma mark - UITableViewDelegate

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CHBPerformanceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CHBPerformanceTableViewCell class]) forIndexPath:indexPath];
    return cell;
}

@end
