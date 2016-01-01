//
//  LEOSession.h
//  LEO
//
//  Created by Justin Ngo on 2015-01-22.
//  Copyright (c) 2015 GestureLogic Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LEOSession.h"
#import "LEODataDelegate.h"

@class LEOBluetooth;

/*!
 *  @discussion A LEOSession subclass, which records real-time data from a LEOBluetooth, and forwards the data to a LEODataDelegate
 */
@interface LEOStreamingSession : LEOSession

///------------------
/// @name Data Source
///------------------

/*!
 *  @brief      Returns the LEOBluetooth from which data is streaming (read-only)
 *
 *  @discussion To prevent a circular reference, this property is a weak reference to the LEOBluetooth.
 */
@property (weak, readonly) LEOBluetooth *LEO;

///--------------------
/// @name Data Consumer
///--------------------

/*!
 *  @brief      The delegate object which will receive data related events (read-only)
 *
 *  @discussion For information about how to implement your data delegate, please see the LEODataDelegate protocol reference
 */
@property (nonatomic, weak) id<LEODataDelegate> delegate;

///------------
/// @name State
///------------

/*!
 *  @brief      Returns whether or not this session is currently active (read-only)
 *
 *  @discussion An active LEOStreamingSession is still receiving data for a LEOBluetooth, and forwarding this data to its delegate.  
 *              Once a session has been terminated (by a call to the `stopStreamingData` method of a LEOBluetooth), this object will
 *              stop forwarding new data to its delegate, however it will still encapsulate all the data for the session.
 */
@property (readonly) BOOL isActive;

@end
