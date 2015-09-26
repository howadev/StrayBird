//
//  CHBBirdInfoNode.m
//  chasingbird
//
//  Created by Rock Lee on 2015-09-26.
//  Copyright © 2015 howalee. All rights reserved.
//

#import "CHBBirdInfoNode.h"
#import "CHBLabelNode.h"

@interface CHBBirdInfoNode ()
@property (nonatomic, retain) CHBLabelNode *speedPlaceholder;
@property (nonatomic, retain) CHBLabelNode *caloriesPlaceholder;
@property (nonatomic, retain) CHBLabelNode *distanceFromFlockPlaceholder;
@property (nonatomic, retain) CHBLabelNode *distanceLeftPlaceholder;
@end

@implementation CHBBirdInfoNode {
    CGFloat preferredWidth;
}

- (instancetype)initWithPreferredWidth:(CGFloat)width {
    self = [super init];
    if (self) {
        preferredWidth = width;
        
        self.speedPlaceholder = [CHBLabelNode new];
        self.caloriesPlaceholder = [CHBLabelNode new];
        self.distanceFromFlockPlaceholder = [CHBLabelNode new];
        self.distanceLeftPlaceholder = [CHBLabelNode new];
        
        self.speedLabel = [CHBLabelNode new];
        self.caloriesLabel = [CHBLabelNode new];
        self.distanceFromFlockLabel = [CHBLabelNode new];
        self.distanceLeftLabel = [CHBLabelNode new];
        
        NSArray *labels = @[self.distanceLeftLabel, self.distanceLeftPlaceholder, self.distanceFromFlockLabel, self.distanceFromFlockPlaceholder, self.caloriesLabel, self.caloriesPlaceholder, self.speedLabel, self.speedPlaceholder];
        for (CHBLabelNode *node in labels) {
            node.preferredWidth = preferredWidth;
        }
        
        self.speedPlaceholder.text = @"SPEED";
        self.caloriesPlaceholder.text = @"CALORIES";
        self.distanceFromFlockPlaceholder.text = @"DISTANCE FROM FLOCK";
        self.distanceLeftPlaceholder.text = @"DISTANCE LEFT";
        
        self.speedLabel.text = @"0 M/S";
        self.caloriesLabel.text = @"0 KCAL";
        self.distanceFromFlockLabel.text = @"0 MI";
        self.distanceLeftLabel.text = @"0 MI";
        
        for (CHBLabelNode *node in @[self.speedPlaceholder, self.caloriesPlaceholder, self.distanceFromFlockPlaceholder, self.distanceLeftPlaceholder]) {
            node.color = [SKColor orangeColor];
            [self addChild:node];
        }
        
        for (CHBLabelNode *node in @[self.speedLabel, self.caloriesLabel, self.distanceFromFlockLabel, self.distanceLeftLabel]) {
            node.color = [SKColor whiteColor];
            [self addChild:node];
        }
        
        CGFloat calculatedHeight = 0;
        
        for (int i = 0; i < labels.count; i++) {
            CHBLabelNode *node = labels[i];
            node.verticalAlignmentMode = SKLabelVerticalAlignmentModeBottom;
            
            if (i == 0) {
                node.position = CGPointMake(0, 0);
            } else {
                CHBLabelNode *previousNode = labels[i-1];
                node.position = CGPointMake(0, previousNode.frame.origin.y + previousNode.frame.size.height);
            }
            
            calculatedHeight += node.frame.size.height;
        }
        
        /*
        UIColor *color = [UIColor colorWithWhite:0.4 alpha:0.7];
        SKSpriteNode *backgroundNode = [[SKSpriteNode alloc] initWithColor:color size:CGSizeMake(preferredWidth, calculatedHeight)];
        backgroundNode.anchorPoint = CGPointMake(0.5, 0);
        backgroundNode.position = self.position;
        backgroundNode.zPosition = -1;
        [self addChild:backgroundNode];
         */
    }
    return self;
}

@end
