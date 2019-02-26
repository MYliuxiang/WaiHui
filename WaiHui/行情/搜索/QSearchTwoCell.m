//
//  QSearchTwoCell.m
//  WaiHui
//
//  Created by liuxiang on 2018/12/10.
//  Copyright © 2018年 faxian. All rights reserved.
//

#import "QSearchTwoCell.h"

@implementation QSearchTwoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(HotModel *)model
{
    _model = model;
    self.lab1.text = model.searchContent;
    self.lab2.text = model.searchSymbol;
    
}

@end
