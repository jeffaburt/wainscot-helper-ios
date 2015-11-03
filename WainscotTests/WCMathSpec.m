//
//  WCMathSpec.m
//  Wainscot
//
//  Created by Jeffrey Burt on 11/2/15.
//  Copyright © 2015 Jeffrey Burt. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import "WCMath.h"

SPEC_BEGIN(WCMathSpec)

void (^valueEquals)(CGFloat, CGFloat) = ^(CGFloat value, CGFloat expectedValue) {
    // Need to account for limited precision floating points.
    [[theValue(fabs(value - expectedValue)) should] beLessThan:theValue(0.00001f)];
};

describe(@"WCMath", ^{
    
    describe(@"#spacingWithTotalLength:leftPadding:rightPadding:numberOfPosts:", ^{
        
        it(@"returns 0 when total length is 0", ^{
            CGFloat spacing = [WCMath
                               spacingWithTotalLength:0
                               leftPadding:10.0f
                               rightPadding:18.0f
                               numberOfPosts:12];

            valueEquals(spacing, 0);
        });
        
        it(@"returns the total length when everything else is 0", ^{
            CGFloat spacing = [WCMath
                               spacingWithTotalLength:187.22f
                               leftPadding:0
                               rightPadding:0
                               numberOfPosts:0];
            
            valueEquals(spacing, 187.22f);
        });
        
        it(@"subtracts the left and right padding from the total length", ^{
            CGFloat spacing = [WCMath
                               spacingWithTotalLength:166.0f
                               leftPadding:8.0f
                               rightPadding:2.2f
                               numberOfPosts:0];
            
            valueEquals(spacing, 155.8f);
        });
        
        it(@"subtracts the post widths and divides by the number of posts + 1", ^{
            CGFloat spacing = [WCMath
                               spacingWithTotalLength:100.0f
                               leftPadding:0
                               rightPadding:0
                               numberOfPosts:2];
            
            valueEquals(spacing, 31.0f);
        });
        
        it(@"subtracts the left and right padding from the total length, subtracts the post widths and divides by the number of posts + 1", ^{
            CGFloat spacing = [WCMath
                               spacingWithTotalLength:193.0f
                               leftPadding:12.22f
                               rightPadding:8.0f
                               numberOfPosts:2];
            
            valueEquals(spacing, 55.26f);
        });
        
        it(@"never returns negative spacing", ^{
            CGFloat spacing = [WCMath
                               spacingWithTotalLength:10.0f
                               leftPadding:5.0f
                               rightPadding:5.0f
                               numberOfPosts:1];
            
            valueEquals(spacing, 0);
        });
        
    });
    
    describe(@"#computedMeasurementsForTotalLength:leftPadding:rightPadding:", ^{
        
        it(@"returns 0 spacing and 0 number of posts when total length is 0", ^{
            WCComputedMeasurements computedMeasurements =
            [WCMath computedMeasurementsForTotalLength:0
                                           leftPadding:16.0f
                                          rightPadding:4.0f];
            
            valueEquals(computedMeasurements.spacing, 0);
            [[theValue(computedMeasurements.numberOfPosts) should] beZero];
        });
        
        it(@"returns 0 spacing and 0 number of posts when adjusted length is 0", ^{
            WCComputedMeasurements computedMeasurements =
            [WCMath computedMeasurementsForTotalLength:10.0f
                                           leftPadding:5.0f
                                          rightPadding:5.0f];
            
            valueEquals(computedMeasurements.spacing, 0);
            [[theValue(computedMeasurements.numberOfPosts) should] beZero];
        });
        
        it(@"adjusts the number of posts so the spacing is no more than 40", ^{
            WCComputedMeasurements computedMeasurements =
            [WCMath computedMeasurementsForTotalLength:220.0f
                                           leftPadding:16.0f
                                          rightPadding:4.0f];
            
            valueEquals(computedMeasurements.spacing, 37.2);
            [[theValue(computedMeasurements.numberOfPosts) should] equal:theValue(4)];
        });
        
        it(@"returns 0 posts if the adjusted length is less than 41", ^{
            WCComputedMeasurements computedMeasurements =
            [WCMath computedMeasurementsForTotalLength:49.0f
                                           leftPadding:9.0f
                                          rightPadding:10.0f];
            
            valueEquals(computedMeasurements.spacing, 30.0f);
            [[theValue(computedMeasurements.numberOfPosts) should] beZero];
        });
        
        it(@"returns 1 post if the adjusted length is 41 (too long)", ^{
            WCComputedMeasurements computedMeasurements =
            [WCMath computedMeasurementsForTotalLength:50.0f
                                           leftPadding:5.0f
                                          rightPadding:4.0f];
            
            valueEquals(computedMeasurements.spacing, 18.75);
            [[theValue(computedMeasurements.numberOfPosts) should] equal:theValue(1)];
        });
        
    });
    
});

SPEC_END
