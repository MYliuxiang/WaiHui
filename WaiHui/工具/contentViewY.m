//
//  LxEmptyView.m
//  WaiHui
//
//  Created by liuxiang on 2018/12/13.
//  Copyright © 2018年 faxian. All rights reserved.
//

#import "LxEmptyView.h"

@implementation LxEmptyView

+ (instancetype)noDataEmpty
{
    return [LxEmptyView emptyActionViewWithImageStr:@"空界面icon"
                                           titleStr:@"未找到相关产品"
                                          detailStr:@""
                                        btnTitleStr:@""
                                      btnClickBlock:^(){
                                      }];
    
}

- (void)prepare{
    [super prepare];
    
    self.titleLabTextColor = [MyColor colorWithHexString:@"#3D478B"];
    self.titleLabFont = [UIFont systemFontOfSize:14];
    self.actionBtnFont = [UIFont systemFontOfSize:14];
    self.actionBtnTitleColor = [UIColor whiteColor];
    self.actionBtnHeight = 35;
    self.actionBtnHorizontalMargin = 50;
    self.actionBtnCornerRadius = 17.5;
    self.subViewMargin = 0;
    self.autoShowEmptyView = NO;
    self.actionBtnTitleColor = [UIColor whiteColor];
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
