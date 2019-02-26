//
//  PriceCell.m
//  WaiHui
//
//  Created by liuxiang on 2018/12/7.
//  Copyright © 2018年 faxian. All rights reserved.
//

#import "PriceCell.h"

@implementation PriceCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    _countView = [[LxChooseCountView alloc] init];
    _countView.frame = CGRectMake(10, 10, 130, 40);
   
    _countView.plusNomalImageStr = @"Add_selected";
    _countView.plusDisabledImageStr = @"Add_unselected";
    _countView.minusNomalImageStr = @"off_selected";
    _countView.minusDisabledImageStr = @"off_unselected";
    [self.contentView addSubview:_countView];
    
    __weak typeof(self) weakSelf = self;
    
    [_countView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(130, 40));
        make.right.equalTo(weakSelf).offset(-15);
    }];
    
}

- (void)setStep:(NSString *)step
{
    _step = step;
    self.countView.lot_step = step;
}

- (void)setMin:(NSString *)min
{
    _min = min;
    self.countView.minCount = min;
    
}

- (void)setMax:(NSString *)max
{
    _max = max;
    self.countView.maxCount = max;
   
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
