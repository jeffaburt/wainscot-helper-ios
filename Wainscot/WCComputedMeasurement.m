//
//  WCComputedMeasurement.m
//  Wainscot
//
//  Created by Jeffrey Burt on 11/2/15.
//  Copyright © 2015 Jeffrey Burt. All rights reserved.
//

#import "WCComputedMeasurement.h"

static CGFloat const kWCPostWidth = 3.5f;
static CGFloat const kWCMaxSpacing = 40.0f;

@implementation WCComputedMeasurement

+ (instancetype)computedMeasurementForTotalLength:(CGFloat)totalLength
                                                 leftPadding:(CGFloat)leftPadding
                                                rightPadding:(CGFloat)rightPadding {
    NSInteger numberOfPosts = -1;
    CGFloat spacing = 0;
    
    do {
        numberOfPosts++;
        
        spacing = [self spacingWithTotalLength:totalLength
                                   leftPadding:leftPadding
                                  rightPadding:rightPadding
                                 numberOfPosts:numberOfPosts];
    }
    while (spacing > kWCMaxSpacing);
    
    // Spacing should always be positiveNo spacing == no posts
    if (spacing == 0) {
        numberOfPosts = 0;
    }
    
    WCComputedMeasurement *computedMeasurement = [self new];
    computedMeasurement.spacing = spacing;
    computedMeasurement.numberOfPosts = numberOfPosts;
    computedMeasurement.pencilMarks = [self pencilMarksWithSpacing:spacing
                                                     numberOfPosts:numberOfPosts
                                                       leftPadding:leftPadding
                                                      rightPadding:rightPadding];
    
    return computedMeasurement;
}

#pragma mark - Internal

+ (CGFloat)spacingWithTotalLength:(CGFloat)totalLength
                      leftPadding:(CGFloat)leftPadding
                     rightPadding:(CGFloat)rightPadding
                    numberOfPosts:(NSInteger)numberOfPosts {
    CGFloat spacing = 0;
    
    if (totalLength > 0) {
        spacing = (totalLength - leftPadding - rightPadding - numberOfPosts * kWCPostWidth) / (numberOfPosts + 1);
    }
    
    if (spacing < 0) {
        spacing = 0;
    }
    
    return spacing;
}

+ (NSArray *)pencilMarksWithSpacing:(CGFloat)spacing
                      numberOfPosts:(NSInteger)numberOfPosts
                        leftPadding:(CGFloat)leftPadding
                       rightPadding:(CGFloat)rightPadding {
    NSMutableArray *pencilMarks = [NSMutableArray array];
    
    if (spacing > 0) {
        // Add the starting point
        [pencilMarks addObject:@(0)];
        
        // Add a pencil mark for the left padding if specified
        if (leftPadding > 0) {
            [pencilMarks addObject:@(leftPadding)];
        }
        
        for (NSInteger i = 0; i < numberOfPosts; i++) {
            CGFloat lastValue = [pencilMarks.lastObject floatValue];
            CGFloat left = lastValue + spacing;
            CGFloat right = left + kWCPostWidth;
            
            [pencilMarks addObject:@(left)];
            [pencilMarks addObject:@(right)];
        }
        
        // Add the ending point
        [pencilMarks addObject:@([pencilMarks.lastObject floatValue] + spacing)];
        
        // Add a pencil mark for the right padding if specified
        if (rightPadding > 0) {
            [pencilMarks addObject:@([pencilMarks.lastObject floatValue] + rightPadding)];
        }
    }
    
    return pencilMarks;
}

@end
