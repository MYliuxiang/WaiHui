//
//  ATChooseCountView.h
//  ATChooseCountView
//
//  Created by Attu on 16/10/12.
//  Copyright © 2016年 Attu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TXLimitedTextField.h"

@interface ATChooseCountView : UIView<UITextFieldDelegate>

@property (nonatomic, strong) UIColor *countColor;
@property (nonatomic, assign) BOOL canEdit;

@property (nonatomic, assign) CGFloat minCount;
@property (nonatomic, assign) CGFloat maxCount;
@property (nonatomic, assign) CGFloat lot_step;
@property (nonatomic, assign) CGFloat currentCount;

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


- (CGFloat)getCurrentCount;


@end
