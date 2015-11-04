//
//  NSString+WCUnits.m
//  Wainscot
//
//  Created by Jeffrey Burt on 11/3/15.
//  Copyright © 2015 Jeffrey Burt. All rights reserved.
//

#import "NSString+WCUnits.h"

@implementation NSString (WCUnits)

- (NSString *)inchesString {
    return [NSString stringWithFormat:@"%@\"", self];
}

@end
