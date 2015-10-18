//
//  CHBPerformance.m
//  chasingbird
//
//  Created by Rock Lee on 2015-10-18.
//  Copyright © 2015 howalee. All rights reserved.
//

#import "CHBPerformance.h"

@interface CHBPerformance ()

@end

@implementation CHBPerformance

#pragma mark - Getter

- (CGFloat)elapsedDistance {
    return self.birdSpeed * self.elapsedTime;
}

- (CGFloat)calories {
    return (0.13 * self.birdSpeed - 7.54) * 60 / 60 / 60 * self.elapsedTime;
}

- (CGFloat)averageSpeed {
    return self.elapsedDistance / self.elapsedTime;
}

@end
