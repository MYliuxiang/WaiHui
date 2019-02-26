//
//  OpenSimulationCell.m
//  WaiHui
//
//  Created by liuxiang on 2018/12/14.
//  Copyright © 2018年 faxian. All rights reserved.
//

#import "OpenSimulationCell.h"

@implementation OpenSimulationCell

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
- (IBAction)addACount:(id)sender {
    
//     || [LxUserDefaults objectForKey:Phone]
    if ([LxUserDefaults objectForKey:Email] == nil) {
        MyTipAlert *alert = [[MyTipAlert alloc] initWithTipAlertWithTitle:@"个人信息提示" contentStr:@"您还未绑定有限，请先去绑定邮箱！" btnStr:@"确定"];
        alert.clickBlock = ^(int index) {
            if (index == 0) {
                SafeMangerVC *vc = [[SafeMangerVC alloc] init];
                [self.ViewController.navigationController pushViewController:vc animated:YES];
            }
        };
        [alert show];
        return;
    }
    
    AddMt4VC *vc = [AddMt4VC new];
    vc.type = FictitiousAccount;
    [self.ViewController.navigationController pushViewController:vc animated:YES];
    
}

@end
