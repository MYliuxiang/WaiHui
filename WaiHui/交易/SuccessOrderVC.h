//
//  SuccessOrderVC.h
//  WaiHui
//
//  Created by liuxiang on 2018/12/13.
//  Copyright © 2018年 faxian. All rights reserved.
//

#import "BaseViewController.h"


typedef NS_ENUM(NSUInteger, SuccessType) {
    SuccessTypeNomal,
    SuccessTypeLoss,
};
NS_ASSUME_NONNULL_BEGIN

@interface SuccessOrderVC : BaseViewController

@property(nonatomic,assign) SuccessType successType;
@end

NS_ASSUME_NONNULL_END
