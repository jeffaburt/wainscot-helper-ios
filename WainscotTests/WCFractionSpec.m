//
//  WCFractionSpec.m
//  Wainscot
//
//  Created by Jeffrey Burt on 11/3/15.
//  Copyright © 2015 Jeffrey Burt. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import "WCFraction.h"

@interface WCFraction ()

+ (NSString *)fractionStringFromFloatValue:(CGFloat)floatValue
                               shouldRound:(BOOL)shouldRound;

@end

SPEC_BEGIN(WCFractionSpec)

describe(@"WCFraction", ^{
    
    describe(@"#fractionStringFromFloatValue:shouldRound:", ^{
        __block BOOL shouldRound;
        
        context(@"not rounded", ^{
            
            beforeEach(^{
                shouldRound = NO;
            });
            
            it(@"returns 1/3 when .333333333", ^{
                [[[WCFraction fractionStringFromFloatValue:0.333333333f shouldRound:shouldRound] should]
                 equal:@"1/3"];
            });
            
            it(@"returns 1/3 when .333", ^{
                [[[WCFraction fractionStringFromFloatValue:0.333f shouldRound:shouldRound] should]
                 equal:@"1/3"];
            });
            
            it(@"returns 33/100 when .33", ^{
                [[[WCFraction fractionStringFromFloatValue:0.33f shouldRound:shouldRound] should]
                 equal:@"33/100"];
            });
            
            it(@"returns 3/10 when .3", ^{
                [[[WCFraction fractionStringFromFloatValue:0.3f shouldRound:shouldRound] should]
                 equal:@"3/10"];
            });
            
        });
        
    });
    
    describe(@"#fractionStringFromFloatValue:", ^{
        
        it(@"returns 4 1/8 when 4.125", ^{
            [[[WCFraction fractionStringFromFloatValue:4.125f] should] equal:@"4 1/8"];
        });
        
        it(@"returns 3 1/2 when 3.5", ^{
            [[[WCFraction fractionStringFromFloatValue:3.5f] should] equal:@"3 1/2"];
        });
        
        it(@"returns 0 when 0", ^{
            [[[WCFraction fractionStringFromFloatValue:0] should] equal:@"0"];
        });
        
        it(@"rounds up to the nearest 16th", ^{
            [[[WCFraction fractionStringFromFloatValue:1.0f / 32.0f] should] equal:@"1/16"];
        });
        
        it(@"does not round when already a 16th and cannot be reduced", ^{
            [[[WCFraction fractionStringFromFloatValue:3.0f / 16.0f] should] equal:@"3/16"];
        });
        
        it(@"reduces 2/16 to 1/8", ^{
            [[[WCFraction fractionStringFromFloatValue:2.0f / 16.0f] should] equal:@"1/8"];
        });
        
    });
    
});

SPEC_END
