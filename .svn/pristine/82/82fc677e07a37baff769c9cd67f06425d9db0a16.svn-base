//
//  QuotationListVC.m
//  WaiHui
//
//  Created by liuxiang on 2018/12/6.
//  Copyright © 2018年 faxian. All rights reserved.
//

#import "QuotationListVC.h"

@interface QuotationListVC ()
{
    dispatch_source_t _timer;

}
@property(nonatomic,strong) NSMutableArray *dataList;
@property(atomic,strong) NSMutableArray *indexPaths;
@property(atomic,assign) BOOL runTimer;


@end

@implementation QuotationListVC

#pragma mark - JXCategoryListContentViewDelegate
- (UIView *)listView {
    return self.view;
}

- (void)listDidAppear {
    NSLog(@"%@", NSStringFromSelector(_cmd));
    if ([SocketHandler shareInstance].connectStatus == SocketConnectStatus_Connected) {
        if (!self.runTimer) {
            dispatch_resume(_timer);
            self.runTimer = YES;
        }
    }
}

- (void)listDidDisappear {
    NSLog(@"%@", NSStringFromSelector(_cmd));
    if (_timer) {
        if (self.runTimer) {
            dispatch_suspend(_timer);
            self.runTimer = NO;
        }
    }
}



- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if ([SocketHandler shareInstance].connectStatus == SocketConnectStatus_Connected) {
        if (!self.runTimer) {
            dispatch_resume(_timer);
            self.runTimer = YES;
        }
    }
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    if (_timer) {
        if (self.runTimer) {
            dispatch_suspend(_timer);
            self.runTimer = NO;
        }
    }
   
}

- (void)dealloc{
    if(_timer){
        dispatch_source_cancel(_timer);
        _timer = nil;
    }
}

- (void)socketReConnecting
{
    self.tableView.tableHeaderView = self.socketTipView;

    
}

- (void)socketConnected
{
    self.tableView.tableHeaderView = nil;
    if (!self.runTimer) {
        dispatch_resume(_timer);
        self.runTimer = YES;
    }
    
}

- (void)socketUnConnected
{
    
    self.tableView.tableHeaderView = self.socketTipView;
    if (self.runTimer) {
        dispatch_suspend(_timer);
        self.runTimer = NO;
    }

}

- (void)handlerData:(NSArray *)array
{
    dispatch_queue_t queue = dispatch_queue_create("com.socket.com", DISPATCH_QUEUE_CONCURRENT);
    //队列中添加异步任务
    dispatch_async(queue, ^{
    
        for (int i = 0; i<self.dataList.count; i++) {

//            @autoreleasepool {
                ProductModel *model = self.dataList[i];
                SocketDataHandler *handler = [SocketDataHandler shareInstance];
                for (int j = 0;j < handler.dataList.count;j++) {
                    SocketModel *smodel = handler.dataList[j];
                    if ([smodel.symbol isEqualToString:model.symbol]) {
                        model.ask = smodel.ask;
                        model.ask_state = smodel.ask_state;
                        model.bid = smodel.bid;
                        model.bid_state = smodel.bid_state;
                        model.calculate_state = smodel.calculate_state;
                        model.genre_state = smodel.genre_state;
                        model.digits = smodel.digits;

                        
                        dispatch_async(dispatch_get_main_queue(), ^{
                                            [self xw_postNotificationWithName:SocketDataChanger userInfo:@{@"model":model}];
                                        });
                       
                        break;
                    }
                }
        }
        
    });
}

- (void)viewDidLoad {
    
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.dataList = [NSMutableArray array];
    self.indexPaths = [NSMutableArray array];
    NSTimeInterval period = 1; //设置时间间隔
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), period * NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        //在这里执行事件
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            self.indexPaths = [self.tableView indexPathsForVisibleRows];
        });
        [self handlerData:self.indexPaths];
    });
    
    [self checkNetWork];

   
}

- (void)checkNetWork
{
    __weak typeof(self) weakSelf = self;

    [BANetManager ba_startNetWorkMonitoringWithBlock:^(BANetworkStatus status) {
        [AFNetworkReachabilityManager.sharedManager stopMonitoring];

        switch (status) {
            case BANetworkStatusUnknown:{
                
            }
                break;
                
            case BANetworkStatusNotReachable:{
                self.tableView.ly_emptyView = self.noNetView;
                [self.tableView ly_endLoading];
                [LxDelayed delayedTime:1 withActionBlock:^{
                    [weakSelf checkNetWork];
                }];
                
            }
                break;
            case BANetworkStatusReachableViaWWAN:{
                
                self.tableView.mj_header = [LxResfreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(downLoad)];
                [self.tableView.mj_header beginRefreshing];

            }
                break;
                
            case BANetworkStatusReachableViaWiFi:{
                 self.tableView.mj_header = [LxResfreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(downLoad)];
                [self.tableView.mj_header beginRefreshing];
            }
                break;
                
            default:
                break;
        }
    }];
    
}

- (void)downLoad
{
    [self loadsubData];
}

- (void)loadsubData
{

    self.tableView.ly_emptyView = self.noDataView;
    self.noDataView.titleStr = @"暂无数据";
    
    BADataEntity *entity = [BADataEntity new];
    entity.urlString = [NSString stringWithFormat:@"%@%@",MainUrl,Url_marketCentre];
    entity.needCache = NO;
    entity.parameters = @{@"types":@"1",@"mt4_id":[NSString stringWithFormat:@"%@",[LxUserDefaults objectForKey:Mt4_id]],@"Access_Token":[NSString stringWithFormat:@"%@",[LxUserDefaults objectForKey:Token]]};
    
    [BANetManager ba_request_POSTWithEntity:entity successBlock:^(id response) {
        NSDictionary *result = response;
        if ([result[@"code"] intValue] == 1) {
            //成功
            [BANetManagerCache ba_setHttpCache:response urlString:entity.urlString parameters:@{@"types":@"1"}];
            
            NSArray *array = [ProductModel mj_objectArrayWithKeyValuesArray:result[@"data"]];
            [self.dataList removeAllObjects];
            for (ProductModel *model in array) {
                if ([self.biaoTi isEqualToString:@"外汇"]) {
                    if (model.genre_state == 1) {
                        [self.dataList addObject:model];
                    }
                }
            if ([self.biaoTi isEqualToString:@"商品"]) {
                    if (model.genre_state == 2) {
                        [self.dataList addObject:model];
                    }
            }
                
                if ([self.biaoTi isEqualToString:@"指数"]) {
                    if (model.genre_state == 3) {
                        [self.dataList addObject:model];
                    }
                }
                
                if ([self.biaoTi isEqualToString:@"数字货币"]) {
                    if (model.genre_state == 4) {
                        [self.dataList addObject:model];
                    }
                }
            }
            
//            NSDictionary *dic = @{@"type":@"All",@"symbol_list":result[@"data"][@"symbol_list"]};
//            [[SocketHandler shareInstance] sendDataToServer:dic];
            
            [self.tableView reloadData];
            [self.tableView.mj_header endRefreshing];
            [self.tableView ly_endLoading];

        }else{
            
            [SVProgressHUD showErrorWithStatus:result[@"message"]];
            [self.tableView.mj_header endRefreshing];
            [self.tableView ly_endLoading];

        }
        
        
    } failureBlock:^(NSError *error) {
        [self.tableView.mj_header endRefreshing];
        self.tableView.ly_emptyView = self.systemExceptionView;
        [self.tableView ly_endLoading];
        
    } progressBlock:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];
    
}

- (void)networkNoReachable
{
    
    self.tableView.ly_emptyView = self.noNetView;
    [self.tableView ly_endLoading];
    
}

- (void)networkReachable
{
    [self.tableView.mj_header beginRefreshing];
    
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
    QuoTationListCell *cell = [tableView dequeueReusableCellWithIdentifier:identifire];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"QuoTationListCell" owner:nil options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    
    cell.model = self.dataList[indexPath.row];
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (self.dataList.count == 0) {
        return 0;
    }
    return 20;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    DetailQuotationVC *vc = [[DetailQuotationVC alloc] init];
    ProductModel *model = self.dataList[indexPath.row];
    vc.sybol = model.symbol;
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (self.dataList.count == 0) {
        return [UIView new];
    }
    return self.headerView;
}


@end
