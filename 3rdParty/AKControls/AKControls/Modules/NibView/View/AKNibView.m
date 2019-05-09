//
//  AKNibView.m
//  AKControls
//
//  Created by Andy Kim on 20/7/18.
//  Copyright © 2018 Hoodles. All rights reserved.
//

#import "AKNibView.h"
#import <AKControls/AKControls-Swift.h>

@implementation AKNibView

// Init in Objective C so it can return a replacement for self.
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        if (super.subviews.count == 0) { // Prevents loading nib in nib itself.
            UIView *nibView = [super replacedByNibViewFromNibNamed:nil in:nil];
            nibView.frame = super.frame;
            self = (AKNibView *)nibView;
        }
    }
    return self;
}

@end
