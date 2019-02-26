//
//  CashToast.m
//  WaiHui
//
//  Created by liuxiang on 2019/1/17.
//  Copyright © 2019年 faxian. All rights reserved.
//

#import "CashToast.h"

@implementation CashToast


- (instancetype)initWithTitle:(NSString *)title
                      message:(NSString *)message
{
    self = [super init];
    if (self) {
        
        self  = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];
        self.messageLab.text = message;
        self.titleLab.text = title;
        [self setupAutoHeightWithBottomView:self.messageLab bottomMargin:10];
        [self setupAutoWidthWithRightView:self.messageLab rightMargin:30];

        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self hyb_addCornerRadius:5];
}

@end
