/*!
 * @file LEOBluetooth.h
 * @framework LEO
 *
 * @discussion Created by Daniel Stone on 2014-07-07.
 * @copyright (c) 2014 GestureLogic. All rights reserved.
 */

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>

#import "LEOConstants.h"
#import "LEOSettings.h"

/*!
 *  @discussion Represents the current action state of a LEOBluetooth
 */
typedef NS_ENUM(NSInteger, LEOBluetoothState) {
    /// The LEO peripheral is not connected
    LEOBluetoothStateDisconnected,
    /// A connection is being made to the LEO peripheral
    LEOBluetoothStateConnecting,
    /// The LEO peripheral is connected, but not ready to stream data
    LEOBluetoothStateConnected,
    /// The LEO peripheral is connected and ready to stream data
    LEOBluetoothStateReadyForStream,
    /// The LEO peripheral is currently streaming data
    LEOBluetoothStateStreaming
};

/*!
 *  @discussion Differentiates between LEO being worn on the left side, versus the right side
 *
 *  @see [LEOBluetooth whichSide]
 */
typedef NS_ENUM(NSInteger, LEOSide) {
    /// LEO is being worn on the left side
    LEOLeftSide,
    /// LEO is being worn on the right side
    LEORightSide
};

@protocol LEOBluetoothDelegate, LEODataDelegate, CBPeripheralDelegate;
@class LEOSession, LEOStreamingSession, CBPeripheral, CBUUID;

/*!
 *  @discussion Represents a LEO peripheral device.
 */
@interface LEOBluetooth : NSObject<CBPeripheralDelegate>

///--------------------------------------
/// @name Creating LEOBluetooth Instances
///--------------------------------------
/*!
 *  @brief      Returns the CBUUID corresponding to the custom 'LEO' service
 *
 *  @discussion This constant can be used to scan for LEO peripherals. The CBUUID returned by this class method should
 *              be passed to a `CBCentralManager`s `scanForPeripheralsWithServices:options:` method to discover valid
 *              LEO peripherals
 */
+ (CBUUID *)LEOService;

-(id) init __attribute__((unavailable("Must use LEOManager -makeLEOBluetooth: instead.")));

///-----------------------------------------
/// @name Configuring LEOBluetooth Instances
///-----------------------------------------

/*!
 *  @brief      The side of the body upon which LEO is being worn
 *
 *  @discussion Set this propery to instruct LEO which side of the body it is being worn.  For example, if LEO
 *              is being worn on the right leg, this property should be set to LEORightSide.
 *
 *              **Note:** By default, this property is set to LEOLeftSide
 */
@property LEOSide whichSide;

///---------------------------
/// @name Bluetooth Monitoring
///---------------------------

/*!
 *  @brief      Returns the underlying CBPeripheral instance, which was passed in at instantiation (read-only)
 *
 *  @discussion Underlying CBPeripheral instance
 */
@property (readonly) CBPeripheral *LEOPeripheral;

/*!
 *  @brief      Returns the name of the LEOPeripheral (read-only)
 *
 *  @discussion Name of the underlying LEO peripheral
 */
@property (readonly) NSString *name;

/*!
 *  @brief      Asynchronously reads the Received Signal Strength Indicator of the LEOPeripheral
 *
 *  @discussion Convenience method to the `LEOPeripheral`'s readRSSI method.  Will result in the `delegate`'s
 *              `LEO:didUpdateSignalStrength:` method being called.
 */
- (void)readRSSI;

///-----------------------
/// @name State Monitoring
///-----------------------

/*!
 *  @brief      Returns the LEOBluetoothDelegate
 *
 *  @discussion The LEOBluetoothDelegate will receive LEO peripheral state-related events.  Data-related events will
 *              be forwarded to a LEOStreamingSession, available from the session property.
 */
@property (nonatomic, weak) id<LEOBluetoothDelegate> delegate;

/*!
 *  @brief      Returns the LEOBluetoothState of the LEOBluetooth (read-only)
 *
 *  @discussion The current action state of the LEOBluetooth.  For a detailed description of the possible states, see
 *              the LEOBluetoothState reference
 */
@property (readonly) LEOBluetoothState state;

/*!
 *  @brief      Returns whether or not the LEO device is calibrated (read-only)
 *
 *  @discussion If a LEOBluetooth is not calibrated, it will not be able to stream data.  The calibration procedure is not currently exposed
 *              through the API.  This is intentional - instead, user's with uncalibrated devices should be redirected to the LEO App.
 *
 *              **Note:** This section will be updated when the LEO App is available in the App Store.
 *
 *              **Developer Note:** All developer LEOs will be shipped 'pre-calibrated', for the purposes of development.  This property
 *              should always return YES - it is considered a bug if it returns NO
 */
@property (readonly) BOOL isCalibrated;

/*!
 *  @brief      Returns whether or not lead-off has been detected (read-only)
 *
 *  @discussion Indicates insufficent skin contact for the EMG leads.  This could be caused, for example, by a band which
 *              is too large, or clothing being worn beneath the LEO band.  YES indicates that lead-off has been detected,
 *              and must be rectified.  When the lead-off state changes, the `LEO:didUpdateLeadOffState:` method of the
 *              delegate will be called.
 */
@property (readonly)BOOL leadOff;

/*!
 *  @brief      Returns whether the LEOPeripheral has sent a low battery warning (read-only)
 *
 *  @discussion Indicates LEO will run out of battery power shortly.  When low battery levels are detected, the
 *              `LEODidReceiveLowBatteryWarning:` method of the delegate will be called
 */
@property (readonly)BOOL lowBattery;

/*!
 *  @brief      Returns whether the LEOPeripheral has sent a low memory warning (read-only)
 *
 *  @discussion Indicates data recording will stop shortly.  If LEO's internal memory is full, it will continue streaming
 *              data, however it will no longer be able to record data.  When low available memory levels are detected, the
 *              `LEODidReceiveLowMemoryWarning:` method of the delegate will be called
 */
@property (readonly)BOOL lowMemory;

/*!
 *  @brief      Asynchronously reads the battery level of the LEO peripheral
 *
 *  @discussion When battery level is read, the `LEO:didUpdateBatteryLife:` method of the delegate will be called
 *
 *  @warning    This method is intended to be called while there is not an active `LEOStreamingSession`.  Calling this method
 *              while data is being streamed will have no effect.
 */
- (void)readBattery;

///-------------------------
/// @name Accessing the User
///-------------------------

/*!
 *  @brief      Returns the numeric userID of the user attached to the LEO device (read-only)
 *
 *  @discussion The numeric userID of the user attached to the LEOPeripheral.  Initially will return 0, until the setup method is called
 *
 *  @see setup
 */
@property (readonly) NSUInteger userID;

///------------------------------------------------
/// @name Starting and Stopping Real-Time Streaming
///------------------------------------------------

/*!
 *  @brief      Returns the current LEOSession (read-only)
 *
 *  @discussion The first time a LEOPeripheral is connected, this property will return <i>nil</i>, as no LEOSession
 *              has been started.  After a session has been started, this property references the most recent LEOSession,
 *              regardless of whether the session is active (i.e. regardless of whether the session has been terminated with a call to
 *              stopStreamingData)
 *
 *  @warning    Once a LEOSession has completed, it is not possible to continue streaming data to the session.  Calling
 *              beginStreamingDataForSettings:toDelegate: will <i>always</i> result in the creation of a new session, and the
 *              re-assignment of this property.  To ensure previous LEOSession instances aren't deallocated, maintain
 *              separate `strong` references to these objects.
 *
 *  @see beginStreamingDataForSettings:toDelegate:
 *  @see stopStreamingData
 */
@property (readonly) LEOSession *session;

/*!
 *  @brief      Triggers the bluetooth setup procedure.
 *
 *  @discussion This method <em>must</em> be called every time the underlying LEOPeripheral has been connected.  This
 *              procedure is a 3-step process:
 *
 *              <ol type="1">
 *                  <li><code>CBService</code> discovery</li>
 *                  <li><code>CBCharacteristic</code> discovery</li>
 *                  <li><code>UserID</code> discovery</li>
 *              </ol>
 *
 *              When this process is complete, the `LEOIsReadyToStreamData` method of the delegate will be called
 */
- (void)setup;

/*!
 *  @brief              Triggers the beginning of a LEOStreamingSession, with the provided LEOSettings
 *
 *  @param settings     A LEOSettings object, which specifies the parameters of the session
 *  @param delegate     The LEODataDelegate to which data-related events will be sent
 *
 *  @discussion         The provided LEODataDelegate will be attached to the created LEOStreamingSession automatically. If
 *                      a session is successfully started, the `LEO:didBeginStreamingSession` of the delegate will be called
 *                      with the created LEOStreamingSession.  If a session cannot be started, the `LEO:didFailToBeginStreaming:`
 *                      of the delegate will be called, with an `NSError` object.
 *
 *  @warning            This method will always fail if called before a call to setup has completed
 */
- (void)beginStreamingDataForSettings:(LEOSettings *)settings toDelegate:(id<LEODataDelegate>)delegate;

/*!
 *  @brief              Instructs the underlying LEO peripheral what activity the user is performing
 *
 *  @param activity     The <code>LEOActivity</code> that the user is currently performing
 *
 *  @discussion         For algorithmic accuracy, LEO must be aware of what activity the user is performing.  The LEOSettings
 *                      object passed to beginStreamingDataForSettings:toDelegate: instructs LEO what activity the user will
 *                      be performing at the beginning of the session - use this method to instruct LEO that the activity has changed.
 *
 *  @warning            This method will have no effect if LEO is not currently streaming.
 *
 *  @see LEOActivity
 */
- (void)updateActivity:(LEOActivity)activity;

/*!
 *  @brief      Terminates the current LEOStreamingSession
 *
 *  @discussion Use this method to stop the currently active session.  When the session is complete, the `LEODidStopStreaming:` method
 *              of the delegate will be called.
 *
 *  @warning    Once a session has been stopped with this method, it is considered a complete session, and cannot be resumed
 *
 *  @seealso LEODidStopStreaming
 */
- (void)stopStreamingData;

@end



/*!
 *  @discussion This delegate will receive state-related events from a LEOBluetooth
 */
@protocol LEOBluetoothDelegate <NSObject>

@required

///----------------------
/// @name Setup Procedure
///----------------------

/*!
 *  @brief        Invoked when a LEOBluetooth discovers the numeric user ID of it's underlying user
 *
 *  @param LEO    The LEOBluetooth providing this message
 *  @param userID The numeric user ID of the underlying user
 *
 *  @discussion   This callback is part of the `setup` procedure, when the user for the LEO peripheral is discovered.
 */
- (void)LEO:(LEOBluetooth *)LEO didDiscoverUserID:(NSUInteger)userID;

/*!
 *  @brief      Invoked if a LEOBluetooth discovers its underling LEO peripheral requires calibration
 *
 *  @param LEO  The LEOBluetooth providing this message
 *
 *  @discussion The calibration procedure is not currently exposed through the API.  This is intentional - instead, user's with
 *              uncalibrated devices should be redirected to the LEO App.
 *
 *              **Note:** This section will be updated when the LEO App is available in the App Store.
 *
 *              **Developer Note:** All developer LEOs will be shipped 'pre-calibrated', for the purposes of development.  These
 *              devices will (should) not generate `LEORequiresCalibration:` warnings.
 */
- (void)LEORequiresCalibration:(LEOBluetooth *)LEO;

/*!
 *  @brief          Invoked when a LEOBluetooth is ready to stream data
 *
 *  @param LEO      The LEOBluetooth providing this message
 *  @param error    If an error occurred, the cause of the failure
 *
 *  @discussion     Every time a LEOBluetooth is connected, it's `setup` method must be called - this callback method
 *                  is invoked when the setup procedure has completed.  Unless an error object has been provided, the
 *                  LEOBluetooth may begin streaming
 */
- (void)LEODidCompleteSetupProcedure:(LEOBluetooth *)LEO error:(NSError*)error;

///--------------------------
/// @name Real-Time Streaming
///--------------------------

/*!
 *  @brief          Invoked when a LEOBluetooth starts a new LEOStreamingSession
 *
 *  @param LEO      The LEOBluetooth providing this message
 *  @param session  The LEOStreamingSession which will record and forward all streaming data
 *
 *  @discussion     The provided LEOStreamingSession will encapsulate all data for the current data session.  It will also
 *                  forward all data events to its LEODataDelegate.
 *
 *  @see LEOStreamingSession
 *  @see LEODataDelegate
 */
- (void)LEO:(LEOBluetooth *)LEO didBeginStreamingSession:(LEOStreamingSession *)session;

/*!
 *  @brief          Invoked when a LEOBluetooth fails to begin a new data session
 *
 *  @param LEO      The LEOBluetooth providing this message
 *  @param error    The cause of the failure
 *
 *  @discussion     Calls to `beginStreamingDataForSettings:toDelegate:` can fail for many reasons - for example, if the `setup`
 *                  procedure has yet to resolve, or if there is already a currently active LEOStreamingSession.  This method will
 *                  provide an error message, which details specifically why the method failed.
 */
- (void)LEO:(LEOBluetooth *)LEO didFailToBeginStreaming:(NSError *)error;

/*!
 *  @brief      Invoked when a LEO peripheral finishes a session and stops streaming data
 *
 *  @param LEO  The LEOBluetooth providing this message
 *
 *  @discussion This method acts as a callback method for the `stopStreamingData` method of a LEOBluetooth. After this method
 *              is invoked, no additional data will be added to the associated LEOStreamingSession.
 */
- (void)LEODidStopStreaming:(LEOBluetooth *)LEO;

@optional

///---------------------------------------------
/// @name Other State-Related Methods (Optional)
///---------------------------------------------

/*!
 *  @brief                  Invoked when a LEOBluetooth detects a change in the lead-off state
 *
 *  @param LEO              The LEOBluetooth providing this message
 *  @param leadOffDetected  Whether or not lead-off is currently indicated
 *
 *  @discussion             Lead-off occurs whenever there is insufficient contact between the EMG sensors and the skin.  A
 *                          boolean value is provided, since this may be resolved in real-time (for ex. by adjusting the
 *                          position of the LEO leg band)
 */
- (void)LEO:(LEOBluetooth *)LEO didUpdateLeadOffState:(BOOL)leadOffDetected;

/*!
 *  @brief      Invoked when a LEOBluetooth sends a low battery warning
 *
 *  @param LEO  The LEOBluetooth providing this message
 *
 *  @discussion Utilize this method to warn the user that their LEO will shortly run out of battery life
 */
- (void)LEODidReceiveLowBatteryWarning:(LEOBluetooth *)LEO;

/*!
 *  @brief      Invoked when a LEOBluetooth sends a low memory warning
 *
 *  @param LEO  The LEOBluetooth providing this message
 *
 *  @discussion Utilize this method to warn the user that their LEO will shortly stop recording data.  If the LEO runs out of
 *              storage space, it will continue streaming data.
 */
- (void)LEODidReceiveLowMemoryWarning:(LEOBluetooth *)LEO;

/*!
 *  @brief      Invoked when a LEOBluetooth updates its RSSI
 *
 *  @param LEO  The LEOBluetooth providing this message
 *  @param RSSI Received Signal Strength Indicator
 *
 *  @discussion Asynchronous callback method for the `readRSSI:` method
 */
- (void)LEO:(LEOBluetooth *)LEO didUpdateSignalStrength:(NSInteger)RSSI;

/*!
 *  @brief          Invoked when a LEOBluetooth updates its remaining battery life
 *
 *  @param LEO      The LEOBluetooth providing this message
 *  @param percent  The remaining battery life, in percentage
 *
 *  @discussion     This callback will be periodically called while a data session is active.  It also acts as a callback
 *                  to the `readBattery` method of a LEOBluetooth
 */
- (void)LEO:(LEOBluetooth *)LEO didUpdateBatteryLife:(NSInteger)percent;
@end

