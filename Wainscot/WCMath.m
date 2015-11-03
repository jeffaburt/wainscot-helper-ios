//
//  WCMath.m
//  Wainscot
//
//  Created by Jeffrey Burt on 11/2/15.
//  Copyright © 2015 Jeffrey Burt. All rights reserved.
//

#import "WCMath.h"

static CGFloat const kWCPostWidth = 3.5f;

@implementation WCMath

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
