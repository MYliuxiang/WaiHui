//
//  SetVCAlert.m
//  WaiHui
//
//  Created by liuxiang on 2018/12/25.
//  Copyright © 2018年 faxian. All rights reserved.
//

#import "SetVCAlert.h"

@implementation SetVCAlert

- (instancetype)initWithSetAlertWithTitle:(NSString *)title
                               contentStr:(NSString *)contentStr
                                  btn1Str:(NSString *)btn1Str
                                  btn2Str:(NSString *)btn2Str
{
    self = [super init];
    if (self) {
        
        [self setupAutoHeightWithBottomView:self.btn1 bottomMargin:27];
        self.type = LxCustomAlertTypeAlert;
        self.maskView.alpha = 1;
        self.titleLab.text = title;
        self.width = kScreenWidth - 30;
        self.contentLab.text = contentStr;
        [self.btn1 setTitle:btn1Str forState:UIControlStateNormal];
        [self.btn2 setTitle:btn2Str forState:UIControlStateNormal];
        
    }
    return self;
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self hyb_addCornerRadius:5 size:CGSizeMake(kScreenWidth - 30, self.height_sd)];

}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self.btn1 hyb_addCornerRadius:5 size:CGSizeMake((kScreenWidth - 30 - 80)/2.0, 40)];
    [self.btn2 hyb_addCornerRadius:5 size:CGSizeMake((kScreenWidth - 30 - 80)/2.0, 40)];

}

- (IBAction)btn1AC:(id)sender {
    if (self.clickBlock) {
        self.clickBlock(0);
    }
    [self disMiss];

}
- (IBAction)btn2AC:(id)sender {
    if (self.clickBlock) {
        self.clickBlock(1);
    }
    [self disMiss];

}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
