//
//  CHBPerformanceTableView.m
//  chasingbird
//
//  Created by Rock Lee on 2015-10-18.
//  Copyright © 2015 howalee. All rights reserved.
//

#import "CHBPerformanceTableView.h"
#import "CHBPerformanceTableViewCell.h"
#import "CHBPerformanceHelper.h"

@interface CHBPerformanceTableView () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation CHBPerformanceTableView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self initialize];
}

- (void)initialize {
    self.clipsToBounds = NO;
    self.backgroundColor = [UIColor clearColor];
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.rowHeight = 70.0;
    self.scrollEnabled = YES;
    
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
    switch (indexPath.row) {
        case 0: {
            cell.identifierLabel.text = @"POINTS";
            NSInteger value = [CHBPerformanceHelper sharedHelper].points;
            cell.valueLabel.text = [NSString stringWithFormat:@"%ld", value];
            break;
        }
        case 1: {
            cell.identifierLabel.text = @"WINS";
            NSInteger value = [CHBPerformanceHelper sharedHelper].wins;
            cell.valueLabel.text = [NSString stringWithFormat:@"%ld", value];
            break;
        }
        case 2: {
            cell.identifierLabel.text = @"LOSSES";
            NSInteger value = [CHBPerformanceHelper sharedHelper].losses;
            cell.valueLabel.text = [NSString stringWithFormat:@"%ld", value];
            break;
        }
        case 3: {
            cell.identifierLabel.text = @"CALORIES";
            NSInteger value = [CHBPerformanceHelper sharedHelper].calories;
            cell.valueLabel.text = [NSString stringWithFormat:@"%ld", value];
            break;
        }
        case 4: {
            cell.identifierLabel.text = @"DISTANCE";
            NSInteger value = [CHBPerformanceHelper sharedHelper].distance;
            cell.valueLabel.text = [NSString stringWithFormat:@"%ld", value];
            break;
        }
        case 5: {
            cell.identifierLabel.text = @"SPEED";
            NSInteger value = [CHBPerformanceHelper sharedHelper].speed;
            cell.valueLabel.text = [NSString stringWithFormat:@"%ld", value];
            break;
        }
            
        default:
            break;
    }
    return cell;
}

@end
