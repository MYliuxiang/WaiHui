//
//  PhoneCell.m
//  WaiHui
//
//  Created by liuxiang on 2019/1/7.
//  Copyright © 2019年 faxian. All rights reserved.
//

#import "PhoneCell.h"

@implementation PhoneCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.phoneBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:5];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
