//
//  HoldPositionsVC.m
//  WaiHui
//
//  Created by liuxiang on 2018/12/11.
//  Copyright © 2018年 faxian. All rights reserved.
//

#import "HoldPositionsVC.h"

@interface HoldPositionsVC ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,retain) NSArray *dataList;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activity;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, copy) void(^scrollCallback)(UIScrollView *scrollView);


@end

@implementation HoldPositionsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.activity.hidden = YES;
   
    [self loadsubData];

    [self xw_addNotificationForName:HoldChangeNotice block:^(NSNotification * _Nonnull notification) {
 
            [self loadsubData];
        
    }];
    
    [self xw_addNotificationForName:ProductAlwaysNotice block:^(NSNotification * _Nonnull notification) {
        if(![LxUserDefaults boolForKey:IsLogin]){
            return ;
        }
        SocketModel *smodel = notification.userInfo[@"model"];
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"symbol == %@",smodel.symbol];
        NSArray *filteredArray = [self.dataList filteredArrayUsingPredicate:predicate];
        if (filteredArray.count != 0) {
        
            HoldModel *model = filteredArray.firstObject;
            model.ask = [HandleTool changeFloatWithFloat:smodel.ask] ;
            model.ask_state = [HandleTool changeFloatWithFloat:smodel.ask_state];
            model.bid = [HandleTool changeFloatWithFloat:smodel.bid];
            model.bid_state = [HandleTool changeFloatWithFloat:smodel.bid_state];
            model.digits = [HandleTool changeFloatWithFloat:smodel.digits];
            [self computeIncome];
        }
        
    }];
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


- (void)computeIncome{
    
    dispatch_queue_t queue = dispatch_queue_create("com.incom.com", DISPATCH_QUEUE_CONCURRENT);
    //队列中添加异步任务
    dispatch_async(queue, ^{

        double total = 0.0;

        for (int i = 0; i<self.dataList.count; i++) {
            HoldModel *model = self.dataList[i];

            total = total + [self computeSingleIncome:model].doubleValue;
           
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            self.totalIncom(total);
        });
        
    });


}


- (void)loadsubData
{
    self.activity.hidden = NO;
    [self.activity startAnimating];
    
    self.tableView.ly_emptyView = self.noDataView;
    self.noDataView.titleStr = @"暂无持仓记录";
    self.noDataView.subViewMargin = 0;
    self.noDataView.imageMargin = 0;

    BADataEntity *entity = [BADataEntity new];
    entity.urlString = [NSString stringWithFormat:@"%@%@",MainUrl,Url_transactionAction];
    entity.needCache = NO;
    entity.parameters = @{@"types":@"2",@"mt4_id":self.mt4Str};
    
    [BANetManager ba_request_POSTWithEntity:entity successBlock:^(id response) {
        NSDictionary *result = response;
        if ([result[@"code"] intValue] == 1) {
            //成功
            self.activity.hidden = YES;
            [self.activity stopAnimating];
            self.dataList = [HoldModel mj_objectArrayWithKeyValuesArray:result[@"data"]];
            [self computeIncome];
            [self.tableView reloadData];
            [self.tableView ly_endLoading];
            
        }else{
            
            self.activity.hidden = YES;
            [self.activity stopAnimating];
            [SVProgressHUD showErrorWithStatus:result[@"message"]];
            self.tableView.ly_emptyView = self.systemExceptionView;
            [self.tableView ly_endLoading];
            [self.tableView ly_endLoading];
            
        }
        
        
    } failureBlock:^(NSError *error) {
        self.activity.hidden = YES;
        [self.activity stopAnimating];
        
        self.tableView.ly_emptyView = self.systemExceptionView;
        [self.tableView ly_endLoading];
        
       
        
    } progressBlock:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];
    
    
}





#pragma  mark --------UITableView Delegete----------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    static NSString *identifire = @"cellID";
    HoldCell *cell = [tableView dequeueReusableCellWithIdentifier:identifire];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"HoldCell" owner:nil options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }

    cell.model = self.dataList[indexPath.row];
    
    cell.hqBlock = ^(HoldModel * _Nonnull model) {
        //行情
        
        DetailQuotationVC *vc = [[DetailQuotationVC alloc] init];
        vc.sybol = model.symbol;
        [self.navigationController pushViewController:vc animated:YES];
    };
    
    cell.pcBlock = ^(HoldModel * _Nonnull model) {
        //平仓
        ClosePositionDetailVC *vc = [[ClosePositionDetailVC alloc] init];
        vc.reloadBlock = ^{
            [self reloadSUB];
        };
        vc.model = model;
        [self.navigationController pushViewController:vc animated:YES];
    };
    
    cell.szBlock = ^(HoldModel * _Nonnull model) {
        //设置
        SetLossVC *vc = [[SetLossVC alloc] init];
        vc.model = model;
        vc.reloadBlock = ^{
            [self reloadSUB];

        };
        [self.navigationController pushViewController:vc animated:YES];
        
    };
    cell.reloadBlock = ^{
        [self reloadSUB];
    };

    return cell;

}

- (void)reloadSUB
{
    self.tableView.ly_emptyView = self.noDataView;
    self.noDataView.titleStr = @"暂无持仓记录";
    
    BADataEntity *entity = [BADataEntity new];
    entity.urlString = [NSString stringWithFormat:@"%@%@",MainUrl,Url_transactionAction];
    entity.needCache = NO;
    entity.parameters = @{@"types":@"2",@"mt4_id":self.mt4Str};
    
    [BANetManager ba_request_POSTWithEntity:entity successBlock:^(id response) {
        NSDictionary *result = response;
        if ([result[@"code"] intValue] == 1) {
            //成功
            self.activity.hidden = YES;
            [self.activity stopAnimating];
            self.dataList = [HoldModel mj_objectArrayWithKeyValuesArray:result[@"data"]];
            [self computeIncome];
            [self.tableView reloadData];
            [self.tableView ly_endLoading];
            
        }else{
            
            self.activity.hidden = YES;
            [self.activity stopAnimating];
            [SVProgressHUD showErrorWithStatus:result[@"message"]];
            self.tableView.ly_emptyView = self.systemExceptionView;
            [self.tableView ly_endLoading];
            [self.tableView ly_endLoading];
            
        }
        
        
    } failureBlock:^(NSError *error) {
        self.activity.hidden = YES;
        [self.activity stopAnimating];
        
        self.tableView.ly_emptyView = self.systemExceptionView;
        [self.tableView ly_endLoading];
        
        
        
    } progressBlock:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HoldModel *model = self.dataList[indexPath.row];
    return [self.tableView cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[HoldCell class] contentViewWidth:kScreenWidth];;

}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{

    return 0.1;

}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HoldModel *model = self.dataList[indexPath.row];
    model.isOpen = !model.isOpen;
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    if(indexPath.row == self.dataList.count - 1){
        [tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    }


}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    !self.scrollCallback ?: self.scrollCallback(scrollView);
}

#pragma mark - JXPagingViewListViewDelegate
- (UIView *)listView {
    return self.view;
}


- (UIScrollView *)listScrollView {
    return self.tableView;
}


- (void)listViewDidScrollCallback:(void (^)(UIScrollView *))callback {
    self.scrollCallback = callback;
}

@end
