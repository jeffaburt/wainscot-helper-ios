//
//  WCPencilMarkCollectionViewCell.m
//  Wainscot
//
//  Created by Jeffrey Burt on 11/3/15.
//  Copyright © 2015 Jeffrey Burt. All rights reserved.
//

#import "WCPencilMarkCollectionViewCell.h"
#import "WCFraction.h"
#import "NSString+WCUnits.h"

@interface WCPencilMarkCollectionViewCell ()

@property (nonatomic, weak) IBOutlet UILabel *textLabel;

@end

@implementation WCPencilMarkCollectionViewCell

- (void)setPencilMark:(NSNumber *)pencilMark {
    self.textLabel.text =
    [WCFraction fractionStringFromFloatValue:pencilMark.floatValue].inchesString;
    
    _pencilMark = pencilMark;
}

@end
