//
//  LEOError.h
//  LEO
//
//  Created by Daniel Stone on 2015-02-18.
//  Copyright (c) 2015 GestureLogic Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const LEOErrorDomain;

/*!
 *  @discussion LEO.framework error codes
 */
typedef NS_ENUM(NSInteger, LEOError) {
    /// Default error code
    LEOErrorUnknown,
    /// Indicates the CBPeripheral passed to a LEOBluetooth is not a valid LEO peripheral
    LEOErrorUnrecognizedPeripheral,
    /// Indicates a LEOBluetooth has not yet been configured with a call to [LEOBluetooth setup]
    LEOErrorDeviceNotConfigured,
    /// Indicates the underlying LEO peripheral requires calibration before it may stream data
    LEOErrorDeviceNotCalibrated,
    /// Indicates a LEOBluetooth was currently streaming data when [LEOBluetooth beginStreamingDataForSettings:toDelegate:] was called
    LEOErrorDeviceAlreadyStreaming
};