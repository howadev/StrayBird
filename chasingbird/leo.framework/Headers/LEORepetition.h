//
//  LEORepetition.h
//  LEO
//
//  Created by Daniel Stone on 2015-03-16.
//  Copyright (c) 2015 GestureLogic Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

/*!
 *  @discussion A LEORepetition represents an instance of time during a LEOSession, by encapsulating all the data available
 *              for a single repetition.  Repetitions are activity specific:
 *
 *                  1. Cycling - A complete crank revolution
 *                  2. Running/Walking - A complete stride
 *
 *              A LEOSession is then simply a collection of these repetitions. Such a structure is necessary, since
 *              the metrics provided by a LEO are highly related, and they provide little information in isolation.
 *
 *              A LEORepetition also provides a reference to its preceding repetition, through its previousRepetition property 
 *              - this provides a means of recursively parsing through data and extracting short-term trends.  To analyze the 
 *              metric space as a whole, the [LEOSession repetitions] property may be more suitable.
 */
@interface LEORepetition : NSObject

///---------------
/// @name Indexing
///---------------

/*!
 *  @brief      Returns the repetition index of this data point
 *
 *  @discussion Note that, this isn't necessarily equal to the previous repetition's index + 1 - in case of lost connection, 
 *              streamed data can be lost, and may not be recoverable
 */
@property (readonly) NSUInteger index;

/*!
 *  @brief      Returns the time offset of this repetition
 *
 *  @discussion This property indicates the time offset since the beginning of the LEOSession
 */
@property (readonly) NSTimeInterval offset;

///--------------
/// @name Cadence
///--------------
/*!
 *  @brief      Returns the cadence at this instance of time (read-only)
 *
 *  @discussion For cycling, cadence is reported as RPM (rotations per minute), and is measured at the crank.  For running and
 *              walking, cadence is reported as steps per minute.
 */
@property (readonly) NSUInteger cadence;

///----------------
/// @name Effort
///----------------
/*!
 *  @brief      Returns the quadriceps effort of the last contraction, relative to MVC (0-100%) (read-only)
 *
 *  @discussion Many factors affect EMG amplitudes, for example:
 *
 *                  - Body fat composition
 *                  - Body hair
 *                  - etc.
 *
 *              To compensate for this, a user's MVC (maximum voluntary contraction) is measured as a mean's of calibration.
 *              Effort of quadriceps contractions are then measured relative to this MVC, and reported as a percentage.
 */
@property (readonly) NSUInteger quadricepsEffort;

/*!
 *  @brief      Returns the hamstring effort of the last contraction, relative to MVC (0-100%) (read-only)
 *
 *  @discussion Many factors affect EMG amplitudes, for example:
 *
 *                  - Body fat composition
 *                  - Body hair
 *                  - etc.
 *
 *              To compensate for this, a user's MVC (maximum voluntary contraction) is measured as a mean's of calibration.
 *              Effort of hamstring contractions are then measured relative to this MVC, and reported as a percentage.
 */
@property (readonly) NSUInteger hamstringEffort;

/*!
 *  @brief      Returns the quadriceps effort, relative to hamstring effort, in percent (read-only)
 *
 *  @discussion The quad/ham ratio gives a measure of each muscle groups contribution to total leg output.  It is measured as the
 *              relative quadriceps contribution to total leg output (i.e. quad+ham), and reported in percentage.  The
 *              hamstring contribution can then be determined as 100% - quadRatio.
 *
 *  @warning    This ratio is measured by comparing absolute quad/ham effort, and **not** by comparing the above relative
 *              measures of quad/ham effort.
 */
@property (readonly) NSUInteger quadRatio;

///--------------
/// @name Fatigue
///--------------
/*!
 *  @brief      Returns the quadriceps fatigue score of the last contraction (read-only)
 *
 *  @discussion Fatigue is rated on a scale from 0-30, where 0 represents a completely fatigued muscle, and 30 represents 
 *              a completely energized muscle
 */
@property (readonly) NSUInteger quadricepsFatigue;

/*!
 *  @brief      Returns the hamstring fatigue score of the last contraction (read-only)
 *
 *  @discussion Fatigue is rated on a scale from 0-30, where 0 represents a completely fatigued muscle, and 30 represents
 *              a completely energized muscle
 */
@property (readonly) NSUInteger hamstringFatigue;

///-------------------
/// @name Coordination
///-------------------
/*!
 *  @brief      Returns the angular position of the thigh at the beginning of quadriceps activation (read-only)
 *
 *  @discussion Coordination provides angular position data for individual muscle contractions. An angle of 0&deg corresponds to 
 *              the highest position of the thigh throughout the pedal stroke, and 360&deg corresponds to the completion of that
 *              stroke (when the thigh again reaches its highest point)
 */
@property (readonly) NSUInteger quadricepsStartAngle;

/*!
 *  @brief      Returns the angular position of the thigh at the end of quadriceps activation (read-only)
 *
 *  @discussion Coordination provides angular position data for individual muscle contractions. An angle of 0&deg corresponds to
 *              the highest position of the thigh throughout the pedal stroke, and 360&deg corresponds to the completion of that
 *              stroke (when the thigh again reaches its highest point)
 */
@property (readonly) NSUInteger quadricepsStopAngle;

/*!
 *  @brief      Returns the angular position of the thigh at the beginning of hamstring activation (read-only)
 *
 *  @discussion Coordination provides angular position data for individual muscle contractions. An angle of 0&deg corresponds to
 *              the highest position of the thigh throughout the pedal stroke, and 360&deg corresponds to the completion of that
 *              stroke (when the thigh again reaches its highest point)
 */
@property (readonly) NSUInteger hamstringStartAngle;

/*!
 *  @brief      Returns the angular position of the thigh at the end of hamstring activation (read-only)
 *
 *  @discussion Coordination provides angular position data for individual muscle contractions. An angle of 0&deg corresponds to
 *              the highest position of the thigh throughout the pedal stroke, and 360&deg corresponds to the completion of that
 *              stroke (when the thigh again reaches its highest point)
 */
@property (readonly) NSUInteger hamstringStopAngle;

/*!
 *  @brief      Returns the angular separation of quadriceps and hamstring activation (read-only)
 *
 *  @discussion This is simply measured as the difference between hamstring and quadriceps activation, i.e.:
 *
 *                  coordination = hamstringStartAngle - quadricepsStartAngle
 *
 *              A coordination value of 0&deg would then correspond to the hamstring and quadriceps muscles activating in unison,
 *              whereas a coordination value of 180&deg would correspond to the muscles being completely out of phase.
 */
@property (readonly) NSUInteger coordination;

/*!
 *  @brief      Returns the dead-zone during a complete revolution (%) (read-only)
 *
 *  @discussion This is measured as the percentage, during a complete crank revolution, in which there is neither quadricep
 *              nor hamstring activation
 */
@property (readonly) NSUInteger contractionDeadZone;

///----------------------------------
/// @name Parsing Through Data Points
///----------------------------------
/*!
 *  @brief      Returns the previous LEORepetition instance (read-only)
 *
 *  @discussion This property allows you to recursively search back through data points, and analyze local trends in the data.  To
 *              view the entire session as a whole, the [LEOSession repetitions] property may be more appropriate.
 */
@property (readonly) LEORepetition *previousRepetition;

@end
