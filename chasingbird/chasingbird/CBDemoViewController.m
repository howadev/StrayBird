//
//  CBDemoViewController.m
//  chasingbird
//
//  Created by Howard on 2015-08-08.
//  Copyright © 2015 howalee. All rights reserved.
//

#import "CBDemoViewController.h"
#import "CBTimerView.h"
#import "CBWorkoutController.h"
#import "CBGameKitHelper.h"

@interface CBDemoViewController () <CBWorkoutControllerDelegate>
@property (nonatomic, retain) NSTimer *timer;
@property (nonatomic, retain) CBTimerView *timerView;
@property (nonatomic, retain) CBWorkoutController *workoutController;
@end

@implementation CBDemoViewController {
    NSUInteger seconds;
    double walkingRuningDistance;
}

#pragma mark - View Life Cycle

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self refreshStatistics];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshStatistics) name:UIApplicationDidBecomeActiveNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showAuthenticationViewController) name:PresentAuthenticationViewController object:nil];
    
    [[CBGameKitHelper sharedGameKitHelper]
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
    
    self.timerView = [CBTimerView new];
    self.timerView.startButton.enabled = YES;
    self.timerView.stopButton.enabled = NO;
    [self.timerView.startButton addTarget:self action:@selector(startTimer) forControlEvents:UIControlEventTouchUpInside];
    [self.timerView.stopButton addTarget:self action:@selector(stopTimer) forControlEvents:UIControlEventTouchUpInside];
    
    self.workoutController = [CBWorkoutController new];
    self.workoutController.delegate = self;
    
    walkingRuningDistance = 0.0;
}

- (void)showAuthenticationViewController
{
    CBGameKitHelper *gameKitHelper = [CBGameKitHelper sharedGameKitHelper];
    
    [self presentViewController:gameKitHelper.authenticationViewController animated:YES completion:nil];
}


- (void)startTimer {
    
    self.timerView.startButton.enabled = NO;
    self.timerView.stopButton.enabled = YES;
    
    seconds = 0;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self
                                                selector:@selector(refreshTimeLabel:)
                                                userInfo:nil repeats:YES];
    
    [self.workoutController fetchWorkoutDataInMode:CBWorkoutModeWalkingRunningDistance startingAt:[NSDate date]];
}

- (void)stopTimer {
    
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

- (void)workoutControllerDidGetValue:(double)value inMode:(CBWorkoutMode)mode {
    walkingRuningDistance = value;
    [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:CBWorkoutModeWalkingRunningDistance inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
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
        case CBWorkoutModeSteps: {
            cell.textLabel.text = @"Steps:";
            cell.detailTextLabel.text = @"0";
            break;
        }
        case CBWorkoutModeWalkingRunningDistance: {
            cell.textLabel.text = @"Walking+Running Distance:";
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%f", walkingRuningDistance];
            break;
        }
        case CBWorkoutModeBikingDistance: {
            cell.textLabel.text = @"Biking Distance:";
            cell.detailTextLabel.text = @"2";
            break;
        }
        case CBWorkoutModeEnergy: {
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
