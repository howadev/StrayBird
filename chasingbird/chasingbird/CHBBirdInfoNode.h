//
//  CHBBirdInfoNode.h
//  chasingbird
//
//  Created by Rock Lee on 2015-09-26.
//  Copyright © 2015 howalee. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
@class CHBLabelNode;

@interface CHBBirdInfoNode : SKNode
- (instancetype)initWithPreferredWidth:(CGFloat)width;
@property (nonatomic, retain) CHBLabelNode *speedLabel;
@property (nonatomic, retain) CHBLabelNode *caloriesLabel;
@property (nonatomic, retain) CHBLabelNode *distanceFromFlockLabel;
@property (nonatomic, retain) CHBLabelNode *distanceLeftLabel;
@end
