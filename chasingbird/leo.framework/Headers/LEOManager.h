//
//  LEOManager.h
//  LEO
//
//  Created by Daniel Stone on 2015-04-15.
//  Copyright (c) 2015 GestureLogic Inc. All rights reserved.
//

#import "LEOBluetooth.h"
/*!
 *  @discussion                 A manager that handles the connections between the device and Bluetooth device.  This class is the entry point to the LEO API
 */
@interface LEOManager : NSObject <CBCentralManagerDelegate>

//@property LEOCloudClient *client;

/*!
 *  @brief                      Singleton reference to a LEOManager object.
 *
 *  @discussion                 An instance of LEOManager cannot be made outside of this method.
 */
+ (LEOManager *)sharedInstance;

-(id) init __attribute__((unavailable("Must use sharedInstance to create LEOManager.")));

/*!
 *  @brief                      Discovers LEOBluetooth objects.
 *
 *  @param discoveryHandler     A user defined method that is called once a LEOBluetooth has been discovered.
 */
- (void)discoverLEOs:(void (^)(LEOBluetooth *LEO))discoveryHandler;

/*!
 *  @brief                      Stops the discovery process started from discoverLEOs:
 *
 */
- (void)stopDiscoveringLEOs;

/*!
 *  @brief                      Attempts to make a connection to the LEO.
 *
 *  @param LEO                  The LEOBluetooth object to be connected.
 *
 *  @param completionHandler    A user defined method that is called once a LEOBluetooth has been connected.
 *
 *  @discussion                 The completionHandler will give nil for NSError if connected correctly. If a failure to connect occurs, LEO will be nil and NSError will have been set.
 */
-(void)connectLEO:(LEOBluetooth *)LEO
   completionHandler:(void (^)(LEOBluetooth *LEO, NSError *error))completionHandler;

/*!
 *  @brief                      Attempts to disconnect the LEO
 *
 *  @param LEO                  The LEOBluetooth object to be disconnected.
 *
 *  @param completionHandler    A user defined method that is called once a LEOBluetooth has been disconnected.
 *
 *  @discussion                 The completionHandler will give nil for NSError if connected correctly. If a failure to connect occurs, LEO will be nil and NSError will have been set.
 */
-(void)disconnectLEO:(LEOBluetooth *)LEO
      completionHandler:(void (^)(LEOBluetooth *LEO, NSError *error))completionHandler;

/*!
 *  @brief                      Create a LEOBluetooth from a CBPeripheral object obtained from CBCentralManager
 *
 *  @param peripheral           CBPeripheral discovered from CBCentralManager to create a LEOBluetooth object.
 *
 *  @discussion                 If this method is used without the use of the discovery of this class, the connection of this class will not work.
 */
-(LEOBluetooth *)makeLEOBluetooth:(CBPeripheral *)peripheral;

@end