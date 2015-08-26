//
//  CBDemoViewController.m
//  chasingbird
//
//  Created by Howard on 2015-08-08.
//  Copyright © 2015 howalee. All rights reserved.
//

#import "CHBDemoViewController.h"
#import "CHBTimerView.h"
#import "CHBWorkoutController.h"
#import "CHBGameKitHelper.h"

@interface CHBDemoViewController () <CHBWorkoutControllerDelegate, GKGameCenterControllerDelegate>
@property (nonatomic, retain) NSTimer *timer;
@property (nonatomic, retain) CHBTimerView *timerView;
@property (nonatomic, retain) CHBWorkoutController *workoutController;
@end

@implementation CHBDemoViewController {
    NSUInteger seconds;
    double walkingRuningDistance;
}

#pragma mark - View Life Cycle

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self refreshStatistics];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshStatistics) name:UIApplicationDidBecomeActiveNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showAuthenticationViewController) name:PresentAuthenticationViewController object:nil];
    
    [[CHBGameKitHelper sharedGameKitHelper]
     authenticateLocalPlayer];

}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    [self.timer invalidate];
    self.timer = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Chasing Bird";
    
    UIRefreshControl *refreshControl = [UIRefreshControl new];
    [refreshControl addTarget:self action:@selector(refreshStatistics) forControlEvents:UIControlEventValueChanged];
    self.refreshControl = refreshControl;
    
    self.timerView = [CHBTimerView new];
    self.timerView.startButton.enabled = YES;
    self.timerView.stopButton.enabled = NO;
    [self.timerView.startButton addTarget:self action:@selector(startTimer) forControlEvents:UIControlEventTouchUpInside];
    [self.timerView.stopButton addTarget:self action:@selector(stopTimer) forControlEvents:UIControlEventTouchUpInside];
    
    self.workoutController = [CHBWorkoutController new];
    self.workoutController.delegate = self;
    
    walkingRuningDistance = 0.0;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(showLeaderboardAndAchievements:)];
}

# pragma mark - Game Kit

- (void)showAuthenticationViewController
{
    CHBGameKitHelper *gameKitHelper = [CHBGameKitHelper sharedGameKitHelper];
    
    [self presentViewController:gameKitHelper.authenticationViewController animated:YES completion:nil];
}

-(void)showLeaderboardAndAchievements:(BOOL)shouldShowLeaderboard{
    GKGameCenterViewController *gcViewController = [[GKGameCenterViewController alloc] init];
    
    gcViewController.gameCenterDelegate = self;
    
    if (shouldShowLeaderboard) {
        gcViewController.viewState = GKGameCenterViewControllerStateLeaderboards;
        gcViewController.leaderboardIdentifier = [CHBGameKitHelper sharedGameKitHelper].leaderboardIdentifier;
    } else{
        gcViewController.viewState = GKGameCenterViewControllerStateAchievements;
    }
    
    [self presentViewController:gcViewController animated:YES completion:nil];
}

- (void)gameCenterViewControllerDidFinish:(GKGameCenterViewController *)gameCenterViewController {
    [gameCenterViewController dismissViewControllerAnimated:YES completion:nil];
}

# pragma mark - Timer

- (void)startTimer {
    
    self.timerView.startButton.enabled = NO;
    self.timerView.stopButton.enabled = YES;
    
    seconds = 0;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self
                                                selector:@selector(refreshTimeLabel:)
                                                userInfo:nil repeats:YES];
    
    [self.workoutController fetchWorkoutDataInMode:CHBWorkoutModeWalkingRunningDistance startingAt:[NSDate date]];
}

- (void)stopTimer {
    
    [[CHBGameKitHelper sharedGameKitHelper] reportScore:seconds];
    
    self.timerView.startButton.enabled = YES;
    self.timerView.stopButton.enabled = NO;
    
    seconds = 0;
    [self.timerView setTimerLabelWithSeconds:seconds];
    [self.timer invalidate];
    self.timer = nil;
    
    [self.workoutController stopFetchingWorkoutData];
}

-(void)refreshTimeLabel:(id)sender
{
    [self.timerView setTimerLabelWithSeconds:seconds++];
}

#pragma mark - CBWorkoutControllerDelegate

- (void)workoutControllerDidGetValue:(double)value inMode:(CHBWorkoutMode)mode {
    walkingRuningDistance = value;
    [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:CHBWorkoutModeWalkingRunningDistance inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - Reading HealthKit Data

- (void)refreshStatistics {
    NSLog(@"start refresh");
    [self.refreshControl endRefreshing];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSAssert(indexPath.section == 0, @"Should only have one section");
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    switch (indexPath.row) {
        case CHBWorkoutModeSteps: {
            cell.textLabel.text = @"Steps:";
            cell.detailTextLabel.text = @"0";
            break;
        }
        case CHBWorkoutModeWalkingRunningDistance: {
            cell.textLabel.text = @"Walking+Running Distance:";
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%f", walkingRuningDistance];
            break;
        }
        case CHBWorkoutModeBikingDistance: {
            cell.textLabel.text = @"Biking Distance:";
            cell.detailTextLabel.text = @"2";
            break;
        }
        case CHBWorkoutModeEnergy: {
            cell.textLabel.text = @"Energy:";
            cell.detailTextLabel.text = @"3";
            break;
        }
        default:
            break;
    }
    return cell;
}

#pragma mark - UITableViewDelegate

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    NSAssert(section == 0, @"Should only have one section");
    return self.timerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50;
}

@end
