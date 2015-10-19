//
//  CHBStartViewController.m
//  chasingbird
//
//  Created by Howard on 2015-08-29.
//  Copyright © 2015 howalee. All rights reserved.
//

#import "CHBStartViewController.h"
#import "CHBGameViewController.h"

@interface CHBStartViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *skippingView;
@end

@implementation CHBStartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.skippingView.userInteractionEnabled = YES;
    [self.skippingView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(skippingViewDidTap:)]];
    
    [self setupBackButton];
}

- (void)skippingViewDidTap:(id)sender {
    
}

- (void)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:NO];
}

- (IBAction)playAction:(id)sender {
    CHBGameViewController *vc = [CHBGameViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
