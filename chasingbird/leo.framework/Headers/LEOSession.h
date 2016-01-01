//
//  LEOSession.h
//  LEO
//
//  Created by Justin Ngo on 2015-01-23.
//  Copyright (c) 2015 GestureLogic Inc. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "LEOSettings.h"

@class LEOStreamingSession;

/*!
 *  @discussion A LEOSession instance encapsulates all the real-time data of a data session.  This class is as an abstract base
 *              class for more specific session instances.
 */
@interface LEOSession : NSObject

///-------------------------------
/// @name Identifying a LEOSession
///-------------------------------

/*!
 *  @brief      Returns the numeric ID of the user who generated this session
 *
 *  @discussion A single LEOUser may have several corresponding `LEOSession`s, however the combination of a LEOUser plus
 *              the sessionID property uniquely identifies a single session of data.
 */
@property (readonly)NSUInteger userID;

/*!
 *  @brief      Returns the unique session ID for this session
 *
 *  @discussion The session ID will increment for each subsequent session a user performs.  The combination of a LEOUser plus
 *              a session ID uniquely identifies a single session of data.  
 *
 *  @warning    Session IDs only have context within a specific LEOUser.  If two LEOSessions share a session ID, however each
 *              session corresponds to a separate LEOUser, the two sessions are completely independent.
 */
@property (readonly)NSString *sessionID;

/*!
 *  @brief      Returns the LEOSettings which specifies what is contained in this session
 *
 *  @discussion A LEOSettings object specifies what is contained within a LEOSession, as well as how it was recorded.  See the
 *              LEOSettings documentation for a more detailed description of the customization it provides.
 */
@property (readonly)LEOSettings *settings;

///----------------------
/// @name Data Properties
///----------------------

/*!
 *  @brief      Returns a time-series array of all LEORepetitions for the session
 *
 *  @discussion While a LEORepetition contains a reference to the preceding repetition, which provides a mean to recursively
 *              search through a session's data, this property provides a view into the entire dataset as a whole, and is 
 *              more suited to large-scale analysis.
 */
@property (readonly)NSArray *repetitions;

///-------------------------
/// @name Operations on Data
///-------------------------

/*!
 *  @brief          Calculates and returns the average value of a list of numbers
 *
 *  @param  array   A list of numbers (represented by `NSNumber` objects)
 *
 *  @return         The average value of the provided list of `NSNumber`s
 *
 *  @discussion     This static method provides a convenient means of determining the average value of one of the above data properties
 */
+ (float)averageOfArray:(NSArray *)array __deprecated;


@property NSDate *date;

-(id)initWithStreamingSession:(LEOStreamingSession *)streamingSession;

@end
