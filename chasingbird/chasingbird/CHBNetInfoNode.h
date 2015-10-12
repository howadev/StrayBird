//
//  CHBNetInfoNode.h
//  chasingbird
//
//  Created by Rock Lee on 2015-10-12.
//  Copyright © 2015 howalee. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
@class CHBLabelNode;

@interface CHBNetInfoNode : SKNode
- (instancetype)initWithPreferredWidth:(CGFloat)width;
@property (nonatomic, retain) CHBLabelNode *speedLabel;
@end
