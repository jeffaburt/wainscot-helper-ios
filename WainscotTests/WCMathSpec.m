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

describe(@"WCMath", ^{
   
    describe(@"#spacingWithLeftPadding:rightPadding:numberOfPosts:", ^{
        __block CGFloat leftPadding;
        __block CGFloat rightPadding;
        __block CGFloat numberOfPosts;
        
        context(@"there are 0 posts", ^{
            
            beforeEach(^{
                numberOfPosts = 0;
            });
            
            context(@"left padding is 0", ^{
                
                beforeEach(^{
                    leftPadding = 0;
                });
                
                context(@"right padding is 0", ^{
                    
                    beforeEach(^{
                        rightPadding = 0;
                    });
                    
                    it(@"returns 0", ^{
                        CGFloat spacing = [WCMath
                                           spacingWithLeftPadding:leftPadding
                                           rightPadding:rightPadding
                                           numberOfPosts:numberOfPosts];
                        
                        [[theValue(spacing) should] beZero];
                    });
                    
                });
                
            });
            
        });
        
    });
    
});

SPEC_END
