//
//  SimulationCell.m
//  WaiHui
//
//  Created by liuxiang on 2018/12/14.
//  Copyright © 2018年 faxian. All rights reserved.
//

#import "SimulationCell.h"

@implementation SimulationCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)moreAC:(id)sender {
    if (self.moreBlock) {
        self.moreBlock();
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.bgView hyb_addCornerRadius:5 size:CGSizeMake(kScreenWidth - 30, 138)];
}

- (void)setModel:(Mt4Model *)model
{
    _model = model;
    self.nameLab.text = model.mt4_id;
    self.lab2.text = [NSString stringWithFormat:@"$%@",model.balance];
    self.lab3.text = model.standard_volume;
    self.lab4.text = [NSString stringWithFormat:@"$%@",model.withdrawal];
    self.lab5.text = [NSString stringWithFormat:@"$%@",model.recharge] ;
    self.lab1.text = [NSString stringWithFormat:@"%.2f",model.income];
    if (_model.is_default == 0) {
        self.statusImg.hidden = YES;
        self.qiehuanBtn.hidden = NO;
        
    }else{
        
        self.statusImg.hidden = NO;
        self.qiehuanBtn.hidden = YES;
    }
}
- (IBAction)switchAC:(id)sender {
    
    if (self.switchBlock) {
        self.switchBlock();
    }
}

@end
