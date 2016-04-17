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

@interface CHBHomeViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *singlePlayerView;
@property (weak, nonatomic) IBOutlet UIImageView *multiPlayerView;
@property (weak, nonatomic) IBOutlet UIButton *sensorTagButton;
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
    self.sensorTagButton.hidden = connected;
    [self.navigationController setNavigationBarHidden:connected animated:NO];
}

#pragma mark - Actions

- (IBAction)didSelectSensorTag:(id)sender {
    [CHBDeviceHelpers sharedInstance].deviceType = CHBDeviceTypeSensorTag;
    CHBSensorTagViewController *vc = [CHBSensorTagViewController new];
    [self.navigationController pushViewController:vc animated:YES];
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
