//
//  WCFraction.m
//  Wainscot
//
//  Created by Jeffrey Burt on 11/3/15.
//  Copyright © 2015 Jeffrey Burt. All rights reserved.
//

#import "WCFraction.h"

static double const kWCFractionAcceptableError = 0.001f;
static double const kWCFractionRoundedToDenominator = 16.0f;

@implementation WCFraction

+ (NSString *)fractionStringFromFloatValue:(CGFloat)floatValue {
    return [self fractionStringFromFloatValue:floatValue shouldRound:YES];
}

#pragma mark - Internal

+ (NSString *)fractionStringFromFloatValue:(CGFloat)floatValue
                               shouldRound:(BOOL)shouldRound {
    CGFloat roundedFloatValue =
    shouldRound ?
    round(floatValue * kWCFractionRoundedToDenominator) /
    kWCFractionRoundedToDenominator : floatValue;
    
    NSDecimalNumber *decimalNumber =
    [NSDecimalNumber decimalNumberWithString:@(roundedFloatValue).stringValue];
    
    WCFraction *fraction = [self fractionWithDecimalNumber:decimalNumber
                                           acceptableError:kWCFractionAcceptableError];
    
    return [fraction stringValueWithStyle:SQSFractionStringStyleMixedNumber];
}

@end
