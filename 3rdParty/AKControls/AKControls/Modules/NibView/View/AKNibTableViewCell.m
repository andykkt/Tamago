//
//  AKNibTableViewCell.m
//  AKControls
//
//  Created by Andy Kim on 21/7/18.
//  Copyright © 2018 Hoodles. All rights reserved.
//

#import "AKNibTableViewCell.h"
#import <AKControls/AKControls-Swift.h>

@implementation AKNibTableViewCell

// Init in Objective C so it can return a replacement for self.
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        NibTableViewCell *nibView = (NibTableViewCell *)[(NibTableViewCell *)self replacedByNibView];
        if (nibView != self) {
            nibView.frame = super.frame;
            self = nibView;
        }
    }
    return self;
}

@end
