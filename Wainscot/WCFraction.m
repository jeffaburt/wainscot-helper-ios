//
//  WCFraction.m
//  Wainscot
//
//  Created by Jeffrey Burt on 11/3/15.
//  Copyright © 2015 Jeffrey Burt. All rights reserved.
//

#import "WCFraction.h"

static double const kWCFractionAcceptableError = 0.001f;

@implementation WCFraction

+ (NSString *)fractionStringFromFloatValue:(CGFloat)floatValue {
    NSDecimalNumber *decimalNumber =
    [NSDecimalNumber decimalNumberWithString:@(floatValue).stringValue];
    
    WCFraction *fraction = [self fractionWithDecimalNumber:decimalNumber
                                           acceptableError:kWCFractionAcceptableError];
    
    return [fraction stringValueWithStyle:SQSFractionStringStyleMixedNumber];
}

@end
