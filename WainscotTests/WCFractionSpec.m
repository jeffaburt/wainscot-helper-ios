//
//  WCFractionSpec.m
//  Wainscot
//
//  Created by Jeffrey Burt on 11/3/15.
//  Copyright © 2015 Jeffrey Burt. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import "WCFraction.h"

SPEC_BEGIN(WCFractionSpec)

describe(@"WCFraction", ^{
    
    describe(@"#fractionWithDecimalNumber:acceptableError:", ^{
        
        it(@"returns 1/3 when .333333333", ^{
            [[[WCFraction fractionStringFromFloatValue:0.333333333f] should] equal:@"1/3"];
        });
        
        it(@"returns 1/3 when .333", ^{
            [[[WCFraction fractionStringFromFloatValue:0.333f] should] equal:@"1/3"];
        });
        
        it(@"returns 33/100 when .33", ^{
            [[[WCFraction fractionStringFromFloatValue:0.33f] should] equal:@"33/100"];
        });
        
        it(@"returns 3/10 when .3", ^{
            [[[WCFraction fractionStringFromFloatValue:0.3f] should] equal:@"3/10"];
        });
        
        it(@"returns 4 1/8 when 4.125", ^{
            [[[WCFraction fractionStringFromFloatValue:4.125f] should] equal:@"4 1/8"];
        });
        
        it(@"returns 3 1/2 when 3.5", ^{
            [[[WCFraction fractionStringFromFloatValue:3.5f] should] equal:@"3 1/2"];
        });
        
    });
    
});

SPEC_END
