//
//  OpenAccountCell.m
//  WaiHui
//
//  Created by liuxiang on 2018/12/14.
//  Copyright © 2018年 faxian. All rights reserved.
//

#import "OpenAccountCell.h"

@implementation OpenAccountCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.bgView hyb_addCornerRadius:5 size:CGSizeMake(kScreenWidth - 30, 138)];
    [self.oppenBtn hyb_addCornerRadius:5];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)addAC:(id)sender {
    
    
    if ([LxUserDefaults integerForKey:Id_Card_Status] == 3) {
        
        MyTipAlert *alert = [[MyTipAlert alloc] initWithTipAlertWithTitle:@"身份认证提示" contentStr:@"您的身份信息尚未认证，请先完成认证！" btnStr:@"马上认证"];
        alert.clickBlock = ^(int index) {
            if (index == 0) {
                RealNameVC *vc = [RealNameVC new];
                [self.ViewController.navigationController pushViewController:vc animated:YES];
            }
        };
        [alert show];
        return;
    }
    
    AddMt4VC *vc = [AddMt4VC new];
    vc.type = RealRAccount;
    [self.ViewController.navigationController pushViewController:vc animated:YES];
}


@end
