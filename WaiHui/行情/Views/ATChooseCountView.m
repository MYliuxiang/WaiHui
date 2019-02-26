//
//  ATChooseCountView.m
//  ATChooseCountView
//
//  Created by Attu on 16/10/12.
//  Copyright © 2016年 Attu. All rights reserved.
//

#define ATLINECOLOR [UIColor colorWithRed:200.0/255.0f green:200.0/255.0f blue:200.0/255.0f alpha:1]

#import "ATChooseCountView.h"

@interface ATChooseCountView ()<UITextFieldDelegate>



@property (nonatomic, strong) UIView *lineView1;
@property (nonatomic, strong) UIView *lineView2;

@end

@implementation ATChooseCountView

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
    self.minCount = 0;
    self.maxCount = CGFLOAT_MAX;
    self.minusButton.enabled = NO;
    self.lot_step = 1;
    

    
    [self addSubview:self.plusButton];
    [self addSubview:self.minusButton];
    [self addSubview:self.countTextField];
    [self addSubview:self.tipLab];
    self.tipLab.hidden = YES;
//    [self addSubview:self.lineView1];
//    [self addSubview:self.lineView2];
//    self.lineView1.hidden = YES;
//    self.lineView2.hidden = YES;
    
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

- (CGFloat)getCurrentCount {
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
    self.currentCount += self.lot_step;
   
    
    if (self.currentCount > self.maxCount){
        [self.ViewController.view makeToast:@"数量超出范围！" duration:2 position:CSToastPositionCenter];
        self.countTextField.text = [NSString stringWithFormat:@"%@",[self changeFloatWithFloat:self.maxCount]];
        NSDecimalNumber *decNumber = [NSDecimalNumber decimalNumberWithString:self.countTextField.text];
        double cuttt = [decNumber doubleValue];
        self.currentCount = cuttt;
        
    }else{
        
        self.countTextField.text = [NSString stringWithFormat:@"%@", [self changeFloatWithFloat:self.currentCount]];
        
    }
    if (self.currentCount >= self.maxCount) {
        self.plusButton.enabled = NO;
    }
    
    if (self.currentCount < self.maxCount || self.currentCount > self.minCount){
        
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
    self.currentCount -= self.lot_step;

   
    
    if (self.currentCount < self.minCount){
        
        [self.ViewController.view makeToast:@"数量超出范围！" duration:2 position:CSToastPositionCenter];
        self.countTextField.text = [NSString stringWithFormat:@"%@",[self changeFloatWithFloat:self.minCount]];
        
        NSDecimalNumber *decNumber = [NSDecimalNumber decimalNumberWithString:self.countTextField.text];
        double cuttt = [decNumber doubleValue];
        self.currentCount = cuttt;
        
    }else{
        
        self.countTextField.text = [NSString stringWithFormat:@"%@",[self changeFloatWithFloat:self.currentCount]];

    }
    
    
    if (self.currentCount <= self.minCount) {
        self.minusButton.enabled = NO;
    }
    
    if (self.currentCount < self.maxCount || self.currentCount > self.minCount){
        
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
    
    NSDecimalNumber *decNumber = [NSDecimalNumber decimalNumberWithString:self.countTextField.text];
    double cuttt = [decNumber doubleValue];
    
    if (cuttt > self.maxCount){
        [self.ViewController.view makeToast:@"数量超出范围！" duration:2 position:CSToastPositionCenter];
        textField.text = [NSString stringWithFormat:@"%@",[self changeFloatWithFloat:self.maxCount]];
        NSDecimalNumber *decNumber1 = [NSDecimalNumber decimalNumberWithString:self.countTextField.text];
        double cuttt1 = [decNumber1 doubleValue];
        self.currentCount = cuttt1;
        return;
    }
        
    
    if (cuttt < self.minCount){

        [self.ViewController.view makeToast:@"数量超出范围！" duration:2 position:CSToastPositionCenter];
        textField.text = [NSString stringWithFormat:@"%@",[self changeFloatWithFloat:self.minCount]];
        NSDecimalNumber *decNumber2 = [NSDecimalNumber decimalNumberWithString:self.countTextField.text];
        double cuttt2 = [decNumber2 doubleValue];
        self.currentCount = cuttt2;
        
        return;
    }
  
    self.currentCount = cuttt;
    if (self.currentCount >= self.maxCount) {
        self.plusButton.enabled = NO;
    }else{
        
        self.plusButton.enabled = YES;
    }
    if (self.currentCount <= self.minCount) {
        self.minusButton.enabled = NO;
    }else{
        self.minusButton.enabled = YES;
    }
}

//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
//{
//     NSString *matchStr = [self getMatchContentWithOriginalText:textField.text replaceText:string range:range];
//    NSMutableString *str = [NSMutableString stringWithFormat:@"%@",textField.text];
//    [str replaceCharactersInRange:range withString:string];
//    float ee = [str floatValue];
//    NSDecimalNumber *decNumber = [NSDecimalNumber decimalNumberWithString:matchStr];
//    double cuttt = [decNumber doubleValue];
//    if (ee == 0) {
//        return YES;
//    }
//    if (cuttt > self.maxCount || cuttt < self.minCount) {
//        return NO;
//    }
//    self.currentCount = [textField.text floatValue];
//
//    return YES;
//}
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
//      _countTextField.text = [NSString stringWithFormat:@"%@",[self changeFloatWithFloat:self.minCount]];
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

- (void)setCurrentCount:(CGFloat)currentCount
{
    _currentCount = currentCount;
    NSString *minStr = [self changeFloatWithFloat:currentCount];
    _countTextField.text = [NSString stringWithFormat:@"%@",minStr];
    if (self.currentCount >= self.maxCount) {
        self.plusButton.enabled = NO;
    }else{
        
        self.plusButton.enabled = YES;
    }
    if (self.currentCount <= self.minCount) {
        
        self.minusButton.enabled = NO;
        
    }else{
        self.minusButton.enabled = YES;
    }
    
}

- (void)setMinCount:(CGFloat)minCount
{
    _minCount = minCount;
    
    if (self.countTextField.text.length == 0) {
        self.tipLab.hidden = YES;
        return;
    }
    
    if (self.currentCount >= _minCount) {
        self.tipLab.hidden = YES;
    }else{
        self.tipLab.hidden = NO;
    }
    if(self.countTextField.text.length == 0){
        return;
    }
    if (self.currentCount <= self.minCount) {
        self.minusButton.enabled = NO;
    }else{
        self.minusButton.enabled = YES;
        
    }
    if (self.currentCount >= self.maxCount) {
        self.plusButton.enabled = NO;
        
    }else{
        self.plusButton.enabled = YES;
        
    }
}



- (void)setMaxCount:(CGFloat)maxCount
{
    _maxCount = maxCount;
    if (self.countTextField.text.length == 0) {
        self.tipLab.hidden = YES;
        return;
    }
    
    if (self.currentCount <= _maxCount) {
        
        self.tipLab.hidden = YES;
        
    }else{
        self.tipLab.hidden = NO;
    }
    
    if(self.countTextField.text.length == 0){
        
        return;
    }
    
    if (self.currentCount <= self.minCount) {
        self.minusButton.enabled = NO;
    }else{
        self.minusButton.enabled = YES;

    }
    if (self.currentCount >= self.maxCount) {
        self.plusButton.enabled = NO;

    }else{
        self.plusButton.enabled = YES;
        
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

- (UIView *)lineView1 {
    if (!_lineView1) {
        _lineView1 = [[UIView alloc] init];
        [_lineView1 setBackgroundColor:ATLINECOLOR];
        [_lineView1 setTranslatesAutoresizingMaskIntoConstraints:NO];
    }
    return _lineView1;
}

- (UIView *)lineView2 {
    if (!_lineView2) {
        _lineView2 = [[UIView alloc] init];
        [_lineView2 setBackgroundColor:ATLINECOLOR];
        [_lineView2 setTranslatesAutoresizingMaskIntoConstraints:NO];
    }
    return _lineView2;
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
