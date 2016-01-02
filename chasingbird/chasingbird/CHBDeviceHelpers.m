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
    
    NSTimer *stepTimer;
    NSUInteger steps;
    CGFloat previousAccValue;
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

- (void)setDeviceType:(CHBDeviceType)deviceType {
    _deviceType = deviceType;
    
    if (deviceType == CHBDeviceTypeAppleWatch) {
        if ([WCSession isSupported]) {
            WCSession *session = [WCSession defaultSession];
            session.delegate = self;
            [session activateSession];
        }
    }
}

- (BOOL)connectAppleWatch {
    NSAssert(self.deviceType == CHBDeviceTypeAppleWatch, @"Need it");
    self.connected = [[WCSession defaultSession] isReachable];
    return self.connected;
}

#pragma mark - WCSessionDelegate

- (void)session:(WCSession *)session didReceiveMessage:(NSDictionary<NSString *, id> *)message {
    NSString *activeEnergy = message[@"ActiveEnergy"];
    if (activeEnergy) {
        CGFloat calories = activeEnergy.floatValue;
        [self.delegate deviceType:self.deviceType didReceiveValue:calories];
    }
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
                
                stepTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateSteps) userInfo:nil repeats:YES];
                
                self.connected = YES;
                [[NSNotificationCenter defaultCenter] postNotificationName:homeNotification object:nil];
            }
        }
    } else {
        NSLog(@"Disconnected");
    }
}

- (void)didReadCharacteristic:(CBCharacteristic *)characteristic {
    [service dataUpdate:characteristic];
}

- (void)didGetNotificaitonOnCharacteristic:(CBCharacteristic *)characteristic {
    [service dataUpdate:characteristic];
    
    CGFloat currentAccValue = service.acc.z;
    if ((previousAccValue * currentAccValue) < 0) {
        steps++;
    }
    previousAccValue = currentAccValue;
}

- (void)didWriteCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error {
    [service wroteValue:characteristic error:error];
}

- (void)updateSteps {
    [self.delegate deviceType:CHBDeviceTypeSensorTag didReceiveValue:steps];
    NSLog(@"steps: %ld", steps);
    steps = 0;
}

@end
