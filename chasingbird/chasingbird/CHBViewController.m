//
//  CHBViewController.m
//  chasingbird
//
//  Created by Howard on 2015-08-26.
//  Copyright © 2015 howalee. All rights reserved.
//

#import "CHBViewController.h"
#import "UIView+AutoLayoutHelpers.h"

@interface CHBViewController ()

@end

@implementation CHBViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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

- (void)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
