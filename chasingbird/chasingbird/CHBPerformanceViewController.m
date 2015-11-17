//
//  CHBPerformanceViewController.m
//  chasingbird
//
//  Created by Rock Lee on 2015-11-16.
//  Copyright © 2015 howalee. All rights reserved.
//

#import "CHBPerformanceViewController.h"
#import "CHBPerformanceTableView.h"

@interface CHBPerformanceViewController ()
@property (weak, nonatomic) IBOutlet CHBPerformanceTableView *tableView;

@end

@implementation CHBPerformanceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupBackButton];
    [self setupMultiPlayersBackground];
}

@end
