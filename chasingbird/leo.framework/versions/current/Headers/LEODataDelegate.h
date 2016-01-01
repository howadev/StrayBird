//
//  LEOProtocols.h
//  LEO
//
//  Created by Justin Ngo on 2015-01-23.
//  Copyright (c) 2015 GestureLogic Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LEOConstants.h"
#import "LEORepetition.h"

@class LEOBluetooth;

/*!
 *  @discussion The LEODataDelegate protocol defines the methods that a delegate of a LEOStreamingSession can adopt.  This data
 *              is forwarded from a LEOBluetooth object, and is unique from the state-related events handled by a LEOBluetoothDelegate
 */
@protocol LEODataDelegate <NSObject>

///---------------
/// @name LEO Data
///---------------
/*!
 *  @brief              Invoked when a LEO peripheral provides data
 *
 *  @param LEO          The LEOBluetooth providing this data
 *  @param repetition   A LEORepetition instance, containing various LEO metrics for the repetition
 *
 *  @discussion         Instantaneous data from a LEO peripheral is highly related, and the LEORepetition provided by this method
 *                      encapsulates this instant in time.
 */
- (void)LEO:(LEOBluetooth *)LEO didSendRepetition:(LEORepetition *)repetition;

@optional

///---------------
/// @name Activity
///---------------
/*!
 *  @brief          Invoked when a user changes the activity they are performing
 *
 *  @param LEO      The LEOBluetooth providing this data
 *  @param activity The new activity the user is performing
 *
 *  @discussion     This method can be invoked in two ways:
 *                      1. If automatic activity recognition is enabled, when LEO detects the user has changed activity
 *                      2. Otherwise, when the `updateActivity:` method of a LEOBluetooth is called
 *
 *  @see            LEOActivity
 */
- (void)LEO:(LEOBluetooth *)LEO didUpdateActivity:(LEOActivity)activity;

@end