//
//  WCComputedMeasurementSpec.m
//  Wainscot
//
//  Created by Jeffrey Burt on 11/2/15.
//  Copyright © 2015 Jeffrey Burt. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import "WCComputedMeasurement.h"

@interface WCComputedMeasurement ()

+ (CGFloat)spacingWithTotalLength:(CGFloat)totalLength
                      leftPadding:(CGFloat)leftPadding
                     rightPadding:(CGFloat)rightPadding
                    numberOfPosts:(NSInteger)numberOfPosts;

+ (NSArray *)pencilMarksWithSpacing:(CGFloat)spacing
                      numberOfPosts:(NSInteger)numberOfPosts
                        leftPadding:(CGFloat)leftPadding
                       rightPadding:(CGFloat)rightPadding;

@end

SPEC_BEGIN(WCComputedMeasurementSpec)

void (^valueEquals)(CGFloat, CGFloat) = ^(CGFloat value, CGFloat expectedValue) {
    // Need to account for limited precision floating points.
    [[theValue(fabs(value - expectedValue)) should] beLessThan:theValue(0.00001f)];
};

describe(@"WCComputedMeasurement", ^{
    
    describe(@"#spacingWithTotalLength:leftPadding:rightPadding:numberOfPosts:", ^{
        
        it(@"returns 0 when total length is 0", ^{
            CGFloat spacing = [WCComputedMeasurement
                               spacingWithTotalLength:0
                               leftPadding:10.0f
                               rightPadding:18.0f
                               numberOfPosts:12];
            
            valueEquals(spacing, 0);
        });
        
        it(@"returns the total length when everything else is 0", ^{
            CGFloat spacing = [WCComputedMeasurement
                               spacingWithTotalLength:187.22f
                               leftPadding:0
                               rightPadding:0
                               numberOfPosts:0];
            
            valueEquals(spacing, 187.22f);
        });
        
        it(@"subtracts the left and right padding from the total length", ^{
            CGFloat spacing = [WCComputedMeasurement
                               spacingWithTotalLength:166.0f
                               leftPadding:8.0f
                               rightPadding:2.2f
                               numberOfPosts:0];
            
            valueEquals(spacing, 155.8f);
        });
        
        it(@"subtracts the post widths and divides by the number of posts + 1", ^{
            CGFloat spacing = [WCComputedMeasurement
                               spacingWithTotalLength:100.0f
                               leftPadding:0
                               rightPadding:0
                               numberOfPosts:2];
            
            valueEquals(spacing, 31.0f);
        });
        
        it(@"subtracts the left and right padding from the total length, subtracts the post widths and divides by the number of posts + 1", ^{
            CGFloat spacing = [WCComputedMeasurement
                               spacingWithTotalLength:193.0f
                               leftPadding:12.22f
                               rightPadding:8.0f
                               numberOfPosts:2];
            
            valueEquals(spacing, 55.26f);
        });
        
        it(@"never returns negative spacing", ^{
            CGFloat spacing = [WCComputedMeasurement
                               spacingWithTotalLength:10.0f
                               leftPadding:5.0f
                               rightPadding:5.0f
                               numberOfPosts:1];
            
            valueEquals(spacing, 0);
        });
        
    });
    
    describe(@"#computedMeasurementForTotalLength:leftPadding:rightPadding:", ^{
        
        it(@"returns 0 spacing and 0 number of posts when total length is 0", ^{
            WCComputedMeasurement *computedMeasurement =
            [WCComputedMeasurement computedMeasurementForTotalLength:0
                                          leftPadding:16.0f
                                         rightPadding:4.0f];
            
            valueEquals(computedMeasurement.spacing, 0);
            [[theValue(computedMeasurement.numberOfPosts) should] beZero];
        });
        
        it(@"returns 0 spacing and 0 number of posts when adjusted length is 0", ^{
            WCComputedMeasurement *computedMeasurement =
            [WCComputedMeasurement computedMeasurementForTotalLength:10.0f
                                          leftPadding:5.0f
                                         rightPadding:5.0f];
            
            valueEquals(computedMeasurement.spacing, 0);
            [[theValue(computedMeasurement.numberOfPosts) should] beZero];
        });
        
        it(@"adjusts the number of posts so the spacing is no more than 40", ^{
            WCComputedMeasurement *computedMeasurement =
            [WCComputedMeasurement computedMeasurementForTotalLength:220.0f
                                          leftPadding:16.0f
                                         rightPadding:4.0f];
            
            valueEquals(computedMeasurement.spacing, 37.2);
            [[theValue(computedMeasurement.numberOfPosts) should] equal:theValue(4)];
        });
        
        it(@"returns 0 posts if the adjusted length is less than 41", ^{
            WCComputedMeasurement *computedMeasurement =
            [WCComputedMeasurement computedMeasurementForTotalLength:49.0f
                                          leftPadding:9.0f
                                         rightPadding:10.0f];
            
            valueEquals(computedMeasurement.spacing, 30.0f);
            [[theValue(computedMeasurement.numberOfPosts) should] beZero];
        });
        
        it(@"returns 1 post if the adjusted length is 41 (too long)", ^{
            WCComputedMeasurement *computedMeasurement =
            [WCComputedMeasurement computedMeasurementForTotalLength:50.0f
                                          leftPadding:5.0f
                                         rightPadding:4.0f];
            
            valueEquals(computedMeasurement.spacing, 18.75);
            [[theValue(computedMeasurement.numberOfPosts) should] equal:theValue(1)];
        });
        
        it(@"adjusts the number of posts and returns pencil marks", ^{
            WCComputedMeasurement *computedMeasurement =
            [WCComputedMeasurement computedMeasurementForTotalLength:176.625
                                          leftPadding:3.5
                                         rightPadding:4.125f];
            
            valueEquals(computedMeasurement.spacing, 39.625f);
            [[theValue(computedMeasurement.numberOfPosts) should] equal:theValue(3)];
            
            NSArray *pencilMarks = computedMeasurement.pencilMarks;
            
            [[pencilMarks[0] should] equal:@(0)];
            [[pencilMarks[1] should] equal:@(3.5f)];
            [[pencilMarks[2] should] equal:@(43.125)];
            [[pencilMarks[3] should] equal:@(46.625)];
            [[pencilMarks[4] should] equal:@(86.25)];
            [[pencilMarks[5] should] equal:@(89.75)];
            [[pencilMarks[6] should] equal:@(129.375)];
            [[pencilMarks[7] should] equal:@(132.875)];
            [[pencilMarks[8] should] equal:@(172.5)];
            [[pencilMarks[9] should] equal:@(176.625)];
        });
        
    });
    
    describe(@"#pencilMarksWithSpacing:numberOfPosts:leftPadding:rightPadding:", ^{
        
        it(@"returns an empty array when spacing is 0", ^{
            NSArray *pencilMarks = [WCComputedMeasurement pencilMarksWithSpacing:0
                                                    numberOfPosts:100
                                                      leftPadding:18.0f
                                                     rightPadding:987.0f];
            
            [[pencilMarks should] haveCountOf:0];
        });
        
        it(@"starts and ends pencil marks at the outer boundaries", ^{
            NSArray *pencilMarks = [WCComputedMeasurement pencilMarksWithSpacing:100.0f
                                                    numberOfPosts:0
                                                      leftPadding:0
                                                     rightPadding:0];
            
            [[pencilMarks.firstObject should] equal:@(0)];
            [[pencilMarks.lastObject should] equal:@(100.0f)];
        });
        
        it(@"respects left and right padding", ^{
            NSArray *pencilMarks = [WCComputedMeasurement pencilMarksWithSpacing:100.0f
                                                    numberOfPosts:0
                                                      leftPadding:3.5f
                                                     rightPadding:4.125f];
            
            [[pencilMarks[0] should] equal:@(0)];
            [[pencilMarks[1] should] equal:@(3.5f)];
            [[pencilMarks[2] should] equal:@(103.5f)];
            [[pencilMarks[3] should] equal:@(107.625f)];
        });
        
        it(@"adds two pencil marks, 3.5\" apart, for each post", ^{
            NSArray *pencilMarks = [WCComputedMeasurement pencilMarksWithSpacing:100
                                                    numberOfPosts:1
                                                      leftPadding:0
                                                     rightPadding:0];
            
            [[pencilMarks[0] should] equal:@(0)];
            [[pencilMarks[1] should] equal:@(100)];
            [[pencilMarks[2] should] equal:@(103.5)];
            [[pencilMarks[3] should] equal:@(203.5)];
        });
        
        it(@"respects left and right padding, and compensates for post widths", ^{
            NSArray *pencilMarks = [WCComputedMeasurement pencilMarksWithSpacing:31.0f
                                                    numberOfPosts:4
                                                      leftPadding:3.5
                                                     rightPadding:4.125f];
            
            [[pencilMarks[0] should] equal:@(0)];
            [[pencilMarks[1] should] equal:@(3.5f)];
            [[pencilMarks[2] should] equal:@(34.5)];
            [[pencilMarks[3] should] equal:@(38.0f)];
            [[pencilMarks[4] should] equal:@(69.0f)];
            [[pencilMarks[5] should] equal:@(72.5)];
            [[pencilMarks[6] should] equal:@(103.5)];
            [[pencilMarks[7] should] equal:@(107)];
            [[pencilMarks[8] should] equal:@(138)];
            [[pencilMarks[9] should] equal:@(141.5)];
            [[pencilMarks[10] should] equal:@(172.5)];
            [[pencilMarks[11] should] equal:@(176.625)];
        });
        
    });
    
});

SPEC_END
