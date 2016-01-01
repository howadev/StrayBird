//
//  LEOSettings.h
//  LEO
//
//  Created by Justin Ngo on 2015-01-22.
//  Copyright (c) 2015 GestureLogic Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LEOConstants.h"

/*!
 *  @discussion Encapsulates the settings for a specific LEOSession. Instances of this class must be passed 
 *              to a LEOBluetooth to start a LEOStreamingSession
 */
@interface LEOSettings : NSObject

///----------------------------------
/// @name Properties of a LEOSettings
///----------------------------------

/*!
 *  @brief      Returns the list of features (LEOFeature constants, wrapped in `NSNumber`s) associated with the LEOSettings
 *  @discussion This property specifies which features a LEOSession includes. It is represented by a list of LEOFeature
 *              constants, wrapped in `NSNumber`s
 */
@property NSArray *features;

/*!
 *  @brief      Returns whether or not the CoreLocation framework is utilized to calculate position, distance and speed
 *  @discussion This property specifies whether to use iOS's CoreLocation framework for highly accurate measures of positions, 
 *              distance and speed.  Calorie measurements are also more accurate with this property enabled.
 */
@property BOOL coreLocationEnabled;

/*!
 *  @brief      The LEOActivity the user will be performing
 *  @discussion This property instructs a LEOBluetooth what activity the user will be performing at the beginning of the session.
 *              Use LEOActivityAutomatic to not specify an activity - the LEO peripheral will use automatic activity recognition
 *              in this case to determine the user's activity
 */
@property LEOActivity activity;

///--------------------------------------
/// @name Creating a LEOSettings instance
///--------------------------------------

/*!
 *  @brief      Creates and returns a LEOSettings instance, with the default settings
 *  @discussion The default settings are defined as follows:
 *
 *              - features: LEOFeatureActivity, LEOFeatureCadence, LEOFeatureCoordination, LEOFeatureEffort, LEOFeatureFatigue,
 *              LEOFeatureRatio
 *              - coreLocationEnabled: `YES`
 *              - activity: LEOActivityCycling
 */
+(LEOSettings *) defaultSettings;
 
/*!
 *  @brief Initialize and return a LEOSettings instance
 *
 *  @param features             An NSArray of LEOFeature constants (wrapped in NSNumber's)
 *
 *  @param coreLocationEnabled  Whether or not to use the CoreLocation framework to calculate position, distance, and speed
 *
 *  @param activity             The LEOActivity the user will be performing
 *
 *  @discussion                 A LEOSettings object encapsulates all the configuration for a LEOSession.  See the above 
 *                              properties for a detailed description of the configuration they provide.
 *
 *  @see                        features
 *  @see                        coreLocationEnabled
 *  @see                        activity
 */
-(id) initWithLEOFeatures:(NSArray *)features coreLocationEnabled:(BOOL)coreLocationEnabled activity:(LEOActivity)activity;

@end
