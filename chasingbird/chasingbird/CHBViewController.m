//
//  CHBViewController.m
//  chasingbird
//
//  Created by Howard on 2015-08-26.
//  Copyright © 2015 howalee. All rights reserved.
//

#import "CHBViewController.h"
#import "UIView+AutoLayoutHelpers.h"
#import "CHBTracker.h"

@interface CHBViewController ()

@end

@implementation CHBViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [CHBTracker createScreenWithName:NSStringFromClass(self.class)];
}

- (void)setupBackButton {
    UIImage *backIcon = [UIImage imageNamed:@"btn_back"];
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.translatesAutoresizingMaskIntoConstraints = NO;
    [backButton addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    [backButton setBackgroundImage:backIcon forState:UIControlStateNormal];
    
    [self.view addSubview:backButton];
    [self.view pinItem:self.view attribute:NSLayoutAttributeLeft to:backButton withOffset:-16 andScale:1.0];
    [self.view pinItem:self.view attribute:NSLayoutAttributeTop to:backButton withOffset:-16 andScale:1.0];
}

- (void)setupSinglePlayerBackground {
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"main_background"]];
    [self.view addSubview:imageView];
    [self.view sendSubviewToBack:imageView];
    [self.view pinItemFillAll:imageView];
}

- (void)setupMultiPlayersBackground {
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"multi_background"]];
    imageView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:imageView];
    [self.view sendSubviewToBack:imageView];
    [self.view pinItemFillAll:imageView];
}

- (void)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
