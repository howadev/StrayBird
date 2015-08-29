//
//  CHBExerciseModeViewController.m
//  chasingbird
//
//  Created by Howard on 2015-08-27.
//  Copyright © 2015 howalee. All rights reserved.
//

#import "CHBExerciseModeViewController.h"
#import "CHBImageView.h"

@interface CHBExerciseModeViewController ()

@end

@implementation CHBExerciseModeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CHBImageView *backgroundView = [[CHBImageView alloc] initWithFrame:self.view.bounds];
    backgroundView.image = [UIImage imageNamed:@"main_background"];
    [self.view addSubview:backgroundView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
