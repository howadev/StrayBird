//
//  CHBHomeViewController.m
//  chasingbird
//
//  Created by Howard on 2015-08-26.
//  Copyright © 2015 howalee. All rights reserved.
//

#import "CHBHomeViewController.h"
#import "CHBMapViewController.h"
#import "CHBLandingViewController.h"
#import "CHBGameKitHelper.h"
#import "CHBDeviceHelpers.h"
#import "CHBSensorTagViewController.h"
#import "CHBLEOViewController.h"

@interface CHBHomeViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *singlePlayerView;
@property (weak, nonatomic) IBOutlet UIImageView *multiPlayerView;

@property (weak, nonatomic) IBOutlet UIButton *appleWatchButton;
@property (weak, nonatomic) IBOutlet UIButton *LEOButton;
@property (weak, nonatomic) IBOutlet UIButton *sensorTagButton;
@property (weak, nonatomic) IBOutlet UIButton *fingerButton;

@end

@implementation CHBHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITapGestureRecognizer *singleTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singlePlayerViewDidTap:)];
    singleTapGesture.numberOfTapsRequired = 1;
    [self.singlePlayerView addGestureRecognizer:singleTapGesture];
    
    UITapGestureRecognizer *multiTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(multiPlayerViewDidTap:)];
    multiTapGesture.numberOfTapsRequired = 1;
    [self.multiPlayerView addGestureRecognizer:multiTapGesture];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    BOOL connected = [CHBDeviceHelpers sharedInstance].connected;
    [self refreshMenu:connected];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showAuthenticationViewController) name:PresentAuthenticationViewController object:nil];
    
    [[CHBGameKitHelper sharedGameKitHelper]
     authenticateLocalPlayer];
}

- (void)refreshMenu:(BOOL)connected {
    self.singlePlayerView.hidden = !connected;
    self.multiPlayerView.hidden = !connected;
    self.appleWatchButton.hidden = connected;
    self.LEOButton.hidden = connected;
    self.sensorTagButton.hidden = connected;
    self.fingerButton.hidden = connected;
    [self.navigationController setNavigationBarHidden:connected animated:NO];
}

#pragma mark - Actions

- (IBAction)didSelectAppleWatch:(id)sender {
    [CHBDeviceHelpers sharedInstance].deviceType = CHBDeviceTypeAppleWatch;
    BOOL connected = [[CHBDeviceHelpers sharedInstance] connectAppleWatch];
    if (connected) {
        //[[NSNotificationCenter defaultCenter] postNotificationName:deviceConnectedNotification object:nil];
        [self refreshMenu:connected];
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

- (IBAction)didSelectFinger:(id)sender {
    [self refreshMenu:YES];
}


- (void)singlePlayerViewDidTap:(id)sender {
    CHBMapViewController *vc = [CHBMapViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)multiPlayerViewDidTap:(id)sender {
    CHBLandingViewController *vc = [CHBLandingViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

# pragma mark - Game Kit Helper

- (void)showAuthenticationViewController
{
    CHBGameKitHelper *gameKitHelper = [CHBGameKitHelper sharedGameKitHelper];
    
    [self presentViewController:gameKitHelper.authenticationViewController animated:YES completion:nil];
}

@end
