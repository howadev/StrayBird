//
//  LEOConstants.h
//  LEO
//
//  Created by Justin Ngo on 2015-01-22.
//  Copyright (c) 2015 GestureLogic Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

/*!
 *  @discussion Available LEO features.  An NSArray of these constants (wrapped in NSNumber's) must
 *              be passed to a LEOSettings on initialization
 */
typedef NS_ENUM(NSInteger, LEOFeature) {
    /// Cadence (RPM)
    LEOFeatureCadence = 1,
    /// Effort
    LEOFeatureEffort,
    /// Coordination Angle
    LEOFeatureCoordination,
    /// Quad/Ham Ratio
    LEOFeatureRatio,
    /// Quad and Ham Fatigue Scores
    LEOFeatureFatigue,
    /// Rep Counter
    LEOFeatureCount,
    /// Calories burned
    LEOFeatureCalories
};

/*!
 * @discussion Possible activities a user may be undertaking, while wearing the LEO legband
 */
typedef NS_ENUM(NSInteger, LEOActivity) {
    /// Used for internal control - don't select this activity
    LEOActivityNone,
    /// Cycling
    LEOActivityCycling,
    /// Running
    LEOActivityRunning,
    /// Walking
    LEOActivityWalking,
    /// Use Automatic Activity Recognition
    LEOActivityAutomatic
};