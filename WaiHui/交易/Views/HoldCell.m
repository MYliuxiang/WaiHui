//
//  HoldCell.m
//  WaiHui
//
//  Created by liuxiang on 2018/12/11.
//  Copyright © 2018年 faxian. All rights reserved.
//

#import "HoldCell.h"

@implementation HoldCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.hqBtn.layer.borderColor = [MyColor colorWithHexString:@"#DEDEEB"].CGColor;
    self.hqBtn.layer.borderWidth = 0.5;
    
    self.pcBtn.layer.borderColor = [MyColor colorWithHexString:@"#DEDEEB"].CGColor;
    self.pcBtn.layer.borderWidth = 0.5;
    
    self.szBtn.layer.borderColor = [MyColor colorWithHexString:@"#DEDEEB"].CGColor;
    self.szBtn.layer.borderWidth = 0.5;
    
    
    [self xw_addNotificationForName:ProductAlwaysNotice block:^(NSNotification * _Nonnull notification) {
        
        if(![LxUserDefaults boolForKey:IsLogin]){
            return ;
        }
        SocketModel *model = notification.userInfo[@"model"];
        
        if ([model.symbol isEqualToString:self.model.symbol]) {
            self.model.ask = [HandleTool changeFloatWithFloat:model.ask] ;
            self.model.ask_state = [HandleTool changeFloatWithFloat:model.ask_state];
            self.model.bid = [HandleTool changeFloatWithFloat:model.bid];
            self.model.bid_state = [HandleTool changeFloatWithFloat:model.bid_state];
            self.model.digits = [HandleTool changeFloatWithFloat:model.digits];
            self.model = self.model;
            [self isRefresh];
        }
        
    }];
    
}

- (void)isRefresh
{
    
    if([_model.sl doubleValue] == 0 && [_model.tp doubleValue] == 0){
        
        return;
    }
   

    if ([self.model.command rangeOfString:@"Buy"].location != NSNotFound) {
        //买单
        if (SNCompare(self.model.bid, self.model.sl) == 0 || SNCompare(self.model.bid, self.model.sl) == -1) {
            if (self.reloadBlock) {
                self.reloadBlock();

            }
        }
        
        if (SNCompare(self.model.bid, self.model.tp) == 0 || SNCompare(self.model.bid, self.model.tp) == 1){
            
            if (self.reloadBlock) {
                self.reloadBlock();
                
            }
        }
        
    }else{
        //卖单
        if (SNCompare(self.model.bid, self.model.sl) == 0 || SNCompare(self.model.bid, self.model.sl) == 1) {
            if (self.reloadBlock) {
                self.reloadBlock();
                
            }
        }
        
        if (SNCompare(self.model.bid, self.model.tp) == 0 || SNCompare(self.model.bid, self.model.tp) == -1) {
            if (self.reloadBlock) {
                self.reloadBlock();
            }
            
        }
        
    }
    
}

- (void)computeIncome
{
    //计算收益
    NSDecimalNumber *income;
    NSString *lots = SNDiv(self.model.volume, @"100.00").stringValue;

    if ([self.model.profit_mode isEqualToString:@"0"]) {
        if([_model.command isEqualToString:@"Sell"]){
            
            income = SNMul_handler(SNMul(SNSub_handler(self.model.ask, self.model.open_price, NSRoundBankers, [self.model.digits intValue]), self.model.contract_size), lots, NSRoundBankers, 2);

            
        }else{
           
            income = SNMul_handler(SNMul(SNSub_handler(self.model.bid, self.model.open_price, NSRoundBankers, [self.model.digits intValue]), self.model.contract_size), lots, NSRoundBankers, 2);
            
        }
        
    }else if ([self.model.profit_mode isEqualToString:@"1"]){
        
        if([_model.command isEqualToString:@"Sell"]){
            
            income = SNMul_handler(SNMul(SNSub_handler(self.model.ask, self.model.open_price, NSRoundBankers, [self.model.digits intValue]), self.model.contract_size), lots, NSRoundBankers, 2);
            
        }else{
            
            income = SNMul_handler(SNMul(SNSub_handler(self.model.bid, self.model.open_price, NSRoundBankers, [self.model.digits intValue]), self.model.contract_size), lots, NSRoundBankers, 2);
        }
        
    }else{
        
        if([_model.command isEqualToString:@"Sell"]){
            
            income = SNMul_handler(SNMul(SNSub_handler(self.model.ask, self.model.open_price, NSRoundBankers, [self.model.digits intValue]), self.model.contract_size), self.model.tick_size, NSRoundBankers, 2);
        }else{
            income = SNMul_handler(SNMul(SNSub_handler(self.model.bid, self.model.open_price, NSRoundBankers, [self.model.digits intValue]), self.model.contract_size), self.model.tick_size, NSRoundBankers, 2);
        }
        
    }
    
    self.lab3.text = [NSString stringWithFormat:@"%.2f",[income doubleValue]];
    if ([self.lab3.text rangeOfString:@"-"].location != NSNotFound) {
        self.lab3.textColor = Color_Green;
    }else{
        self.lab3.textColor = Color_Red;
    }
    
    
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.orderCount.layer.masksToBounds = YES;
    self.orderCount.layer.cornerRadius = 3;
    
}

- (void)setModel:(HoldModel *)model
{
    _model = model;
    self.nameLab.text = _model.symbolName;
    self.subName.text = _model.symbol;
    self.timeLab.text = _model.open_time;
    NSDecimalNumber *storage = handlerDecimalNumber(_model.storage, NSRoundBankers, 2);
    self.storageLab.text = [NSString stringWithFormat:@"利息：%.2f",[storage doubleValue]];
    
    NSDecimalNumber *commission = handlerDecimalNumber(_model.commission, NSRoundBankers, 2);
    self.commissionLab.text = [NSString stringWithFormat:@"佣金：%.2f",[commission doubleValue]];
    
    self.sl.text = [NSString stringWithFormat:@"止损：%@",_model.sl];
    self.zyLab.text = [NSString stringWithFormat:@"止盈：%@",_model.tp];
    self.lab1.text = _model.open_price;
    self.lab1.text = [handlerDecimalNumber(_model.open_price, NSRoundBankers, [self.model.digits intValue]) stringValue];
    
    NSString *vo = SNDiv(model.volume, @"100").stringValue;
    if([_model.command isEqualToString:@"Sell"]){
        [self.orderCount setTitle:[NSString stringWithFormat:@"卖出%@手",vo] forState:UIControlStateNormal];
        self.orderCount.backgroundColor = [MyColor colorWithHexString:@"#3ACCB2"];
        
        NSDecimalNumber *num = [[NSDecimalNumber alloc] initWithString:_model.ask];
        NSString *fromt = [NSString stringWithFormat:@"%%.%@f",self.model.digits];
        self.lab2.text = [NSString stringWithFormat:fromt,num.doubleValue];

        if (model.ask_state == 2) {
            self.lab2.textColor = Color_Red;
        }else if(model.ask_state == 1){
            self.lab2.textColor = Color_Green;
        }else{
            self.lab2.textColor = Color_Gray;

        }

    }else{
        [self.orderCount setTitle:[NSString stringWithFormat:@"买入%@手",vo] forState:UIControlStateNormal];
        self.orderCount.backgroundColor = [MyColor colorWithHexString:@"#FF8E87"];
        NSDecimalNumber *num = [[NSDecimalNumber alloc] initWithString:_model.bid];
        NSString *fromt = [NSString stringWithFormat:@"%%.%@f",self.model.digits];
        self.lab2.text = [NSString stringWithFormat:fromt,num.doubleValue];
        
        if (model.bid_state == 2) {
            self.lab2.textColor = Color_Red;
        }else if(model.bid_state == 1){
            self.lab2.textColor = Color_Green;
        }else{
            self.lab2.textColor = Color_Gray;
        }
        
    }
    
   
   
    
    if([_model.sl doubleValue] == 0){
        self.sl.text = [NSString stringWithFormat:@"止损：未设置"];

    }else{

        self.sl.text = [NSString stringWithFormat:@"止损：%@",_model.sl];

    }

    if([_model.tp doubleValue] == 0){
        self.zyLab.text = [NSString stringWithFormat:@"止盈：未设置"];

    }else{

        self.zyLab.text = [NSString stringWithFormat:@"止盈：%@",_model.tp];

    }
    
   
    [self computeIncome];

    
    if (_model.isOpen) {
        //打开
        self.backgroundColor = [MyColor colorWithHexString:@"#F4F6FB"];
        _btnView.sd_layout.heightIs(40);
       [self setupAutoHeightWithBottomViewsArray:@[_btnView] bottomMargin:15];
        
    }else{
        //关闭
        _btnView.clipsToBounds = YES;
        _btnView.sd_layout.heightIs(0);
        self.backgroundColor = [UIColor whiteColor];
       [self setupAutoHeightWithBottomViewsArray:@[_zyLab] bottomMargin:15];
    }
    
}

- (IBAction)hqAC:(id)sender {
    if (self.hqBlock) {
        self.hqBlock(self.model);
    }
}
- (IBAction)pcAC:(id)sender {
    
    if (self.pcBlock) {
        self.pcBlock(self.model);
    }
}

- (IBAction)szAC:(id)sender {
    
    if (self.szBlock) {
        self.szBlock(self.model);
    }
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
