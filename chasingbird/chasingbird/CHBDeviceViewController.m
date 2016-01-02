//
//  CHBDeviceViewController.m
//  chasingbird
//
//  Created by Haohua Li on 2015-12-31.
//  Copyright © 2015 howalee. All rights reserved.
//

#import "CHBDeviceViewController.h"
#import "CHBLEOViewController.h"
#import "CHBSensorTagViewController.h"
#import "CHBDeviceHelpers.h"

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
    [CHBDeviceHelpers sharedInstance].deviceType = CHBDeviceTypeAppleWatch;
    BOOL connected = [[CHBDeviceHelpers sharedInstance] connectAppleWatch];
    if (connected) {
        [[NSNotificationCenter defaultCenter] postNotificationName:homeNotification object:nil];
    } else {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Error" message:@"Apple Watch is not connected. Please try to open Stray Bird on Apple Watch." preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
        [alertController addAction:cancelAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}

- (IBAction)didSelectLEO:(id)sender {
    [CHBDeviceHelpers sharedInstance].deviceType = CHBDeviceTypeLEO;
    CHBLEOViewController *vc = [CHBLEOViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)didSelectSensorTag:(id)sender {
    [CHBDeviceHelpers sharedInstance].deviceType = CHBDeviceTypeSensorTag;
    CHBSensorTagViewController *vc = [CHBSensorTagViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
