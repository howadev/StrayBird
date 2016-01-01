//
//  CHBLEOViewController.h
//  chasingbird
//
//  Created by Haohua Li on 2015-12-31.
//  Copyright © 2015 howalee. All rights reserved.
//

#import "CHBViewController.h"
#import <LEO/LEOBluetooth.h>
#import <LEO/LEODataDelegate.h>

@interface CHBLEOViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate, LEOBluetoothDelegate, LEODataDelegate>

@end
