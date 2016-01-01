//
//  CHBDeviceViewController.m
//  chasingbird
//
//  Created by Haohua Li on 2015-12-31.
//  Copyright © 2015 howalee. All rights reserved.
//

#import "CHBDeviceViewController.h"
#import "CHBLEOViewController.h"

@interface CHBDeviceViewController ()

@end

@implementation CHBDeviceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Actions

- (IBAction)didSelectAppleWatch:(id)sender {
}

- (IBAction)didSelectLEO:(id)sender {
    CHBLEOViewController *vc = [CHBLEOViewController new];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:nav animated:YES completion:nil];
}

- (IBAction)didSelectSensorTag:(id)sender {
}

@end
