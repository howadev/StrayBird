//
//  CHBColorViewController.m
//  StrayBird
//
//  Created by Rock Lee on 2016-04-19.
//  Copyright © 2016 howalee. All rights reserved.
//

#import "CHBColorViewController.h"
#import "HRColorPickerView.h"
#import "UIView+AutoLayoutHelpers.h"

@implementation CHBColorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.tintAdjustmentMode = UIViewTintAdjustmentModeNormal;
    
    self.colorPickerView = [[HRColorPickerView alloc] init];
    self.colorPickerView.color = [UIColor blueColor];
    self.colorPickerView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.colorPickerView];
    [self.view pinItemFillAll:self.colorPickerView];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneAction)];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                           forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
}

- (void)doneAction {
    [self.delegate colorViewControllerDidTapDone:self];
}

@end
