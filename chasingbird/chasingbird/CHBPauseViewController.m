//
//  CHBPauseViewController.m
//  chasingbird
//
//  Created by Rock Lee on 2015-10-18.
//  Copyright © 2015 howalee. All rights reserved.
//

#import "CHBPauseViewController.h"
#import "CHBGameViewController.h"

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
    
    NSDictionary *dict = @{@"level":@(self.level)};
    [[NSNotificationCenter defaultCenter] postNotificationName:restartNotification object:nil userInfo:dict];
}

- (IBAction)resumeAction:(id)sender {
    // TODO set paused to NO after dismission
    if ([self.presentingViewController isKindOfClass:[CHBGameViewController class]]) {
        CHBGameViewController *vc = (CHBGameViewController*)self.presentingViewController;
        vc.paused = NO;
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
