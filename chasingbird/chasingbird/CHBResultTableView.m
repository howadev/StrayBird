//
//  CHBResultTableView.m
//  chasingbird
//
//  Created by Rock Lee on 2015-11-21.
//  Copyright © 2015 howalee. All rights reserved.
//

#import "CHBResultTableView.h"
#import "CHBResultTableViewCell.h"

@interface CHBResultTableView () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation CHBResultTableView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self initialize];
}

- (void)initialize {
    self.clipsToBounds = NO;
    self.backgroundColor = [UIColor clearColor];
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.rowHeight = 44.0;
    self.scrollEnabled = YES;
    
    [self registerNib:[UINib nibWithNibName:@"CHBResultTableViewCell" bundle:nil] forCellReuseIdentifier:NSStringFromClass([CHBResultTableViewCell class])];
    self.delegate = self;
    self.dataSource = self;
}

#pragma mark - UITableViewDelegate

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CHBResultTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CHBResultTableViewCell class]) forIndexPath:indexPath];
    switch (indexPath.row) {
        case 0: {
            cell.identifierLabel.text = @"LEFT TIME";
            NSTimeInterval value = self.performance.leftTime;
            cell.valueLabel.text = [NSString stringWithFormat:@"%02lu:%02ld", (NSUInteger)value/60, (NSUInteger)value%60];
            break;
        }
        case 1: {
            cell.identifierLabel.text = @"FLOCK SPEED";
            NSTimeInterval value = self.performance.flockSpeed;
            cell.valueLabel.text = [NSString stringWithFormat:@"%.2f M/S", value];
            break;
        }
        case 2: {
            cell.identifierLabel.text = @"MAXIMUM SPEED";
            CGFloat value = self.performance.maximumSpeed;
            cell.valueLabel.text = [NSString stringWithFormat:@"%.2f M/S", value];
            break;
        }
        case 3: {
            cell.identifierLabel.text = @"CALORIES";
            CGFloat value = self.performance.overallCalories;
            cell.valueLabel.text = [NSString stringWithFormat:@"%.2f CAL", value];
            break;
        }
            
        default:
            break;
    }
    return cell;
}

@end
