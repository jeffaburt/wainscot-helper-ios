//
//  WCFraction.h
//  Wainscot
//
//  Created by Jeffrey Burt on 11/3/15.
//  Copyright © 2015 Jeffrey Burt. All rights reserved.
//

#import "SQSFraction.h"
#import <CoreGraphics/CoreGraphics.h>

@interface WCFraction : SQSFraction

+ (NSString *)fractionStringFromFloatValue:(CGFloat)floatValue;

@end
