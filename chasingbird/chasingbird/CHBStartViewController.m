//
//  CHBStartViewController.m
//  chasingbird
//
//  Created by Howard on 2015-08-29.
//  Copyright © 2015 howalee. All rights reserved.
//

#import "CHBStartViewController.h"

@interface CHBStartViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *titleLevelView;
@property (weak, nonatomic) IBOutlet UIImageView *headingView;
@property (weak, nonatomic) IBOutlet UIImageView *skippingView;
@end

@implementation CHBStartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.skippingView.userInteractionEnabled = YES;
    [self.skippingView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(skippingViewDidTap:)]];
    
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
    
    [self setupBackButton];
}

- (void)skippingViewDidTap:(id)sender {
    
}

- (void)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:NO];
}

- (IBAction)playAction:(id)sender {
    NSDictionary *dict = @{@"level":@(self.level)};
    [[NSNotificationCenter defaultCenter] postNotificationName:playNotification object:nil userInfo:dict];
}

@end
