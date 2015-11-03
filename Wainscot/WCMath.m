//
//  WCMath.m
//  Wainscot
//
//  Created by Jeffrey Burt on 11/2/15.
//  Copyright © 2015 Jeffrey Burt. All rights reserved.
//

#import "WCMath.h"

static CGFloat const kWCPostWidth = 3.5f;
static CGFloat const kWCMaxSpacing = 40.0f;

@implementation WCMath

+ (WCComputedMeasurements)computedMeasurementsForTotalLength:(CGFloat)totalLength
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
    
    return (WCComputedMeasurements){spacing, numberOfPosts};
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

@end
