//
//  MoreAlert.h
//  WaiHui
//
//  Created by liuxiang on 2018/12/14.
//  Copyright © 2018年 faxian. All rights reserved.
//

#import "LxCustomAlert.h"

NS_ASSUME_NONNULL_BEGIN

@interface MoreAlert : LxCustomAlert

@property (nonatomic,copy) void(^clickBlock)(int index) ;

@property (weak, nonatomic) IBOutlet UIButton *btn3;

- (instancetype)initMoreAlert;



@end

NS_ASSUME_NONNULL_END
