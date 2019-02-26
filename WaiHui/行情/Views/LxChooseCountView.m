//
//  LxChooseCountView.m
//  WaiHui
//
//  Created by liuxiang on 2019/1/22.
//  Copyright © 2019年 faxian. All rights reserved.
//
#define ATLINECOLOR [UIColor colorWithRed:200.0/255.0f green:200.0/255.0f blue:200.0/255.0f alpha:1]

#import "LxChooseCountView.h"

@implementation LxChooseCountView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self configSubViews];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self configSubViews];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self configSubViews];
        
    }
    return self;
}

- (void)configSubViews {
    self.canEdit = YES;
    self.minCount = @"0";
    self.maxCount = [NSString stringWithFormat:@"%f",1000000000000000000000000000000000.00];
    self.minusButton.enabled = NO;
    self.lot_step = @"1";
    
    [self addSubview:self.plusButton];
    [self addSubview:self.minusButton];
    [self addSubview:self.countTextField];
    [self addSubview:self.tipLab];
    self.tipLab.hidden = YES;

    
    [self.minusButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.centerY.equalTo(self);
        
        
    }];
    
    [self.plusButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self);
        make.centerY.equalTo(self);
    }];
    
    [self.countTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self);
        make.top.equalTo(self);
        make.left.equalTo(self.minusButton.mas_right);
        make.right.equalTo(self.plusButton.mas_left);
        
    }];
    
    [self.tipLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_bottom).offset(- 2);
        make.right.equalTo(self);
    }];
    
    self.clipsToBounds = NO;
    
    [self.minusButton setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [self.plusButton setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    
    [self.countTextField setContentCompressionResistancePriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
    
}

- (NSString *)getCurrentCount {
    return _currentCount;
}

- (void)setCountColor:(UIColor *)countColor {
    _countColor = countColor;
    self.countTextField.textColor = countColor;
}

- (void)setCanEdit:(BOOL)canEdit {
    _canEdit = canEdit;
    self.countTextField.enabled = canEdit;
}

#pragma mark - Event

- (void)onClickPlusButton:(UIButton *)sender {
    if (self.countTextField.isFirstResponder) {
        [self.countTextField resignFirstResponder];
    }
    
    if (self.countTextField.text.length == 0) {
        self.currentCount = self.minCount;
        return;
    }
    self.minusButton.enabled = YES;
    self.currentCount = SNAdd(self.lot_step, self.currentCount).stringValue;
    
    if (SNCompare(self.currentCount, self.maxCount) == 1){
        [self.ViewController.view makeToast:@"数量超出范围！" duration:2 position:CSToastPositionCenter];
        NSString *string = [NSString stringWithFormat:@"%%.%df",self.digits];
        NSDecimalNumber *num = [NSDecimalNumber decimalNumberWithString:self.maxCount];
        _countTextField.text = [NSString stringWithFormat:string,num.doubleValue];
//        self.countTextField.text = self.maxCount;
        self.currentCount = self.countTextField.text;
        
    }else{
        NSString *string = [NSString stringWithFormat:@"%%.%df",self.digits];
        NSDecimalNumber *num = [NSDecimalNumber decimalNumberWithString:self.currentCount];
        _countTextField.text = [NSString stringWithFormat:string,num.doubleValue];
//        self.countTextField.text = self.currentCount;
        
    }
    if (SNCompare(self.currentCount, self.maxCount) == 1 || SNCompare(self.currentCount, self.maxCount) == 0) {
        self.plusButton.enabled = NO;
        
    }
    
    if (SNCompare(self.currentCount, self.maxCount) == -1 || SNCompare(self.currentCount, self.minCount) == 1){
        
        self.tipLab.hidden = YES;
        
    }else{
        
        self.tipLab.hidden = NO;
        
    }
    
    
    
}

- (void)onClickMinusButton:(UIButton *)sender {
    if (self.countTextField.isFirstResponder) {
        [self.countTextField resignFirstResponder];
    }
    
    if (self.countTextField.text.length == 0) {
        self.currentCount = self.maxCount;
        return;
    }
    
    self.plusButton.enabled = YES;
    self.currentCount = SNSub(self.currentCount,self.lot_step).stringValue;
    
    if (SNCompare(self.currentCount, self.minCount) == -1){
        
        [self.ViewController.view makeToast:@"数量超出范围！" duration:2 position:CSToastPositionCenter];
        NSString *string = [NSString stringWithFormat:@"%%.%df",self.digits];
        NSDecimalNumber *num = [NSDecimalNumber decimalNumberWithString:self.minCount];
        _countTextField.text = [NSString stringWithFormat:string,num.doubleValue];
//        self.countTextField.text = self.minCount;
        self.currentCount = self.countTextField.text;
        
        

    }else{
        
        self.countTextField.text = self.currentCount;
        NSString *string = [NSString stringWithFormat:@"%%.%df",self.digits];
        NSDecimalNumber *num = [NSDecimalNumber decimalNumberWithString:self.currentCount];
        _countTextField.text = [NSString stringWithFormat:string,num.doubleValue];
        
    }
    
    
    if (SNCompare(self.currentCount, self.minCount) == 0 || SNCompare(self.currentCount, self.minCount) == -1) {
        self.minusButton.enabled = NO;
    }
    
    if (SNCompare(self.currentCount, self.maxCount) == -1 || SNCompare(self.currentCount, self.minCount) == 1){
        
        self.tipLab.hidden = YES;
        
    }else{
        
        self.tipLab.hidden = NO;
        
    }
    
}

#pragma mark - UITextFieldDelegate

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (textField.text.length == 0){
        
        return;
    }
    
    self.tipLab.hidden = YES;
    
    
    if (SNCompare(self.countTextField.text, self.maxCount) == 1){
        [self.ViewController.view makeToast:@"数量超出范围！" duration:2 position:CSToastPositionCenter];
        textField.text = self.maxCount;
       
        self.currentCount = self.countTextField.text;
        return;
    }
    
    
    if (SNCompare(self.countTextField.text, self.minCount) == -1){
        
        [self.ViewController.view makeToast:@"数量超出范围！" duration:2 position:CSToastPositionCenter];
        textField.text = self.minCount;
       
        self.currentCount = self.countTextField.text;
        
        return;
    }
    
    self.currentCount = self.countTextField.text;
    if (SNCompare(self.countTextField.text, self.maxCount) == 1 || SNCompare(self.countTextField.text, self.maxCount) == 0) {
        self.plusButton.enabled = NO;
    }else{
        
        self.plusButton.enabled = YES;
    }
    if (SNCompare(self.countTextField.text, self.minCount) == -1 || SNCompare(self.countTextField.text, self.minCount) == 0) {
        self.minusButton.enabled = NO;
    }else{
        self.minusButton.enabled = YES;
    }
}

#pragma mark - Init Views

- (UIButton *)plusButton {
    if (!_plusButton) {
        _plusButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_plusButton setImage:[UIImage imageNamed:@"icon_add"] forState:UIControlStateNormal];
        [_plusButton setImage:[UIImage imageNamed:@"add_dark"] forState:UIControlStateDisabled];
        [_plusButton setTranslatesAutoresizingMaskIntoConstraints:NO];
        [_plusButton addTarget:self action:@selector(onClickPlusButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _plusButton;
}

- (UIButton *)minusButton {
    if (!_minusButton) {
        _minusButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_minusButton setImage:[UIImage imageNamed:@"icon_less"] forState:UIControlStateNormal];
        [_minusButton setImage:[UIImage imageNamed:@"jian_dark"] forState:UIControlStateDisabled];
        [_minusButton setTranslatesAutoresizingMaskIntoConstraints:NO];
        [_minusButton addTarget:self action:@selector(onClickMinusButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _minusButton;
    
}

- (UITextField *)countTextField {
    if (!_countTextField) {
        _countTextField = [[TXLimitedTextField alloc] init];
        [_countTextField setTextAlignment:NSTextAlignmentCenter];
        _countTextField.keyboardType = UIKeyboardTypeDecimalPad;
        _countTextField.limitedType = TXLimitedTextFieldTypePrice;
        _countTextField.placeholder = @"未设置";
        _countTextField.font = self.textFont;
        _countTextField.textColor = mainTextColor;
        _countTextField.delegate = self;
        [_countTextField setTranslatesAutoresizingMaskIntoConstraints:NO];
    }
    return _countTextField;
}

- (NSString *)getMatchContentWithOriginalText:(NSString *)originalText
                                  replaceText:(NSString *)replaceText
                                        range:(NSRange)range {
    NSMutableString *matchContent = [NSMutableString string];
    // 原始内容判空
    if (originalText.length) {
        NSMutableString *tempStr = [NSMutableString stringWithString:originalText];
        matchContent = tempStr;
    }
    // 新增内容越界处理
    if (replaceText.length) {
        if (range.location < matchContent.length) {
            [matchContent insertString:replaceText atIndex:range.location];
        }else {
            [matchContent appendString:replaceText];
        }
    }
    return matchContent;
}

- (void)setCurrentCount:(NSString *)currentCount
{
    _currentCount = currentCount;
    _countTextField.text = _currentCount;
    NSString *string = [NSString stringWithFormat:@"%%.%df",self.digits];
    NSDecimalNumber *num = [NSDecimalNumber decimalNumberWithString:self.currentCount];
    
    _countTextField.text = [NSString stringWithFormat:string,num.doubleValue];
//    NSLog(@"%@",[NSString stringWithFormat:string,currentCount]);
    
    if (SNCompare(self.currentCount, self.maxCount) == 1 || SNCompare(self.currentCount, self.maxCount) == 0) {
        
        self.plusButton.enabled = NO;
    }else{
        
        self.plusButton.enabled = YES;
    }
    if (SNCompare(self.currentCount, self.minCount) == -1 || SNCompare(self.currentCount, self.minCount) == 0) {
        
        self.minusButton.enabled = NO;
        
    }else{
        self.minusButton.enabled = YES;
    }
    
}

- (void)setMinCount:(NSString *)minCount
{
    _minCount = minCount;
    
    if (self.countTextField.text.length == 0) {
        self.tipLab.hidden = YES;
        return;
    }
    
    if (SNCompare(self.currentCount, self.maxCount) == 1 || SNCompare(self.currentCount, self.maxCount) == 0) {
        self.plusButton.enabled = NO;
    }else{
        
        self.plusButton.enabled = YES;
    }
    
    if (SNCompare(self.currentCount, self.minCount) == 1 || SNCompare(self.currentCount, self.minCount) == 0) {
        
        self.tipLab.hidden = YES;

    }else{
        self.tipLab.hidden = NO;
    }
    
    if(self.countTextField.text.length == 0){
        return;
    }
    if (SNCompare(self.currentCount, self.maxCount) == 1 || SNCompare(self.currentCount, self.maxCount) == 0) {
        self.plusButton.enabled = NO;
    }else{
        
        self.plusButton.enabled = YES;
    }
    if (SNCompare(self.currentCount, self.minCount) == -1 || SNCompare(self.currentCount, self.minCount) == 0) {
        
        self.minusButton.enabled = NO;
        
    }else{
        self.minusButton.enabled = YES;
    }
}



- (void)setMaxCount:(NSString *)maxCount
{
    _maxCount = maxCount;
    if (self.countTextField.text.length == 0) {
        self.tipLab.hidden = YES;
        return;
    }
    
    if (SNCompare(self.currentCount, self.maxCount) == -1 || SNCompare(self.currentCount, self.maxCount) == 0) {
        
        self.tipLab.hidden = YES;
        
    }else{
        self.tipLab.hidden = NO;
    }
    
   
    if(self.countTextField.text.length == 0){
        
        return;
    }
    
    if (SNCompare(self.currentCount, self.maxCount) == 1 || SNCompare(self.currentCount, self.maxCount) == 0) {
        self.plusButton.enabled = NO;
    }else{
        
        self.plusButton.enabled = YES;
    }
    if (SNCompare(self.currentCount, self.minCount) == -1 || SNCompare(self.currentCount, self.minCount) == 0) {
        
        self.minusButton.enabled = NO;
        
    }else{
        
        self.minusButton.enabled = YES;
    }
    
    
}

- (UILabel *)tipLab
{
    
    if (!_tipLab) {
        _tipLab = [[UILabel alloc] init];
        _tipLab.font = [UIFont systemFontOfSize:12];
        _tipLab.textColor = [MyColor colorWithHexString:@"#FE5353"];
    }
    return _tipLab;
}



- (void)setTextFont:(UIFont *)textFont
{
    self.countTextField.font = textFont;
    
}

- (void)setTextColor:(UIColor *)textColor
{
    self.countTextField.textColor = textColor;
}

- (void)setPlusDisabledImageStr:(NSString *)plusDisabledImageStr
{
    [_plusButton setImage:[UIImage imageNamed:plusDisabledImageStr] forState:UIControlStateDisabled];
}

- (void)setPlusNomalImageStr:(NSString *)plusNomalImageStr
{
    
    [_plusButton setImage:[UIImage imageNamed:plusNomalImageStr] forState:UIControlStateNormal];
    
    
}

- (void)setMinusNomalImageStr:(NSString *)minusNomalImageStr
{
    [_minusButton setImage:[UIImage imageNamed:minusNomalImageStr] forState:UIControlStateNormal];
    
}

- (void)setMinusDisabledImageStr:(NSString *)minusDisabledImageStr
{
    [_minusButton setImage:[UIImage imageNamed:minusDisabledImageStr] forState:UIControlStateDisabled];
    
}

- (NSString *)changeFloatWithFloat:(CGFloat)floatValue
{
    return [self changeFloatWithString:[NSString stringWithFormat:@"%f",floatValue]];
}

- (NSString *)changeFloatWithString:(NSString *)stringFloat
{
    const char *floatChars = [stringFloat UTF8String];
    NSUInteger length = [stringFloat length];
    NSUInteger zeroLength = 0;
    NSInteger i = length-1;
    for(; i>=0; i--)
    {
        if(floatChars[i] == '0') {
            zeroLength++;
        } else {
            if(floatChars[i] == '.')
                i--;
            break;
        }
    }
    NSString *returnString;
    if(i == -1) {
        returnString = @"0";
    } else {
        returnString = [stringFloat substringToIndex:i+1];
    }
    return returnString;
}


@end
