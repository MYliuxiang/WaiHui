//
//  OptionalVC.m
//  WaiHui
//
//  Created by liuxiang on 2018/12/6.
//  Copyright © 2018年 faxian. All rights reserved.
//

#import "OptionalVC.h"

@interface OptionalVC ()
{
    dispatch_source_t _timer;
    
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIView *headerView;
@property (nonatomic,assign) BOOL loginOperation;
@property (nonatomic,strong) NSArray *dataList;
@property (nonatomic,strong) LxEmptyView *subNodataView;
@property (nonatomic,assign) BOOL mt4Have;
@property (nonatomic,assign) int reload;
@property(atomic,assign) BOOL runTimer;
@property(atomic,strong) NSMutableArray *indexPaths;


@end

@implementation OptionalVC

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (![LxUserDefaults boolForKey:IsLogin]) {
        
        LoginphoneVC *vc = [LoginphoneVC new];
        vc.backIndex = YES;
        BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:vc];
        [self presentViewController:nav animated:YES completion:nil];
        return;
    }
//    if (!self.mt4Have) {
//    }
//
//    if (self.reload > 0) {
//        [self.tableView.mj_header beginRefreshing];
//    }
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (_timer) {
        if ([SocketHandler shareInstance].connectStatus == SocketConnectStatus_Connected) {
            if (!self.runTimer) {
                dispatch_resume(_timer);
                self.runTimer = YES;
            }
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
    NSLog(@"自选timer");
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
    self.title = @"自选";
    [self wr_setNavBarShadowImageHidden:YES];
    
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

    [self xw_addNotificationForName:LoginCompletionNotice block:^(NSNotification * _Nonnull notification) {
        [self checkNetWork];
    }];
    
    [self xw_addNotificationForName:OptionalNotice block:^(NSNotification * _Nonnull notification) {
        NSDictionary *dic = notification.userInfo;
        [self.tableView.mj_header beginRefreshing];

        if ([dic[@"add"] boolValue]) {
            self.reload++;
        }else{
            self.reload--;
        }
        
        
    }];

    
}

- (void)gotoVC
{
    //账户管理
    BADataEntity *entity = [BADataEntity new];
    entity.urlString = [NSString stringWithFormat:@"%@%@",MainUrl,Url_MyCenter];
    entity.needCache = NO;
    entity.parameters = @{@"types":@"15",@"Access_Token":[LxUserDefaults objectForKey:Token]};
    [SVProgressHUD show];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [BANetManager ba_request_POSTWithEntity:entity successBlock:^(id response) {
        NSDictionary *result = response;
        if ([result[@"code"] intValue] == 1) {
            //成功
            [SVProgressHUD dismiss];
            NSArray *array = [Mt4Model mj_objectArrayWithKeyValuesArray:result[@"data"]];
            AccountManagerVC *vc = [[AccountManagerVC alloc] init];
            vc.dataList = array;
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            
            [SVProgressHUD showErrorWithStatus:result[@"message"]];
            
        }
        
        
    } failureBlock:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:error.userInfo[@"NSDebugDescription"]];
        
        
    } progressBlock:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];
    
}

- (void)checkNetWork
{
    
    if ([LxUserDefaults boolForKey:IsLogin]) {
        
    NSString *seletedMt4_id = [NSString stringWithFormat:@"%@",[LxUserDefaults objectForKey:Mt4_id]];        if (seletedMt4_id.length > 2) {
            //有mt4账户
     self.mt4Have = YES;

            __weak typeof(self) weakSelf = self;
            Reachability *reachability = [Reachability reachabilityWithHostName:@"www.baidu.com"];
            if ([reachability currentReachabilityStatus] == NotReachable) {
                self.tableView.ly_emptyView = self.noNetView;
                [self.tableView ly_endLoading];
                [LxDelayed delayedTime:1 withActionBlock:^{
                    [weakSelf checkNetWork];
                }];
                
            }else{
                
                self.tableView.mj_header = [LxResfreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(downLoad)];
                [self.tableView.mj_header beginRefreshing];
                
            }
        }else{
            //没有mt4账户
            //跳转账户管理
            self.mt4Have = NO;
            MyTipAlert *alert = [[MyTipAlert alloc] initWithTipAlertWithTitle:@"您当前没有选中mt4账户" contentStr:@"是否跳转添加" btnStr:@"确定"];
            alert.clickBlock = ^(int index) {
                if (index == 0) {
                    [self gotoVC];
                    
                }else{
                    [MainTabBarController shareMainTabBarController].selectedIndex = 0;
                }
            };
            [alert show];
            return;
            
        }
    }
    
 
}

- (void)downLoad
{
    [self loadsubData];
}

- (LYEmptyView *)subNodataView
{
    if (_subNodataView == nil) {
        _subNodataView = [LxEmptyView emptyActionViewWithImage:[UIImage imageNamed:@"空界面icon"] titleStr:@"" detailStr:@"当前没有自选产品，可去往行情中心添加感兴趣的产品" btnTitleStr:@"前往行情中心" btnClickBlock:^{
            
            [MainTabBarController shareMainTabBarController].selectedIndex = 0;
            
        }];
        _subNodataView.actionBtnTitleColor = [MyColor colorWithHexString:@"#F29360"];
        _subNodataView.actionBtnBorderColor = [MyColor colorWithHexString:@"#F29360"];
        _subNodataView.actionBtnBorderWidth = 1;
        _subNodataView.detailLabMaxLines = 2;
    }
    
    return _subNodataView;
    
}

- (void)loadsubData
{
    
    self.tableView.ly_emptyView = self.subNodataView;
    BADataEntity *entity = [BADataEntity new];
    entity.urlString = [NSString stringWithFormat:@"%@%@",MainUrl,Url_userAction];
    entity.needCache = NO;
    entity.parameters = @{@"types":@"8",@"userid":@"",@"mt4_id":[LxUserDefaults objectForKey:Mt4_id]};
    
    [BANetManager ba_request_POSTWithEntity:entity successBlock:^(id response) {
        NSDictionary *result = response;
        if ([result[@"code"] intValue] == 1) {
            //成功
            self.dataList = [ProductModel mj_objectArrayWithKeyValuesArray:result[@"data"]];
            
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
    return 24;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    ProductModel *model = self.dataList[indexPath.row];
    DetailQuotationVC *vc = [[DetailQuotationVC alloc] init];
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
