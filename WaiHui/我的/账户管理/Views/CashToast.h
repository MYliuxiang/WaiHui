//
//  CashToast.h
//  WaiHui
//
//  Created by liuxiang on 2019/1/17.
//  Copyright © 2019年 faxian. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CashToast : UIView
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *messageLab;

- (instancetype)initWithTitle:(NSString *)title
                      message:(NSString *)message;

@end

NS_ASSUME_NONNULL_END
