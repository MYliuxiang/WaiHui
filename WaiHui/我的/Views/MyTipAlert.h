//
//  MyTipAlert.h
//  WaiHui
//
//  Created by liuxiang on 2018/12/26.
//  Copyright © 2018年 faxian. All rights reserved.
//

#import "LxCustomAlert.h"

NS_ASSUME_NONNULL_BEGIN

@interface MyTipAlert : LxCustomAlert
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *contentLab;
@property (weak, nonatomic) IBOutlet UIButton *doneBtn;
@property (nonatomic,copy) void(^clickBlock)(int index) ;

- (instancetype)initWithTipAlertWithTitle:(NSString *)title
                               contentStr:(NSString *)contentStr
                                   btnStr:(NSString *)btnStr;
@end

NS_ASSUME_NONNULL_END
