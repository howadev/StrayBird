//
//  CHBTracker.m
//  StrayBird
//
//  Created by Rock Lee on 2016-05-11.
//  Copyright © 2016 howalee. All rights reserved.
//

#import "CHBTracker.h"
#import <GoogleAnalytics/GAI.h>
#import <GoogleAnalytics/GAIDictionaryBuilder.h>
#import <GoogleAnalytics/GAIFields.h>

@implementation CHBTracker

BOOL isVerbose() {
    return NO;
}

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    static CHBTracker *sharedTracker;
    dispatch_once(&onceToken, ^{
        sharedTracker = [self new];
    });
    return sharedTracker;
}

+ (void)start {
    if (isVerbose()) {
        [[[GAI sharedInstance] logger] setLogLevel:kGAILogLevelVerbose];
    }
    [[GAI sharedInstance] trackerWithTrackingId:@"UA-77599866-1"];
}

#pragma mark - User ID

+ (void)setUserId:(NSString*)uid
{
    id <GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    if (tracker) {
        [tracker set:@"&uid" value:uid];
        [tracker set:@"dimension1" value:uid];
    } else {
        NSString *errorMessage = @"User ID: tracker is nil.";
        NSLog(@"%@", errorMessage);
    }
}

#pragma mark - Screens

+ (void)createEventWithCategory:(NSString*)category action:(NSString*)action label:(NSString*)label value:(NSNumber*)value
{
    id <GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    if (tracker) {
        [tracker send:[[GAIDictionaryBuilder createEventWithCategory:category           // Event category (required)
                                                              action:action             // Event action (required)
                                                               label:label              // Event label
                                                               value:value] build]];    // Event value
    } else {
        NSString *errorMessage = [NSString stringWithFormat:@"%@: tracker is nil.", label];
        NSLog(@"%@", errorMessage);
    }
}

+ (void)createEventWithCategory:(NSString*)category action:(NSString*)action
{
    [self createEventWithCategory:category action:action label:nil value:nil];
}

#pragma mark - Events

+ (void)createScreenWithName:(NSString*)name
{
    id <GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    if (tracker) {
        [tracker set:kGAIScreenName value:name];
        [tracker send:[[GAIDictionaryBuilder createScreenView] build]];
    } else {
        NSString *errorMessage = [NSString stringWithFormat:@"%@: tracker is nil.", name];
        NSLog(@"%@", errorMessage);
    }
}

#pragma mark - User Timings

+ (void)createTimingWithCategory:(NSString*)category interval:(NSTimeInterval)interval name:(NSString*)name label:(NSString*)label
{
    id <GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    if (tracker) {
        [tracker send:[[GAIDictionaryBuilder createTimingWithCategory:category interval:@((NSUInteger)(interval * 1000)) name:name label:label] build]];
    } else {
        NSString *errorMessage = [NSString stringWithFormat:@"%@: tracker is nil.", category];
        NSLog(@"%@", errorMessage);
    }
}

+ (void)createTimingWithCategory:(NSString*)category interval:(NSTimeInterval)interval
{
    [self createTimingWithCategory:category interval:interval name:nil label:nil];
}

@end

