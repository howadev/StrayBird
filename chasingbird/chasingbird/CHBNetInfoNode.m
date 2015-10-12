//
//  CHBNetInfoNode.m
//  chasingbird
//
//  Created by Rock Lee on 2015-10-12.
//  Copyright © 2015 howalee. All rights reserved.
//

#import "CHBNetInfoNode.h"
#import "CHBLabelNode.h"
#import "CHBTypes.h"

@interface CHBNetInfoNode ()
@property (nonatomic, retain) CHBLabelNode *speedPlaceholder;
@end

@implementation CHBNetInfoNode {
    CGFloat preferredWidth;
    BOOL didSetPreferredWidth;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        didSetPreferredWidth = NO;
        [self initialize];
    }
    return self;
}

- (instancetype)initWithPreferredWidth:(CGFloat)width {
    self = [super init];
    if (self) {
        didSetPreferredWidth = YES;
        preferredWidth = width;
        
        [self initialize];
    }
    return self;
}

- (void)initialize {
    SKSpriteNode *backgroundNode = [[SKSpriteNode alloc] initWithImageNamed:@"level2_layer5_net_infobox"];
    backgroundNode.anchorPoint = CGPointMake(1, 0.5);
    backgroundNode.position = self.position;
    backgroundNode.zPosition = -1;
    [self addChild:backgroundNode];
    
    self.speedPlaceholder = [CHBLabelNode new];
    self.speedLabel = [CHBLabelNode new];

    NSArray *labels = @[self.speedLabel, self.speedPlaceholder];

    for (CHBLabelNode *node in labels) {
        if (didSetPreferredWidth) {
            node.preferredWidth = preferredWidth;
        }
        node.fontSize = 15;
        node.fontName = @"cn_bold";
    }
    
    self.speedPlaceholder.text = @"SPEED";
    self.speedPlaceholder.fontColor = [SKColor orangeColor];
    [backgroundNode addChild:self.speedPlaceholder];
    
    self.speedLabel.text = @"0 M/S";
    self.speedLabel.fontColor = [SKColor whiteColor];
    [backgroundNode addChild:self.speedLabel];

    for (int i = 0; i < labels.count; i++) {
        CHBLabelNode *node = labels[i];
        node.verticalAlignmentMode = SKLabelVerticalAlignmentModeCenter;
        node.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeRight;
        
        if (i == 0) {
            node.position = CGPointMake(-kCHBEdgeInset, backgroundNode.position.y - node.frame.size.height/2);
        } else {
            node.position = CGPointMake(-kCHBEdgeInset, backgroundNode.position.y + node.frame.size.height/2);
        }
    }
    
}


@end
