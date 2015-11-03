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
    
});

SPEC_END
