//
//  AKNibCollectionViewCell.m
//  AKControls
//
//  Created by Andy Kim on 22/7/18.
//  Copyright © 2018 Hoodles. All rights reserved.
//

#import "AKNibCollectionViewCell.h"
#import <AKControls/AKControls-Swift.h>

@implementation AKNibCollectionViewCell

// Init in Objective C so it can return a replacement for self.
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        NibCollectionViewCell *nibView = (NibCollectionViewCell *)[(NibCollectionViewCell *)self replacedByNibView];
        if (nibView != self) {
            nibView.frame = super.frame;
            self = nibView;
        }
    }
    return self;
}

@end
