//
//  ClosPostionCell.m
//  WaiHui
//
//  Created by liuxiang on 2019/1/24.
//  Copyright © 2019年 faxian. All rights reserved.
//

#import "ClosPostionCell.h"

@implementation ClosPostionCell

- (IBAction)btnAC:(id)sender {
    
    UIButton *btn = sender;
    NSInteger index = btn.tag - 100;
    switch (index) {
        case 0:
        {
            self.btn1.layer.masksToBounds = YES;
            self.btn1.layer.cornerRadius = 8.5;
            self.btn1.backgroundColor = [MyColor colorWithHexString:@"#E3E3F6"];
            self.btn1.layer.borderColor = [MyColor colorWithHexString:@"#E3E3F6"].CGColor;
            self.btn1.layer.borderWidth = 0;
            
            self.btn2.layer.masksToBounds = YES;
            self.btn2.layer.cornerRadius = 8.5;
            self.btn2.backgroundColor = [UIColor whiteColor];
            self.btn2.layer.borderColor = [MyColor colorWithHexString:@"#E3E3F6"].CGColor;
            self.btn2.layer.borderWidth = 1;
            
            self.btn3.layer.masksToBounds = YES;
            self.btn3.layer.cornerRadius = 8.5;
            self.btn3.backgroundColor = [UIColor whiteColor];
            self.btn3.layer.borderColor = [MyColor colorWithHexString:@"#E3E3F6"].CGColor;
            self.btn3.layer.borderWidth = 1;
            NSDecimalNumber *num = SNDiv_handler(self.max, @"3", NSRoundUp, 2);
            self.countView.currentCount = num.stringValue;
            
        }
            break;
        case 1:
        {
            self.btn2.layer.masksToBounds = YES;
            self.btn2.layer.cornerRadius = 8.5;
            self.btn2.backgroundColor = [MyColor colorWithHexString:@"#E3E3F6"];
            self.btn2.layer.borderColor = [MyColor colorWithHexString:@"#E3E3F6"].CGColor;
            self.btn2.layer.borderWidth = 0;
            
            self.btn1.layer.masksToBounds = YES;
            self.btn1.layer.cornerRadius = 8.5;
            self.btn1.backgroundColor = [UIColor whiteColor];
            self.btn1.layer.borderColor = [MyColor colorWithHexString:@"#E3E3F6"].CGColor;
            self.btn1.layer.borderWidth = 1;
            
            self.btn3.layer.masksToBounds = YES;
            self.btn3.layer.cornerRadius = 8.5;
            self.btn3.backgroundColor = [UIColor whiteColor];
            self.btn3.layer.borderColor = [MyColor colorWithHexString:@"#E3E3F6"].CGColor;
            self.btn3.layer.borderWidth = 1;
            NSDecimalNumber *num = SNDiv_handler(self.max, @"2", NSRoundUp, 2);
            self.countView.currentCount = num.stringValue;
            
        }
            break;
        case 2:
        {
            self.btn3.layer.masksToBounds = YES;
            self.btn3.layer.cornerRadius = 8.5;
            self.btn3.backgroundColor = [MyColor colorWithHexString:@"#E3E3F6"];
            self.btn3.layer.borderColor = [MyColor colorWithHexString:@"#E3E3F6"].CGColor;
            self.btn3.layer.borderWidth = 0;
            
            self.btn2.layer.masksToBounds = YES;
            self.btn2.layer.cornerRadius = 8.5;
            self.btn2.backgroundColor = [UIColor whiteColor];
            self.btn2.layer.borderColor = [MyColor colorWithHexString:@"#E3E3F6"].CGColor;
            self.btn2.layer.borderWidth = 1;
            
            self.btn1.layer.masksToBounds = YES;
            self.btn1.layer.cornerRadius = 8.5;
            self.btn1.backgroundColor = [UIColor whiteColor];
            self.btn1.layer.borderColor = [MyColor colorWithHexString:@"#E3E3F6"].CGColor;
            self.btn1.layer.borderWidth = 1;
            self.countView.currentCount = self.max;
            
            
        }
            break;
      
        default:
            break;
    }
    
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    _countView = [[LxChooseCountView alloc] init];
    _countView.frame = CGRectMake(10, 10, 130, 40);
    //    _countView.lot_step = self.model.lot_step;
    //    _countView.minCount = self.model.lot_min;
    //    _countView.maxCount = self.model.lot_max;
    _countView.plusNomalImageStr = @"Add_selected";
    _countView.plusDisabledImageStr = @"Add_unselected";
    _countView.minusNomalImageStr = @"off_selected";
    _countView.minusDisabledImageStr = @"off_unselected";
    _countView.currentCount = @"0.1";
    [self.contentView addSubview:_countView];
    
    __weak typeof(self) weakSelf = self;
    
    [_countView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(130, 40));
        make.right.equalTo(weakSelf).offset(-15);
    }];
    
    
    self.btn3.layer.masksToBounds = YES;
    self.btn3.layer.cornerRadius = 8.5;
    self.btn3.backgroundColor = [MyColor colorWithHexString:@"#E3E3F6"];
    self.btn3.layer.borderColor = [MyColor colorWithHexString:@"#E3E3F6"].CGColor;
    self.btn3.layer.borderWidth = 0;
    
    self.btn2.layer.masksToBounds = YES;
    self.btn2.layer.cornerRadius = 8.5;
    self.btn2.backgroundColor = [UIColor whiteColor];
    self.btn2.layer.borderColor = [MyColor colorWithHexString:@"#E3E3F6"].CGColor;
    self.btn2.layer.borderWidth = 1;
    
    self.btn1.layer.masksToBounds = YES;
    self.btn1.layer.cornerRadius = 8.5;
    self.btn1.backgroundColor = [UIColor whiteColor];
    self.btn1.layer.borderColor = [MyColor colorWithHexString:@"#E3E3F6"].CGColor;
    self.btn1.layer.borderWidth = 1;
   
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

- (void)setStep:(NSString *)step
{
    _step = step;
    self.countView.lot_step = step;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
