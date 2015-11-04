//
//  WCMainViewController.m
//  Wainscot
//
//  Created by Jeffrey Burt on 11/2/15.
//  Copyright © 2015 Jeffrey Burt. All rights reserved.
//

#import "WCMainViewController.h"
#import "WCPencilMarkCollectionViewCell.h"
#import "WCComputedMeasurement.h"
#import "WCFraction.h"
#import "NSString+WCUnits.h"
#import "UIApplication+SCResignFirstResponder.h"

static CGFloat const kWCSegmentedControlOptionValueZero = 3.5f;
static CGFloat const kWCSegmentedControlOptionValueOne = 4.125f;

@interface WCMainViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UITextFieldDelegate>

@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UITextField *wholeNumberTextField;
@property (weak, nonatomic) IBOutlet UITextField *numeratorTextField;
@property (weak, nonatomic) IBOutlet UITextField *denominatorTextField;
@property (weak, nonatomic) IBOutlet UISegmentedControl *leftPostWidthSegmentedControl;
@property (weak, nonatomic) IBOutlet UISegmentedControl *rightPostWidthSegmentedControl;
@property (weak, nonatomic) IBOutlet UILabel *innerSpacingLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberOfInnerPostsLabel;

@property (nonatomic) WCComputedMeasurement *computedMeasurement;

@end

@implementation WCMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self refreshData];
}

#pragma mark - Lazy loading

- (WCComputedMeasurement *)computedMeasurement {
    if (!_computedMeasurement) {
        _computedMeasurement =
        [WCComputedMeasurement
         computedMeasurementForTotalLength:self.totalLength
         leftPadding:[self selectedPaddingForSegmentedControl:self.leftPostWidthSegmentedControl]
         rightPadding:[self selectedPaddingForSegmentedControl:self.rightPostWidthSegmentedControl]];
    }
    
    return _computedMeasurement;
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
    return self.computedMeasurement.pencilMarks.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    WCPencilMarkCollectionViewCell *cell =
    [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([WCPencilMarkCollectionViewCell class])
                                              forIndexPath:indexPath];
    
    cell.pencilMark = self.computedMeasurement.pencilMarks[indexPath.row];
    
    return cell;
}

#pragma mark - UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField
shouldChangeCharactersInRange:(NSRange)range
replacementString:(NSString *)string {
    textField.text = [textField.text stringByReplacingCharactersInRange:range
                                                             withString:string];
    
    [self refreshData];
    
    return NO;
}

#pragma mark - IBAction

- (IBAction)segmentedControlValueDidChange:(UISegmentedControl *)segmentedControl {
    [UIApplication WC_resignFirstResponder];
    [self refreshData];
}

- (IBAction)didTapView:(UIView *)view {
    [UIApplication WC_resignFirstResponder];
}

#pragma mark - Internal

- (void)refreshData {
    // Recompute the measurement
    self.computedMeasurement = nil;
    
    self.innerSpacingLabel.text = [WCFraction fractionStringFromFloatValue:self.computedMeasurement.spacing].inchesString;
    self.numberOfInnerPostsLabel.text = @(self.computedMeasurement.numberOfPosts).stringValue;
    
    [self.collectionView reloadData];
}

/** Returns the padding value for the given 'segmentedControl'. */
- (CGFloat)selectedPaddingForSegmentedControl:(UISegmentedControl *)segmentedControl {
    return
    segmentedControl.selectedSegmentIndex == 0 ?
    kWCSegmentedControlOptionValueZero :
    kWCSegmentedControlOptionValueOne;
}

/** 
 Returns the total length, assembled from '_wholeNumberTextField', 
 '_numeratorTextField' and '_denominatorTextField'. 
 */
- (CGFloat)totalLength {
    return
    self.wholeNumberTextField.text.doubleValue +
    self.numeratorTextField.text.doubleValue /
    (self.denominatorTextField.text.doubleValue ?: 1.0f);
}

@end
