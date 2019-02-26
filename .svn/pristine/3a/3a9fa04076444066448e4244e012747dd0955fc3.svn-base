//
//  LxEmptyView.m
//  WaiHui
//
//  Created by liuxiang on 2018/12/13.
//  Copyright © 2018年 faxian. All rights reserved.
//

#import "LxEmptyView.h"

@implementation LxEmptyView

+ (instancetype)noDataEmptyWith:(NSString *)titleStr
{
    return [LxEmptyView emptyActionViewWithImageStr:@"空界面icon"
                                           titleStr:titleStr
                                          detailStr:@""
                                        btnTitleStr:@""
                                      btnClickBlock:^(){
                                      }];
    
}

+ (instancetype)noNetWorkEmptyWithClickBlock:(LYActionTapBlock)btnClickBlock{
    
    return [LxEmptyView emptyActionViewWithImageStr:@"网络连接失败" titleStr:@"网络连接失败" detailStr:@"请检查您的网络设置或重新加载" btnTitleStr:@"设置" btnClickBlock:^{
        btnClickBlock();
    }];
}

+ (instancetype)systemExceptionEmptyWithClickBlock:(LYActionTapBlock)btnClickBlock
{
    return [LxEmptyView emptyActionViewWithImageStr:@"系统异常" titleStr:@"系统异常" detailStr:@"请稍后重试" btnTitleStr:@"设置" btnClickBlock:^{
        btnClickBlock();
    }];
    
}



- (void)prepare{
    [super prepare];
    
    self.titleLabTextColor = [MyColor colorWithHexString:@"#777795"];
    self.titleLabFont = [UIFont systemFontOfSize:15];
    self.detailLabFont = [UIFont systemFontOfSize:13];
    self.detailLabTextColor = [MyColor colorWithHexString:@"#CCC9DC"];
    self.actionBtnFont = [UIFont systemFontOfSize:15];
    self.actionBtnTitleColor = [UIColor whiteColor];
    self.actionBtnBorderColor = [MyColor colorWithHexString:@"#D6D6E1"];
    self.actionBtnBorderWidth = 1;
    self.actionBtnBackGroundColor = [UIColor clearColor];
    self.actionBtnHeight = 36;
    self.actionBtnCornerRadius = 18;
    self.actionBtnTitleColor = [MyColor colorWithHexString:@"#BEBBD1"];

    self.subViewMargin = 20;
    self.imageMargin = 10;
    self.titleMargin = -10;
    self.detailMargin = 10;
    self.autoShowEmptyView = NO;
    self.actionBtnHorizontalMargin = 50;

    self.contentViewY = 80;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
