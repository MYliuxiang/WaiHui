//
//  ClosePositionDetailVC.m
//  WaiHui
//
//  Created by liuxiang on 2018/12/13.
//  Copyright © 2018年 faxian. All rights reserved.
//

#import "ClosePositionDetailVC.h"

@interface ClosePositionDetailVC ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIView *footerView;

@property (nonatomic,strong) NSArray *titles;
@property (weak, nonatomic) IBOutlet UIButton *doneBtn;

@end

@implementation ClosePositionDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"平仓";
    [self wr_setNavBarShadowImageHidden:YES];
    self.footerView.height = 124;
    [self.doneBtn hyb_addCornerRadius:5 size:CGSizeMake(kScreenWidth - 30, 44)];
    self.tableView.tableFooterView = self.footerView;
    self.titles = @[@"开仓价格",@"当前价格",@"当前盈亏",@"平仓手数"];
    
    
    [self xw_addNotificationForName:ProductAlwaysNotice block:^(NSNotification * _Nonnull notification) {
        
      
        SocketModel *model = notification.userInfo[@"model"];
        
        if ([model.symbol isEqualToString:self.model.symbol]) {
            self.model.ask = [HandleTool changeFloatWithFloat:model.ask] ;
            self.model.ask_state = model.ask_state;
            self.model.bid = [HandleTool changeFloatWithFloat:model.bid];
            self.model.bid_state = model.bid_state;
            self.model.digits = [HandleTool changeFloatWithFloat:model.digits];
            [self reloadUI];
        }
        
    }];
}

- (void)reloadUI
{
    
    ValueOneCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    if([_model.command isEqualToString:@"Sell"]){
        
        NSDecimalNumber *num = [[NSDecimalNumber alloc] initWithString:_model.ask];
        NSString *fromt = [NSString stringWithFormat:@"%%.%@f",self.model.digits];
        cell.priceLab.text = [NSString stringWithFormat:fromt,num.doubleValue];
        
        if (self.model.ask_state == 2) {
            cell.priceLab.textColor = Color_Red;
        }else if(self.model.ask_state == 1){
            cell.priceLab.textColor = Color_Green;
        }else{
            cell.priceLab.textColor = Color_Gray;
        }
        
    }else{
       
        NSDecimalNumber *num = [[NSDecimalNumber alloc] initWithString:_model.bid];
        NSString *fromt = [NSString stringWithFormat:@"%%.%@f",self.model.digits];
        cell.priceLab.text = [NSString stringWithFormat:fromt,num.doubleValue];
        
        
        if (self.model.bid_state == 2) {
            cell.priceLab.textColor = Color_Red;
            
        }else if(self.model.bid_state == 1){
            cell.priceLab.textColor = Color_Green;
            
        }else{
            cell.priceLab.textColor = Color_Gray;

        }
        
    }
    
    [self computeIncome];
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
    
    ValueOneCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    cell.priceLab.text = [NSString stringWithFormat:@"$%.2f",[income doubleValue]];
    if ([cell.priceLab.text rangeOfString:@"-"].location != NSNotFound) {
        cell.priceLab.textColor = Color_Green;
    }else{
        cell.priceLab.textColor = Color_Red;
    }
    
    
    
}


#pragma  mark --------UITableView Delegete----------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.titles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 3) {
        
      
        static NSString *identifire = @"cellIDOne";
        ClosPostionCell *cell = [tableView dequeueReusableCellWithIdentifier:identifire];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"ClosPostionCell" owner:nil options:nil] lastObject];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
        cell.nameLab.text = @"平仓手数";
        
        NSString *vo = SNDiv(self.model.volume, @"100").stringValue;

        cell.step = self.model.lot_step;
        cell.max = vo;
       
       
        NSString *minStr = self.model.lot_step;
        if ([minStr rangeOfString:@"."].location == NSNotFound) {
            cell.countView.countTextField.limitedSuffix = 0;
            cell.countView.digits = 0;
            
        }else{
            
            cell.countView.countTextField.limitedSuffix = minStr.length - [minStr rangeOfString:@"."].location - 1;
            cell.countView.digits = minStr.length - [minStr rangeOfString:@"."].location - 1;
            
        }
        int a = [vo intValue];
        cell.countView.plusButton.enabled = NO;
        cell.countView.minusButton.enabled = YES;
        cell.countView.countTextField.limitedPrefix = [NSString stringWithFormat:@"%d",a].length;
        cell.countView.currentCount = vo;
                
        
        return cell;
    }else{
        
        static NSString *identifire = @"cellID";
        ValueOneCell *cell = [tableView dequeueReusableCellWithIdentifier:identifire];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"ValueOneCell" owner:nil options:nil] lastObject];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
        
        cell.nameLab.text = self.titles[indexPath.row];
        if (indexPath.row == 0) {
            cell.priceLab.textColor = [MyColor colorWithHexString:@"#747898"];
            cell.priceLab.text = self.model.open_price;
            
        }else if (indexPath.row == 1){
            if([_model.command isEqualToString:@"Sell"]){
                
                NSDecimalNumber *num = [[NSDecimalNumber alloc] initWithString:_model.ask];
                NSString *fromt = [NSString stringWithFormat:@"%%.%@f",self.model.digits];
                cell.priceLab.text = [NSString stringWithFormat:fromt,num.doubleValue];
                
                if (self.model.ask_state == 2) {
                    cell.priceLab.textColor = Color_Red;
                }else if(self.model.ask_state == 1){
                    cell.priceLab.textColor = Color_Green;
                    
                }else{
                    cell.priceLab.textColor = Color_Gray;
                }
                
            }else{
                
                NSDecimalNumber *num = [[NSDecimalNumber alloc] initWithString:_model.bid];
                NSString *fromt = [NSString stringWithFormat:@"%%.%@f",self.model.digits];
                cell.priceLab.text = [NSString stringWithFormat:fromt,num.doubleValue];
                
                
                if (self.model.bid_state == 2) {
                    cell.priceLab.textColor = Color_Red;
                    
                }else if(self.model.bid_state == 1){
                    cell.priceLab.textColor = Color_Green;
                    
                }else{
                    cell.priceLab.textColor = Color_Gray;

                    
                }
                
            }
            
        }else{
            
            NSDecimalNumber *profit = [[NSDecimalNumber alloc] initWithString:self.model.profit];
            cell.priceLab.text = [NSString stringWithFormat:@"$%.2f",profit.doubleValue];
            if ([cell.priceLab.text rangeOfString:@"-"].location != NSNotFound) {
                cell.priceLab.textColor = Color_Green;
            }else{
                cell.priceLab.textColor = Color_Red;
            }
        }
        
        return cell;
       
    }
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 3) {
        return 80;
    }
    return 48;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 32;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 32)];
    view.backgroundColor = [MyColor colorWithHexString:@"#FAFBFE"];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 0,30, 32)];
    label.text = self.model.symbolName;
    label.font = [UIFont systemFontOfSize:12];
    label.textColor = [MyColor colorWithHexString:@"#2B2B76"];
    [view addSubview:label];
    [label sizeToFit];
    label.centerY = view.centerY;
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(label.right + 5, 0,30, 32)];
    label1.text = self.model.symbol;
    label1.font = [UIFont systemFontOfSize:10];
    label1.textColor = [MyColor colorWithHexString:@"#9EA3C6"];
    [view addSubview:label1];
    [label1 sizeToFit];
    label1.centerY = view.centerY;
    return view;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
}

- (IBAction)doneAC:(id)sender {
    
    
    ClosPostionCell *zeroCell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
    
    if ([zeroCell.countView.countTextField.text doubleValue] == 0) {
        [SVProgressHUD showErrorWithStatus:@"请先设置平仓手数！"];
        return;
    }
    
    ValueOneCell *priceCell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    
    if ([zeroCell.countView.countTextField.text doubleValue] == 0) {
        [SVProgressHUD showErrorWithStatus:@"请先设置平仓手数！"];
        return;
    }
    
   
    
    BADataEntity *entity = [BADataEntity new];
    entity.urlString = [NSString stringWithFormat:@"%@%@",MainUrl,Url_transactionAction];
    entity.needCache = NO;
    entity.parameters = @{@"types":@"1",@"Access_Token":[LxUserDefaults objectForKey:Token],@"mt4_id":[LxUserDefaults objectForKey:Mt4_id],@"symbol":self.model.symbol,@"type":@"OrderClose",@"command":self.model.command,@"volume":[NSString stringWithFormat:@"%@",zeroCell.countView.countTextField.text],@"order":self.model.order,@"operateForm":@"Ios",@"price":priceCell.priceLab.text,@"sl":@"",@"tp":@""};
    [SVProgressHUD show];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    
    [BANetManager ba_request_POSTWithEntity:entity successBlock:^(id response) {
        NSDictionary *result = response;
        if ([result[@"code"] intValue] == 1) {
            //成功
            [SVProgressHUD dismiss];
            [SVProgressHUD showSuccessWithStatus:@"平仓成功"];
            if (self.reloadBlock) {
                self.reloadBlock();
            }
            [self.navigationController popViewControllerAnimated:YES];

            
        }else{
            
            if([result[@"code"] intValue] == -1){
                //登录
                Mt4LoginAlert *alert = [[Mt4LoginAlert alloc] initTableViewAlertWithTitle:[NSString stringWithFormat:@"模拟账户：%@",[LxUserDefaults objectForKey:Mt4_id]]];
                alert.loginBlcok = ^(int type) {
                    if (type == 1) {
                        ResetPWStartVC *vc = [[ResetPWStartVC alloc] init];
                        vc.mt4Str = [LxUserDefaults objectForKey:Mt4_id];
                        [self.navigationController pushViewController:vc animated:YES];
                    }else{
                        [SVProgressHUD showSuccessWithStatus:@"登录成功请继续交易"];
                    }
                };
                [alert show];
            }
            [SVProgressHUD showErrorWithStatus:result[@"message"]];
            
        }
        
        
    } failureBlock:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:error.userInfo[@"NSDebugDescription"]];
        
        
    } progressBlock:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];
    
}



@end
