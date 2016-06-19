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
#import "CHBConf.h"
#import "UIView+AutoLayoutHelpers.h"
#import "CHBTracker.h"

@interface CHBHomeViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *singlePlayerView;
@property (weak, nonatomic) IBOutlet UIImageView *multiPlayerView;
@property (weak, nonatomic) IBOutlet UIButton *sensorTagButton;
@property (retain, nonatomic) UILabel *versionLabel;
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
    
    self.versionLabel = [UILabel new];
    self.versionLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.versionLabel];
    [self.view pinItem:self.versionLabel attribute:NSLayoutAttributeLeft to:self.view];
    [self.view pinItem:self.versionLabel attribute:NSLayoutAttributeBottom to:self.view];
    
    self.versionLabel.text = [CHBConf initialGroupString];
 
    NSDate *firstOpenTime = [[NSUserDefaults standardUserDefaults] objectForKey:@"FirstOpenTime"];
    if (firstOpenTime) {
        self.versionLabel.text = [NSString stringWithFormat:@"%@/%@", [CHBConf initialGroupString], firstOpenTime];
    }
    
    switch ([CHBConf initialGroup]) {
        case CHBGroupFirst:
            self.multiPlayerView.alpha = 0;
            break;
        case CHBGroupSecond:
            self.multiPlayerView.alpha = 1;
            break;
        case CHBGroupThird:
            self.multiPlayerView.alpha = [CHBConf daysSinceFirstOpenTime] >= 20 ? 1 : 0;
            break;
    }
    
    if ([CHBConf initialGroup] == CHBGroupThird) {
        NSInteger days = [CHBConf daysSinceFirstOpenTime];
        if (days >= 10) {
            BOOL shownTenDaysFeature = [[NSUserDefaults standardUserDefaults] boolForKey:@"shownTenDaysFeature"];
            if (!shownTenDaysFeature) {
                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"shownTenDaysFeature"];
                UIAlertController *alert= [UIAlertController alertControllerWithTitle:@"New Feature" message:@"add customized bird colour choices for level 1" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction* action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
                [alert addAction:action];
                [self presentViewController:alert animated:YES completion:nil];
            }
        }
        
        if (days >= 20) {
            BOOL shownTwentyDaysFeature = [[NSUserDefaults standardUserDefaults] boolForKey:@"shownTwentyDaysFeature"];
            if (!shownTwentyDaysFeature) {
                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"shownTwentyDaysFeature"];
                UIAlertController *alert= [UIAlertController alertControllerWithTitle:@"New Feature" message:@"add multiplayer leaderboard and challenge box" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction* action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
                [alert addAction:action];
                [self presentViewController:alert animated:YES completion:nil];
            }
        }
        
        if (days >= 30) {
            BOOL shownThirtyDaysFeature = [[NSUserDefaults standardUserDefaults] boolForKey:@"shownThirtyDaysFeature"];
            if (!shownThirtyDaysFeature) {
                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"shownThirtyDaysFeature"];
                UIAlertController *alert= [UIAlertController alertControllerWithTitle:@"New Feature" message:@"add level 2 (with bird net)" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction* action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
                [alert addAction:action];
                [self presentViewController:alert animated:YES completion:nil];
            }
        }
        
        if (days >= 40) {
            BOOL shownFortyDaysFeature = [[NSUserDefaults standardUserDefaults] boolForKey:@"shownFortyDaysFeature"];
            if (!shownFortyDaysFeature) {
                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"shownFortyDaysFeature"];
                UIAlertController *alert= [UIAlertController alertControllerWithTitle:@"New Feature" message:@"add customized background colour choices for level 2" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction* action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
                [alert addAction:action];
                [self presentViewController:alert animated:YES completion:nil];
            }
        }
        
        if (days >= 50) {
            BOOL shownFiftyDaysFeature = [[NSUserDefaults standardUserDefaults] boolForKey:@"shownFiftyDaysFeature"];
            if (!shownFiftyDaysFeature) {
                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"shownFiftyDaysFeature"];
                UIAlertController *alert= [UIAlertController alertControllerWithTitle:@"New Feature" message:@"add achievements" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction* action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
                [alert addAction:action];
                [self presentViewController:alert animated:YES completion:nil];
            }
        }
        
        if (days >= 60) {
            BOOL shownSixtyDaysFeature = [[NSUserDefaults standardUserDefaults] boolForKey:@"shownSixtyDaysFeature"];
            if (!shownSixtyDaysFeature) {
                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"shownSixtyDaysFeature"];
                UIAlertController *alert= [UIAlertController alertControllerWithTitle:@"New Feature" message:@"add level 3 (with thunderstorm)" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction* action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
                [alert addAction:action];
                [self presentViewController:alert animated:YES completion:nil];
            }
        }
    }
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
    [CHBTracker createEventWithCategory:@"SensorTagButton" action:@"Tap"];
    [CHBDeviceHelpers sharedInstance].deviceType = CHBDeviceTypeSensorTag;
    CHBSensorTagViewController *vc = [CHBSensorTagViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)singlePlayerViewDidTap:(id)sender {
    [CHBTracker createEventWithCategory:@"SinglePlayerButton" action:@"Tap"];
    CHBMapViewController *vc = [CHBMapViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)multiPlayerViewDidTap:(id)sender {
    [CHBTracker createEventWithCategory:@"MultiPlayersButton" action:@"Tap"];
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
