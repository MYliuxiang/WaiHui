//
//  QuickTransactionAlert.m
//  WaiHui
//
//  Created by liuxiang on 2018/12/7.
//  Copyright © 2018年 faxian. All rights reserved.
//

#import "QuickTransactionAlert.h"

@implementation QuickTransactionAlert

- (IBAction)doneAC:(id)sender {
    if (self.clickBlok) {
        self.clickBlok(1);
    }
    [self disMiss];

}

- (IBAction)cancleAC:(id)sender {
    if (self.clickBlok) {
        self.clickBlok(0);
    }
    [self disMiss];
}

- (instancetype)initQuickTransactionAlertWith:(NSString *)opertaionstr
                                   productStr:(NSString *)productStr
                                     countStr:(NSString *)countStr
{
   
    self = [super init];
    if (self) {
        
        self.productLab.text = productStr;
        self.opertaionLab.text = opertaionstr;
        self.countLab.text = countStr;
        self.type = LxCustomAlertTypeSheet;
        self.maskView.alpha = 1;
        [self setupAutoHeightWithBottomView:self.canBtn bottomMargin:30];
    }
    return self;
}

- (void)layoutSubviews
{
    
    [super layoutSubviews];
    [self hyb_addCornerRadius:5];
    [self.canBtn hyb_addCornerRadius:5];
    [self.doneBtn hyb_addCornerRadius:5];
    
}

@end
