//
//  WCComputedMeasurement.h
//  Wainscot
//
//  Created by Jeffrey Burt on 11/2/15.
//  Copyright © 2015 Jeffrey Burt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

@interface WCComputedMeasurement : NSObject

/** The spacing between edges and posts. */
@property (nonatomic) CGFloat spacing;

/** The number of inner posts between edges. */
@property (nonatomic) NSInteger numberOfPosts;

/** An array of pencil marks. */
@property (nonatomic) NSArray *pencilMarks;

+ (instancetype)computedMeasurementForTotalLength:(CGFloat)totalLength
                                      leftPadding:(CGFloat)leftPadding
                                     rightPadding:(CGFloat)rightPadding;

@end
