//
//  CHBPauseViewController.m
//  chasingbird
//
//  Created by Rock Lee on 2015-10-18.
//  Copyright © 2015 howalee. All rights reserved.
//

#import "CHBPauseViewController.h"
#import "CHBTypes.h"

@interface CHBPauseViewController ()

@end

@implementation CHBPauseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor clearColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Actions

- (IBAction)homeAction:(id)sender {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:homeNotification object:nil];
}

- (IBAction)restartAction:(id)sender {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:restartNotification object:nil];
}

- (IBAction)resumeAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        //resume game scene
    }];
}

@end
