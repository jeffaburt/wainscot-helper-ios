//
//  WCMath.h
//  Wainscot
//
//  Created by Jeffrey Burt on 11/2/15.
//  Copyright © 2015 Jeffrey Burt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>


@interface WCMath : NSObject

+ (CGFloat)spacingWithTotalLength:(CGFloat)totalLength
                      leftPadding:(CGFloat)leftPadding
                     rightPadding:(CGFloat)rightPadding
                    numberOfPosts:(NSInteger)numberOfPosts;

@end
