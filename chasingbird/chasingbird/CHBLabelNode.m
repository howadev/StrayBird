//
//  CHBLabelNode.m
//  chasingbird
//
//  Created by Rock Lee on 2015-09-26.
//  Copyright © 2015 howalee. All rights reserved.
//

#import "CHBLabelNode.h"

@implementation CHBLabelNode {
    BOOL didSetPreferredWidth;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        didSetPreferredWidth = NO;
    }
    return self;
}

- (void)setPreferredWidth:(CGFloat)preferredWidth {
    _preferredWidth = preferredWidth;
    didSetPreferredWidth = YES;
}

- (void)setText:(NSString *)text {
    [super setText:text];
    
    if (didSetPreferredWidth) {
        CGFloat scale = self.preferredWidth / self.frame.size.width;
        self.fontSize *= scale;
    }
}

@end
