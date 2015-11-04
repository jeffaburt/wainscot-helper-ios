//
//  UIApplication+SCResignFirstResponder.h
//  Wainscot
//
//  Created by Jeffrey Burt on 11/3/15.
//  Copyright © 2015 Jeffrey Burt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIApplication (SCResignFirstResponder)

/**
 Resigns whatever the first responder is application wide, no matter which
 window or view is the first responder.
 */
+ (void)WC_resignFirstResponder;

@end
