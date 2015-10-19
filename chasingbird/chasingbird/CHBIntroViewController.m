//
//  CHBIntroViewController.m
//  chasingbird
//
//  Created by Rock Lee on 2015-10-17.
//  Copyright © 2015 howalee. All rights reserved.
//

#import "CHBIntroViewController.h"
#import "CHBStartViewController.h"

@interface CHBIntroViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *titleLevelView;
@property (weak, nonatomic) IBOutlet UIImageView *headingView;
@property (weak, nonatomic) IBOutlet UIImageView *nextButton;
@end

@implementation CHBIntroViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    switch (self.level) {
        case CHBGameLevelFirst:
            self.headingView.image = [UIImage imageNamed:@"heading_level1"];
            self.titleLevelView.image = [UIImage imageNamed:@"title_level1"];
            break;
        case CHBGameLevelSecond:
            self.headingView.image = [UIImage imageNamed:@"heading_level2"];
            self.titleLevelView.image = [UIImage imageNamed:@"title_level2"];
            break;
        case CHBGameLevelThird:
            self.headingView.image = [UIImage imageNamed:@"heading_level3"];
            self.titleLevelView.image = [UIImage imageNamed:@"title_level3"];
            break;
        default:
            break;
    }
    
    self.nextButton.userInteractionEnabled = YES;
    [self.nextButton addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(nextButtonDidTap:)]];
    
    [self setupBackButton];
}

- (void)nextButtonDidTap:(id)sender {
    CHBStartViewController *vc = [CHBStartViewController new];
    vc.level = self.level;
    [self.navigationController pushViewController:vc animated:NO];
}

@end
