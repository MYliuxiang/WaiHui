//
//  MoreAlert.m
//  WaiHui
//
//  Created by liuxiang on 2018/12/14.
//  Copyright © 2018年 faxian. All rights reserved.
//

#import "MoreAlert.h"

@implementation MoreAlert

- (instancetype)initMoreAlert
{
    
    self = [super init];
    if (self) {
        
        [self setupAutoHeightWithBottomView:self.btn3 bottomMargin:0];
        self.type = LxCustomAlertTypeSheet;
        self.maskView.alpha = 1;
        self.offsetBotom = 20;
        self.width = kScreenWidth - 26;
        
    }
    return self;
    
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self lm_addCorner:6];
    
}


- (IBAction)acone:(id)sender {
    if (self.clickBlock) {
        self.clickBlock(0);
    }
}
- (IBAction)actwo:(id)sender {
    if (self.clickBlock) {
        self.clickBlock(1);
    }
}
- (IBAction)acThree:(id)sender {
    if (self.clickBlock) {
        self.clickBlock(2);
    }
}

@end
