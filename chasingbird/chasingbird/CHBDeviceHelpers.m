//
//  CHBDeviceHelpers.m
//  chasingbird
//
//  Created by Haohua Li on 2015-12-31.
//  Copyright © 2015 howalee. All rights reserved.
//

#import "CHBDeviceHelpers.h"
#import "sensorTagMovementService.h"

@implementation CHBDeviceHelpers {
    sensorTagMovementService *service;
}

+ (instancetype)sharedInstance
{
    static CHBDeviceHelpers *sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[CHBDeviceHelpers alloc] init];
    });
    return sharedInstance;
}

#pragma mark - LEODataDelegate

- (void)LEO:(LEOBluetooth *)LEO didSendRepetition:(LEORepetition *)repetition {
    [self.delegate deviceType:self.deviceType didReceiveValue:repetition.cadence];
    NSLog(@"Did receive cadence: %tu", repetition.cadence);
    NSLog(@"Difference from previous cadence: %tu", repetition.cadence - repetition.previousRepetition.cadence);
}

- (void)LEO:(LEOBluetooth *)LEO didUpdateActivity:(LEOActivity)activity {
    //NSLog(@"didUpdateActivity");
}

#pragma mark - bluetoothHandlerDelegate

- (void)deviceReady:(BOOL)ready peripheral:(CBPeripheral *)peripheral {
    if (ready) {
        for (CBService *s in peripheral.services) {
            if ([sensorTagMovementService isCorrectService:s]) {
                service = [[sensorTagMovementService alloc] initWithService:s];
                [service configureService];
                
//                displayTile *t = [service getViewForPresentation];
//                [t setFrame:self.view.frame];
//                t.title.text = t.title.text;
//                [self.displayTiles addObject:t];
//                [self.view addSubview:t];
            }
        }
    } else {
        NSLog(@"Disconnected");
    }
}

- (void)didReadCharacteristic:(CBCharacteristic *)characteristic {
    
}

- (void)didGetNotificaitonOnCharacteristic:(CBCharacteristic *)characteristic {
    
}

- (void)didWriteCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error {
    
}

@end
