//
//  CheDanAlert.m
//  WaiHui
//
//  Created by liuxiang on 2018/12/13.
//  Copyright © 2018年 faxian. All rights reserved.
//

#import "CheDanAlert.h"

@implementation CheDanAlert
- (IBAction)cancleAC:(id)sender {
    [self disMiss];
}
- (IBAction)doneAC:(id)sender {
    [self disMiss];
    if (self.doneClick) {
        self.doneClick();
    }
}

- (instancetype)initCheDanAlertWith:(NSString *)title
{
    self = [super init];
    if (self) {
        
        self.type = LxCustomAlertTypeAlert;
        self.maskView.alpha = 1;
        self.width = kScreenWidth - 26;
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 5;
        [self setupAutoHeightWithBottomView:self.cancleBtn bottomMargin:30];
        [self.cancleBtn hyb_addCornerRadius:5 size:CGSizeMake((kScreenWidth - 68 - 26) / 2, 40)];
        [self.doneBtn hyb_addCornerRadius:5 size:CGSizeMake((kScreenWidth - 68 - 26) / 2, 40)];


        
    }
    return self;
    
}

@end
