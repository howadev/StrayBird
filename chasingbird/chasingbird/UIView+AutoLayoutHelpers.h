//
//  UIView+AutoLayoutHelpers.h
//  chasingbird
//
//  Created by Howard on 2015-08-15.
//  Copyright © 2015 howalee. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIView (AutoLayoutHelpers)

- (NSLayoutConstraint*)pinItem:(id)item attribute:(NSLayoutAttribute)attribute to:(id)toItem;
- (NSLayoutConstraint*)pinItem:(id)item attribute:(NSLayoutAttribute)attribute to:(id)toItem priority:(UILayoutPriority)priority;
- (NSLayoutConstraint*)pinItem:(id)item attribute:(NSLayoutAttribute)attribute to:(id)toItem toAttribute:(NSLayoutAttribute)toAttribute;
- (NSLayoutConstraint*)pinItem:(id)item attribute:(NSLayoutAttribute)attribute to:(id)toItem withOffset:(CGFloat)offset andScale:(CGFloat)scale;
- (NSLayoutConstraint*)pinItem:(id)item attribute:(NSLayoutAttribute)attribute to:(id)toItem toAttribute:(NSLayoutAttribute)toAttribute withOffset:(CGFloat)offset andScale:(CGFloat)scale;

- (NSLayoutConstraint*)pinItemCenterHorizontally:(id)item to:(id)toItem;
- (NSLayoutConstraint*)pinItemCenterHorizontally:(id)item to:(id)toItem withOffset:(CGFloat)offset;
- (NSLayoutConstraint*)pinItemCenterVertically:(id)item to:(id)toItem;
- (NSLayoutConstraint*)pinItemCenterVertically:(id)item to:(id)toItem withOffset:(CGFloat)offset;
- (NSArray*)pinItemPosition:(id)item to:(id)toItem;

- (NSArray*)pinItemFillHorizontally:(id)item;
- (NSArray*)pinItemFillVertically:(id)item;
- (NSArray*)pinItemFillMarginsHorizontally:(id)item;
- (NSArray*)pinItemFillMarginsVertically:(id)item;
- (NSArray*)pinItemFillAll:(id)item;
- (NSArray*)pinItemFillMarginsAll:(id)item;
- (NSArray*)pinItemSize:(id)item to:(id)toItem;

- (NSLayoutConstraint*)setHeightConstraintForItem:(id)item height:(CGFloat)h;
- (NSLayoutConstraint*)setWidthConstraintForItem:(id)item width:(CGFloat)w;
- (NSArray*)setSizeConstraintsForItem:(id)item size:(CGSize)sz;

- (NSArray*)addVisualConstraints:(NSArray*)visualConstraints withBindings:(NSDictionary*)bindings andMetrics:(NSDictionary*)metrics;
- (NSArray*)addVisualConstraint:(NSString*)visualConstraint withBindings:(NSDictionary*)bindings;

@end