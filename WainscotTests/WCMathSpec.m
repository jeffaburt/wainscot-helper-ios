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

void (^spacingShouldBe)(CGFloat, CGFloat, CGFloat, CGFloat, CGFloat) =
^(CGFloat expectedSpacing,
  CGFloat totalLength,
  CGFloat leftPadding,
  CGFloat rightPadding,
  CGFloat numberOfPosts) {
    CGFloat spacing = [WCMath
                       spacingWithTotalLength:totalLength
                       leftPadding:leftPadding
                       rightPadding:rightPadding
                       numberOfPosts:numberOfPosts];
    
    [[theValue(spacing) should] equal:theValue(expectedSpacing)];
};

describe(@"WCMath", ^{
    
    describe(@"#spacingWithTotalLength:leftPadding:rightPadding:numberOfPosts:", ^{
        __block CGFloat totalLength;
        __block CGFloat leftPadding;
        __block CGFloat rightPadding;
        __block CGFloat numberOfPosts;
        
        // Any time total length is 0, we should always return 0.
        context(@"total length is 0", ^{
            
            beforeEach(^{
                totalLength = 0;
            });
            
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
                            spacingShouldBe(0, totalLength, leftPadding, rightPadding, numberOfPosts);
                        });
                        
                    });
                    
                    context(@"right padding is not 0", ^{
                        
                        beforeEach(^{
                            rightPadding = 67.9998f;
                        });
                        
                        it(@"returns 0", ^{
                            spacingShouldBe(0, totalLength, leftPadding, rightPadding, numberOfPosts);
                        });
                        
                    });
                    
                });
                
                context(@"left padding is not 0", ^{
                    
                    beforeEach(^{
                        leftPadding = 80983.02f;
                    });
                    
                    context(@"right padding is 0", ^{
                        
                        beforeEach(^{
                            rightPadding = 0;
                        });
                        
                        it(@"returns 0", ^{
                            spacingShouldBe(0, totalLength, leftPadding, rightPadding, numberOfPosts);
                        });
                        
                    });
                    
                    context(@"right padding is not 0", ^{
                        
                        beforeEach(^{
                            rightPadding = 2;
                        });
                        
                        it(@"returns 0", ^{
                            spacingShouldBe(0, totalLength, leftPadding, rightPadding, numberOfPosts);
                        });
                        
                    });
                    
                });
                
            });

            context(@"there is at least 1 post", ^{
                
                beforeEach(^{
                    numberOfPosts = 1;
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
                            spacingShouldBe(0, totalLength, leftPadding, rightPadding, numberOfPosts);
                        });
                        
                    });
                    
                    context(@"right padding is not 0", ^{
                        
                        beforeEach(^{
                            rightPadding = 67.9998f;
                        });
                        
                        it(@"returns 0", ^{
                            spacingShouldBe(0, totalLength, leftPadding, rightPadding, numberOfPosts);
                        });
                        
                    });
                    
                });
                
                context(@"left padding is not 0", ^{
                    
                    beforeEach(^{
                        leftPadding = 80983.02f;
                    });
                    
                    context(@"right padding is 0", ^{
                        
                        beforeEach(^{
                            rightPadding = 0;
                        });
                        
                        it(@"returns 0", ^{
                            spacingShouldBe(0, totalLength, leftPadding, rightPadding, numberOfPosts);
                        });
                        
                    });
                    
                    context(@"right padding is not 0", ^{
                        
                        beforeEach(^{
                            rightPadding = 2;
                        });
                        
                        it(@"returns 0", ^{
                            spacingShouldBe(0, totalLength, leftPadding, rightPadding, numberOfPosts);
                        });
                        
                    });
                    
                });
                
            });
            
        });
        
    });
    
});

SPEC_END
