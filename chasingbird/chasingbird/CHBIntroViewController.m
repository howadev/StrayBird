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
@property (weak, nonatomic) IBOutlet UIImageView *nextButton;
@end

@implementation CHBIntroViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.nextButton.userInteractionEnabled = YES;
    [self.nextButton addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(nextButtonDidTap:)]];
    
    [self setupBackButton];
}

- (void)nextButtonDidTap:(id)sender {
    CHBStartViewController *vc = [CHBStartViewController new];
    [self.navigationController pushViewController:vc animated:NO];
}

@end
