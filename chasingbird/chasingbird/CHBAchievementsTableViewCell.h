//
//  CHBAchievementsTableViewCell.h
//  chasingbird
//
//  Created by Rock Lee on 2015-11-09.
//  Copyright © 2015 howalee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CHBAchievementsTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *identifierLabel;
@property (weak, nonatomic) IBOutlet UILabel *progressLabel;
@property (weak, nonatomic) IBOutlet UIImageView *badgeImageView;
@end
