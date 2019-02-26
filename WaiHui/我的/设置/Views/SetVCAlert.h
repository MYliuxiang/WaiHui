//
//  SetVCAlert.h
//  WaiHui
//
//  Created by liuxiang on 2018/12/25.
//  Copyright © 2018年 faxian. All rights reserved.
//

#import "LxCustomAlert.h"

NS_ASSUME_NONNULL_BEGIN

@interface SetVCAlert : LxCustomAlert
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *contentLab;
@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIButton *btn2;
@property (nonatomic,copy) void(^clickBlock)(int index) ;


- (instancetype)initWithSetAlertWithTitle:(NSString *)title
                               contentStr:(NSString *)contentStr
                                  btn1Str:(NSString *)btn1Str
                                  btn2Str:(NSString *)btn2Str;

@end

NS_ASSUME_NONNULL_END
