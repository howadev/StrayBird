//
//  UIView+AutoLayoutHelpers.m
//  chasingbird
//
//  Created by Howard on 2015-08-15.
//  Copyright © 2015 howalee. All rights reserved.
//

#import "UIView+AutoLayoutHelpers.h"

@implementation UIView (AutoLayoutHelpers)

- (NSLayoutConstraint*)pinItem:(id)item
                     attribute:(NSLayoutAttribute)attribute
                            to:(id)toItem
                      priority:(UILayoutPriority)priority
{
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:item
                                                                  attribute:attribute
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:toItem
                                                                  attribute:attribute
                                                                 multiplier:1.
                                                                   constant:0.];
    constraint.priority = priority;
    [self addConstraint:constraint];
    
    return constraint;
}


- (NSLayoutConstraint*)pinItem:(id)item attribute:(NSLayoutAttribute)attribute to:(id)toItem {
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:item
                                                                  attribute:attribute
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:toItem
                                                                  attribute:attribute
                                                                 multiplier:1.
                                                                   constant:0.];
    
    [self addConstraint:constraint];
    
    return constraint;
}

- (NSLayoutConstraint*)pinItem:(id)item attribute:(NSLayoutAttribute)attribute to:(id)toItem toAttribute:(NSLayoutAttribute)toAttribute {
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:item
                                                                  attribute:attribute
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:toItem
                                                                  attribute:toAttribute
                                                                 multiplier:1.
                                                                   constant:0.];
    
    [self addConstraint:constraint];
    
    return constraint;
}

- (NSLayoutConstraint*)pinItem:(id)item attribute:(NSLayoutAttribute)attribute to:(id)toItem withOffset:(CGFloat)offset andScale:(CGFloat)scale {
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:item
                                                                  attribute:attribute
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:toItem
                                                                  attribute:attribute
                                                                 multiplier:scale
                                                                   constant:offset];
    
    [self addConstraint:constraint];
    
    return constraint;
}

- (NSLayoutConstraint*)pinItem:(id)item attribute:(NSLayoutAttribute)attribute to:(id)toItem toAttribute:(NSLayoutAttribute)toAttribute withOffset:(CGFloat)offset andScale:(CGFloat)scale {
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:item
                                                                  attribute:attribute
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:toItem
                                                                  attribute:toAttribute
                                                                 multiplier:scale
                                                                   constant:offset];
    
    [self addConstraint:constraint];
    
    return constraint;
}

- (NSLayoutConstraint*)setWidthConstraintForItem:(id)item width:(CGFloat)w
{
    NSLayoutConstraint *constraint =
    [NSLayoutConstraint constraintWithItem:item
                                 attribute:NSLayoutAttributeWidth
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:nil
                                 attribute:NSLayoutAttributeNotAnAttribute
                                multiplier:0.0
                                  constant:w];
    
    [self addConstraint:constraint];
    return constraint;
}

- (NSLayoutConstraint*)setHeightConstraintForItem:(id)item height:(CGFloat)h
{
    NSLayoutConstraint *constraint =
    [NSLayoutConstraint constraintWithItem:item
                                 attribute:NSLayoutAttributeHeight
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:nil
                                 attribute:NSLayoutAttributeNotAnAttribute
                                multiplier:0.0
                                  constant:h];
    constraint.priority = UILayoutPriorityRequired;
    [self addConstraint:constraint];
    return constraint;
    
}

- (NSArray*)setSizeConstraintsForItem:(id)item size:(CGSize)sz
{
    NSArray *constraints = @[
                             [NSLayoutConstraint constraintWithItem:item
                                                          attribute:NSLayoutAttributeWidth
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:nil
                                                          attribute:NSLayoutAttributeNotAnAttribute
                                                         multiplier:0.0
                                                           constant:sz.width],
                             [NSLayoutConstraint constraintWithItem:item
                                                          attribute:NSLayoutAttributeHeight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:nil
                                                          attribute:NSLayoutAttributeNotAnAttribute
                                                         multiplier:0.0
                                                           constant:sz.height]
                             ];
    [self addConstraints:constraints];
    return constraints;
}

- (NSLayoutConstraint*)pinItemCenterHorizontally:(id)item to:(id)toItem {
    return [self pinItem:item attribute:NSLayoutAttributeCenterX to:toItem];
}

- (NSLayoutConstraint*)pinItemCenterHorizontally:(id)item to:(id)toItem withOffset:(CGFloat)offset
{
    return [self pinItem:item attribute:NSLayoutAttributeCenterX to:toItem withOffset:offset andScale:1.0];
}

- (NSLayoutConstraint*)pinItemCenterVertically:(id)item to:(id)toItem {
    return [self pinItem:item attribute:NSLayoutAttributeCenterY to:toItem];
}
- (NSLayoutConstraint*)pinItemCenterVertically:(id)item to:(id)toItem withOffset:(CGFloat)offset
{
    return [self pinItem:item attribute:NSLayoutAttributeCenterY to:toItem withOffset:offset andScale:1.0];
}


- (NSArray*)pinItemPosition:(id)item to:(id)toItem {
    return @[
             [self pinItemCenterHorizontally:item to:toItem],
             [self pinItemCenterVertically:item to:toItem]
             ];
}

- (NSArray*)pinItemFillHorizontally:(id)item {
    return @[
             [self pinItem:item attribute:NSLayoutAttributeLeft to:self],
             [self pinItem:item attribute:NSLayoutAttributeRight to:self]
             ];
}

- (NSArray*)pinItemFillVertically:(id)item {
    return @[
             [self pinItem:item attribute:NSLayoutAttributeTop to:self],
             [self pinItem:item attribute:NSLayoutAttributeBottom to:self]
             ];
}

- (NSArray*)pinItemFillMarginsHorizontally:(id)item
{
    return @[
             [self pinItem:item attribute:NSLayoutAttributeLeft to:self toAttribute:NSLayoutAttributeLeftMargin],
             [self pinItem:item attribute:NSLayoutAttributeRight to:self toAttribute:NSLayoutAttributeRightMargin],
             ];
}

- (NSArray*)pinItemFillMarginsVertically:(id)item
{
    return @[
             [self pinItem:item attribute:NSLayoutAttributeTop to:self toAttribute:NSLayoutAttributeTopMargin],
             [self pinItem:item attribute:NSLayoutAttributeBottom to:self toAttribute:NSLayoutAttributeBottomMargin],
             ];
}

- (NSArray*)pinItemFillAll:(id)item {
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:4];
    [array addObjectsFromArray:[self pinItemFillHorizontally:item]];
    [array addObjectsFromArray:[self pinItemFillVertically:item]];
    return array;
}

- (NSArray*)pinItemFillMarginsAll:(id)item {
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:4];
    [array addObjectsFromArray:[self pinItemFillMarginsHorizontally:item]];
    [array addObjectsFromArray:[self pinItemFillMarginsVertically:item]];
    return array;
}

- (NSArray*)pinItemSize:(id)item to:(id)toItem
{
    return @[
             [self pinItem:item attribute:NSLayoutAttributeHeight to:toItem],
             [self pinItem:item attribute:NSLayoutAttributeWidth to:toItem]
             ];
}

- (NSArray*)addVisualConstraints:(NSArray*)visualConstraints withBindings:(NSDictionary*)bindings andMetrics:(NSDictionary*)metrics
{
    NSMutableArray *constraints = [NSMutableArray arrayWithCapacity:visualConstraints.count];
    for (NSString *c in visualConstraints) {
        NSArray *arr = [NSLayoutConstraint constraintsWithVisualFormat:c options:0 metrics:metrics views:bindings];
        [constraints addObjectsFromArray:arr];
    }
    [self addConstraints:constraints];
    return constraints;
}

- (NSArray*)addVisualConstraint:(NSString*)visualConstraint withBindings:(NSDictionary*)bindings
{
    return [self addVisualConstraints:@[visualConstraint] withBindings:bindings andMetrics:nil];
}

@end