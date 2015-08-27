//
//  CHBHomeViewController.m
//  chasingbird
//
//  Created by Howard on 2015-08-26.
//  Copyright © 2015 howalee. All rights reserved.
//

#import "CHBHomeViewController.h"
#import "CHBMapViewController.h"

@interface CHBHomeViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *singlePlayerView;
@property (weak, nonatomic) IBOutlet UIImageView *multiPlayerView;

@end

@implementation CHBHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITapGestureRecognizer *singleTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singlePlayerViewDidTap:)];
    singleTapGesture.numberOfTapsRequired = 1;
    [self.singlePlayerView addGestureRecognizer:singleTapGesture];
}

- (void)singlePlayerViewDidTap:(id)sender {
    CHBMapViewController *vc = [CHBMapViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
