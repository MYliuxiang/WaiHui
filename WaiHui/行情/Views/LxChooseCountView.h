//
//  LxChooseCountView.h
//  WaiHui
//
//  Created by liuxiang on 2019/1/22.
//  Copyright © 2019年 faxian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TXLimitedTextField.h"

NS_ASSUME_NONNULL_BEGIN

@interface LxChooseCountView : UIView<UITextFieldDelegate>
@property (nonatomic, strong) UIColor *countColor;
@property (nonatomic, assign) BOOL canEdit;

@property (nonatomic, copy) NSString *minCount;
@property (nonatomic, copy) NSString *maxCount;
@property (nonatomic, copy) NSString *lot_step;
@property (nonatomic, copy) NSString *currentCount;
@property (nonatomic, assign) int digits;


@property (nonatomic, strong) TXLimitedTextField *countTextField;

@property (nonatomic, strong) UIButton *plusButton;
@property (nonatomic, strong) UIButton *minusButton;

@property (nonatomic, strong) UIFont *textFont;
@property (nonatomic, strong) UIColor *textColor;

@property (nonatomic, copy) NSString *plusDisabledImageStr;
@property (nonatomic, copy) NSString *plusNomalImageStr;
@property (nonatomic, copy) NSString *minusDisabledImageStr;
@property (nonatomic, copy) NSString *minusNomalImageStr;
@property (nonatomic, assign) BOOL canEffective;

@property (nonatomic, strong) UILabel *tipLab;


- (NSString *)getCurrentCount;

@end

NS_ASSUME_NONNULL_END
