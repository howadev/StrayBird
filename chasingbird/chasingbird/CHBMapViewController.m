//
//  CHBMapViewController.m
//  chasingbird
//
//  Created by Howard on 2015-08-26.
//  Copyright © 2015 howalee. All rights reserved.
//

#import "CHBMapViewController.h"
#import "CHBImageView.h"

@interface CHBMapViewController ()

@end

@implementation CHBMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CHBImageView *backgroundView = [[CHBImageView alloc] initWithFrame:self.view.bounds];
    backgroundView.image = [UIImage imageNamed:@"single_landing_map"];
    [self.view addSubview:backgroundView];
}

@end
