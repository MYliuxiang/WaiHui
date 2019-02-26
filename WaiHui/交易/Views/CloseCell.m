//
//  CloseCell.m
//  WaiHui
//
//  Created by liuxiang on 2018/12/12.
//  Copyright © 2018年 faxian. All rights reserved.
//

#import "CloseCell.h"

@implementation CloseCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(CloseModel *)model
{
    _model = model;
    [self setupAutoHeightWithBottomViewsArray:@[_kcLab] bottomMargin:15];
    _sybolLab.text = model.symbol;
    _symbolNameLab.text = model.symbolName;
    NSString *vo = SNDiv(model.volume, @"100").stringValue;

    if([_model.command isEqualToString:@"sell"]){
    [_voloumLab setTitle:[NSString stringWithFormat:@"卖出%@手",vo] forState:UIControlStateNormal];
        _voloumLab.backgroundColor = [MyColor colorWithHexString:@"#3ACCB2"];
    }else{
        [_voloumLab setTitle:[NSString stringWithFormat:@"买入%@手",vo] forState:UIControlStateNormal];
        _voloumLab.backgroundColor = [MyColor colorWithHexString:@"#FF8E87"];
        
    }
    
     self.timeLab.text = _model.open_time;
    self.priceLab1.text = _model.open_price;
    self.priceLab2.text = _model.close_price;
    self.priceLab3.text = _model.profit;

    if ([_model.profit rangeOfString:@"-"].location != NSNotFound) {
        
        self.priceLab3.textColor = Color_Green;
    }else{
        self.priceLab3.textColor = Color_Red;
        
    }
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.voloumLab.layer.masksToBounds = YES;
    self.voloumLab.layer.cornerRadius = 3;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
