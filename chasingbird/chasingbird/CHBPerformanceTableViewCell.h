//
//  CHBPerformanceTableViewCell.h
//  chasingbird
//
//  Created by Rock Lee on 2015-11-16.
//  Copyright © 2015 howalee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CHBPerformanceTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *identifierLabel;
@property (weak, nonatomic) IBOutlet UILabel *valueLabel;

@end
