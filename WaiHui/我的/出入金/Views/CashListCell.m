//
//  CashListCell.m
//  WaiHui
//
//  Created by liuxiang on 2018/12/14.
//  Copyright © 2018年 faxian. All rights reserved.
//

#import "CashListCell.h"

@implementation CashListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.label1 hyb_addCornerRadius:3 size:CGSizeMake(34, 16)];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(CashListModel *)model
{
    _model = model;
    self.label1.text = _model.type_name;
    self.label2.text = [NSString stringWithFormat:@"MT4:%@",model.mt4_id];
    self.label3.text = _model.money_cny;
    self.label5.text =  [HandleTool timeWithTimeIntervalString:_model.addtime withDateFormat:@"yyyy-MM-dd  HH:mm:ss"];
    
}

@end
