//
//  UIApplication+SCResignFirstResponder.m
//  Wainscot
//
//  Created by Jeffrey Burt on 11/3/15.
//  Copyright © 2015 Jeffrey Burt. All rights reserved.
//

#import "UIApplication+SCResignFirstResponder.h"

@implementation UIApplication (SCResignFirstResponder)

+ (void)WC_resignFirstResponder {
    // With help from: http://stackoverflow.com/a/11768282/1926015
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder)
                                               to:nil
                                             from:nil
                                         forEvent:nil];
}

@end
