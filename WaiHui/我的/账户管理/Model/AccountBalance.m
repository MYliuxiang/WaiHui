//
//  AccountBalance.m
//  WaiHui
//
//  Created by liuxiang on 2019/2/21.
//  Copyright © 2019年 faxian. All rights reserved.
//

#import "AccountBalance.h"

@interface AccountBalance ()
@property(nonatomic,strong) NSArray *holdDataList;
@property(nonatomic,strong) NSArray *listDataList;
@end


@implementation AccountBalance

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        [self xw_addNotificationForName:ProductAlwaysNotice block:^(NSNotification * _Nonnull notification) {
            SocketModel *smodel = notification.userInfo[@"model"];
            if(![LxUserDefaults boolForKey:IsLogin]){
                return ;
            }
           
            if(self.holdDataList.count > 0){
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"symbol == %@",smodel.symbol];
            NSArray *filteredArray = [self.holdDataList filteredArrayUsingPredicate:predicate];
            
                if (filteredArray.count != 0) {
                
                HoldModel *model = filteredArray.firstObject;
                model.ask = [HandleTool changeFloatWithFloat:smodel.ask] ;
                model.ask_state = [HandleTool changeFloatWithFloat:smodel.ask_state];
                model.bid = [HandleTool changeFloatWithFloat:smodel.bid];
                model.bid_state = [HandleTool changeFloatWithFloat:smodel.bid_state];
                model.digits = [HandleTool changeFloatWithFloat:smodel.digits];
                [self isReloadPingWith:model];
                [self computeIncome];
                }
            }
            
            if (self.listDataList.count > 0) {
                
                
                
                
                NSPredicate *predicate = [NSPredicate predicateWithFormat:@"symbol == %@",smodel.symbol];
                NSArray *filteredArray = [self.listDataList filteredArrayUsingPredicate:predicate];
                
                if (filteredArray.count != 0) {
                    HoldModel *model = filteredArray.firstObject;

                        model.ask = [HandleTool changeFloatWithFloat:smodel.ask] ;
                        model.ask_state = [HandleTool changeFloatWithFloat:smodel.ask_state];
                        model.bid = [HandleTool changeFloatWithFloat:smodel.bid];
                        model.bid_state = [HandleTool changeFloatWithFloat:smodel.bid_state];
                        model.digits = [HandleTool changeFloatWithFloat:smodel.digits];
                    [self isReloadHoldeDataWith:model];
                    }
            }
        }];
        
        
    }
    return self;
}

- (void)isReloadPingWith:(HoldModel *)model
{
    if([model.sl doubleValue] == 0 && [model.tp doubleValue] == 0){
        
        return;
    }
    
    
    if ([model.command rangeOfString:@"Buy"].location != NSNotFound) {
        //买单
        if (SNCompare(model.bid, model.sl) == 0 || SNCompare(model.bid, model.sl) == -1) {
            [self loadHoldData];
        }
        
        if (SNCompare(model.bid, model.tp) == 0 || SNCompare(model.bid, model.tp) == 1){
            
            [self loadHoldData];

        }
        
    }else{
        //卖单
        if (SNCompare(model.bid, model.sl) == 0 || SNCompare(model.bid, model.sl) == 1) {
            [self loadHoldData];

        }
        
        if (SNCompare(model.bid, model.tp) == 0 || SNCompare(model.bid, model.tp) == -1) {
            [self loadHoldData];

            
        }
        
    }
    
}

- (void)isReloadHoldeDataWith:(HoldModel *)model
{
    if ([model.command rangeOfString:@"Buy"].location != NSNotFound){
        if ([model.command rangeOfString:@"Limit"].location != NSNotFound) {
            
            if (SNCompare(model.bid, model.open_price) == 0 || SNCompare(model.bid, model.open_price) == -1) {
                [self loadHoldData];
            }
        }else{
            if (SNCompare(model.bid, model.open_price) == 0 || SNCompare(model.bid, model.open_price) == 1) {
                [self loadHoldData];

            }
        }
    }else{
        if ([model.command rangeOfString:@"Limit"].location != NSNotFound) {
            
            if (SNCompare(model.bid, model.open_price) == 0 || SNCompare(model.bid, model.open_price) == 1) {
                [self loadHoldData];

            }
        }else{
            if (SNCompare(model.bid, model.open_price) == 0 || SNCompare(model.bid, model.open_price) == -1) {
                [self loadHoldData];

            }
        }
    }
    
}

- (void)setMt4ID:(NSString *)mt4ID
{
    _mt4ID = mt4ID;
    //请求余额
//    [self loadBanlance];
    //请求持仓信息
    [self loadHoldData];
    //请求挂单信息
    [self loadListData];
    
}

- (void)loadBanlance
{
    BADataEntity *entity = [BADataEntity new];
    entity.urlString = [NSString stringWithFormat:@"%@%@",MainUrl,Url_userAction];
    entity.needCache = NO;
    entity.parameters = @{@"types":@"5",@"mt4_id":[NSString stringWithFormat:@"%@",[LxUserDefaults objectForKey:Mt4_id]]};
    
    [BANetManager ba_request_POSTWithEntity:entity successBlock:^(id response) {
        NSDictionary *result = response;
        Mt4Balance *model = [Mt4Balance mj_objectWithKeyValues:result];
        
        if (model.ret == 0) {
            //成功
            model = [Mt4Balance mj_objectWithKeyValues:result];
            NSDecimalNumber *balance = handlerDecimalNumber(model.balance, NSRoundUp, 2);
            if (self.balanceBlock) {
                self.balanceBlock(balance.doubleValue);
            }
           
            
            
        }else{
            
            [SVProgressHUD showErrorWithStatus:model.msg];
        }
        
    } failureBlock:^(NSError *error) {
      
        
    } progressBlock:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];
    
    
}

- (void)loadHoldData
{
    BADataEntity *entity = [BADataEntity new];
    entity.urlString = [NSString stringWithFormat:@"%@%@",MainUrl,Url_transactionAction];
    entity.needCache = NO;
    entity.parameters = @{@"types":@"2",@"mt4_id":self.mt4ID};
    
    [BANetManager ba_request_POSTWithEntity:entity successBlock:^(id response) {
        NSDictionary *result = response;
        if ([result[@"code"] intValue] == 1) {
            //成功
            self.holdDataList = [HoldModel mj_objectArrayWithKeyValuesArray:result[@"data"]];
            [self computeIncome];
          
            
        }else{
            [SVProgressHUD showErrorWithStatus:result[@"message"]];
        }
        
        
    } failureBlock:^(NSError *error) {
       
        
        
    } progressBlock:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];
    
    
    
}

- (void)computeIncome{
    
    dispatch_queue_t queue = dispatch_queue_create("com.incom.com", DISPATCH_QUEUE_CONCURRENT);
    //队列中添加异步任务
    dispatch_async(queue, ^{
        
        double total = 0.0;
        
        for (int i = 0; i<self.holdDataList.count; i++) {
            HoldModel *model = self.holdDataList[i];
            
            total = total + [self computeSingleIncome:model].doubleValue;
            
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (self.balanceBlock) {
                self.balanceBlock(total);
            }
        });
    });
    
}

- (NSDecimalNumber *)computeSingleIncome:(HoldModel *)model
{
    //计算收益
    NSDecimalNumber *income;
    NSString *lots = SNDiv(model.volume, @"100.00").stringValue;
    
    if ([model.profit_mode isEqualToString:@"0"]) {
        if([model.command isEqualToString:@"Sell"]){
            
            income = SNMul_handler(SNMul(SNSub_handler(model.ask, model.open_price, NSRoundBankers, [model.digits intValue]), model.contract_size), lots, NSRoundBankers, 2);
            
            
        }else{
            
            income = SNMul_handler(SNMul(SNSub_handler(model.bid, model.open_price, NSRoundBankers, [model.digits intValue]), model.contract_size), lots, NSRoundBankers, 2);
            
        }
        
    }else if ([model.profit_mode isEqualToString:@"1"]){
        
        if([model.command isEqualToString:@"Sell"]){
            
            income = SNMul_handler(SNMul(SNSub_handler(model.ask, model.open_price, NSRoundBankers, [model.digits intValue]), model.contract_size), lots, NSRoundBankers, 2);
            
        }else{
            
            income = SNMul_handler(SNMul(SNSub_handler(model.bid, model.open_price, NSRoundBankers, [model.digits intValue]), model.contract_size), lots, NSRoundBankers, 2);
            
        }
        
    }else{
        
        if([model.command isEqualToString:@"Sell"]){
            
            income = SNMul_handler(SNMul(SNSub_handler(model.ask, model.open_price, NSRoundBankers, [model.digits intValue]), model.contract_size), model.tick_size, NSRoundBankers, 2);
            
        }else{
            
            income = SNMul_handler(SNMul(SNSub_handler(model.bid, model.open_price, NSRoundBankers, [model.digits intValue]), model.contract_size), model.tick_size, NSRoundBankers, 2);
            
        }
        
    }
    model.profit = income.stringValue;
    return income;
    
}

- (void)loadListData
{
  
    
  
    BADataEntity *entity = [BADataEntity new];
    entity.urlString = [NSString stringWithFormat:@"%@%@",MainUrl,Url_transactionAction];
    entity.needCache = NO;
    entity.parameters = @{@"types":@"4",@"mt4_id":self.mt4ID};
    
    [BANetManager ba_request_POSTWithEntity:entity successBlock:^(id response) {
        NSDictionary *result = response;
        if ([result[@"code"] intValue] == 0) {
            //成功
          
            
            self.listDataList = [HoldModel mj_objectArrayWithKeyValuesArray:result[@"data"]];
            
            
        }else{
            
            [SVProgressHUD showErrorWithStatus:result[@"message"]];
          
            
        }
        
        
    } failureBlock:^(NSError *error) {
       
        
        
    } progressBlock:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];
    
    
}



@end
