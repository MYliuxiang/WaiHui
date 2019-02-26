//
//  OffsetAlert.m
//  WaiHui
//
//  Created by liuxiang on 2018/12/10.
//  Copyright © 2018年 faxian. All rights reserved.
//

#import "OffsetAlert.h"

@implementation OffsetAlert

- (IBAction)sliderAC:(UISlider *)sender {
    
    self.countLab.text = [NSString stringWithFormat:@"%.f",sender.value];
    
    
}

- (instancetype)initOffsetAlert
{
    self = [super init];
    if (self) {
        
        [self setupAutoHeightWithBottomView:self.startLab bottomMargin:50];
        self.type = LxCustomAlertTypeSheet;
        self.maskView.alpha = 1;
        self.offsetBotom = 20;
        self.width = kScreenWidth - 26;
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 5;
        
    }
    return self;
    
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
