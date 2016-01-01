//
//  CHBLEOViewController.m
//  chasingbird
//
//  Created by Haohua Li on 2015-12-31.
//  Copyright © 2015 howalee. All rights reserved.
//

#import "CHBLEOViewController.h"
#import <LEO/LEOManager.h>
#import <LEO/LEORepetition.h>

@interface CHBLEOViewController ()

@end

@implementation CHBLEOViewController {
    UITableView *leoTableView;
    NSMutableArray *leos;
    LEOManager *leoManager;
    LEOBluetooth *streamingLEO;
}

- (void)viewDidLoad {
    leos = [[NSMutableArray alloc] init];
    leoTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    leoTableView.delegate = self;
    leoTableView.dataSource = self;
    
    [self.view addSubview:leoTableView];
    
    leoManager = [LEOManager sharedInstance];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]
                                              initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                              target:self
                                              action:@selector(cancelButton:)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]
                                              initWithBarButtonSystemItem:UIBarButtonSystemItemSearch
                                              target:self
                                              action:@selector(scanButton:)];
}

- (void)cancelButton:(id)sender {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)scanButton:(id)sender {
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]
                                              initWithBarButtonSystemItem:UIBarButtonSystemItemStop
                                              target:self
                                              action:@selector(stopScanButton:)];
    [leoManager discoverLEOs:^(LEOBluetooth *LEO) {
        LEO.delegate = self;
        [leos addObject:LEO];
        [leoTableView reloadData];
    }];
}

- (void)stopScanButton:(id)sender {
    [leoManager stopDiscoveringLEOs];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]
                                              initWithBarButtonSystemItem:UIBarButtonSystemItemSearch
                                              target:self
                                              action:@selector(scanButton:)];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [leos count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"LEOExampleTableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:simpleTableIdentifier];
        cell.textLabel.text = ((LEOBluetooth *)[leos objectAtIndex:indexPath.row]).name;
    }
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [leoManager connectLEO:[leos objectAtIndex:indexPath.row] completionHandler:^(LEOBluetooth *LEO, NSError *error) {
        if (!error) {
            NSLog(@"Successful connection, wait for successful setup");
        } else {
            NSLog(@"Unsuccessful connection");
        }
    }];
}

#pragma mark - LEOBluetoothDelegate
- (void)LEO:(LEOBluetooth *)LEO didDiscoverUserID:(NSUInteger)userID {
    // Your code here
}
- (void)LEORequiresCalibration:(LEOBluetooth *)LEO {
    // Your code here
}

- (void)LEODidCompleteSetupProcedure:(LEOBluetooth *)LEO error:(NSError*)error {
    if (!error) {
        LEOSettings *settings = [[LEOSettings alloc] initWithLEOFeatures:@[[NSNumber numberWithInt:LEOFeatureCadence]]
                                                     coreLocationEnabled:YES
                                                                activity:LEOActivityWalking];
        //LEOSettings *settings = [LEOSettings defaultSettings];
        [LEO beginStreamingDataForSettings:settings toDelegate:self];
    } else {
        NSLog(@"Setup error");
    }
}

- (void)LEO:(LEOBluetooth *)LEO didBeginStreamingSession:(LEOStreamingSession *)session {
    streamingLEO = LEO;
}

- (void)LEO:(LEOBluetooth *)LEO didFailToBeginStreaming:(NSError *)error {
    // Your code here
}

- (void)LEODidStopStreaming:(LEOBluetooth *)LEO {
    [[LEOManager sharedInstance] disconnectLEO:LEO completionHandler:^(LEOBluetooth *LEO, NSError *error) {
        if (!error) {
            NSLog(@"Successful disconnection");
        } else {
            NSLog(@"Unsuccessful disconnection");
        }
    }];
}

#pragma mark - LEODataDelegate
- (void)LEO:(LEOBluetooth *)LEO didSendRepetition:(LEORepetition *)repetition {
    NSLog(@"Did receive cadence: %tu", repetition.cadence);
    NSLog(@"Difference from previous cadence: %tu", repetition.cadence - repetition.previousRepetition.cadence);
}

- (void)LEO:(LEOBluetooth *)LEO didUpdateActivity:(LEOActivity)activity {
    //NSLog(@"didUpdateActivity");
}

@end
