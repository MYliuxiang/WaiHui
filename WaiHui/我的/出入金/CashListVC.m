//
//  CashListVC.m
//  WaiHui
//
//  Created by liuxiang on 2018/12/14.
//  Copyright © 2018年 faxian. All rights reserved.
//

#import "CashListVC.h"

@interface CashListVC ()
@property (strong, nonatomic) IBOutlet UIView *sectionView;
@property (strong, nonatomic) IBOutlet UIView *demoView;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataList;
@property (nonatomic,assign) BOOL IsFirst;
@property (weak, nonatomic) IBOutlet UIButton *dayBtn;
@property (weak, nonatomic) IBOutlet UIButton *weekBtn;
@property (weak, nonatomic) IBOutlet UIButton *mothBtn;
@property (weak, nonatomic) IBOutlet UILabel *allmonetyLab;
@property (weak, nonatomic) IBOutlet UILabel *allinMoneyLab;
@property (nonatomic,copy) NSString *time;
@property (nonatomic,strong) LxEmptyView *nodataView;

@end

@implementation CashListVC

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.dayBtn.hyb_borderWidth = 0;
    self.dayBtn.hyb_borderColor = [MyColor colorWithHexString:@"#D6DCED"];
    [self.dayBtn hyb_addCornerRadius:9];
    
    self.weekBtn.hyb_borderWidth = 1;
    self.weekBtn.hyb_borderColor = [MyColor colorWithHexString:@"#D6DCED"];
    [self.weekBtn hyb_addCornerRadius:9];
    
    self.mothBtn.hyb_borderWidth = 1;
    self.mothBtn.hyb_borderColor = [MyColor colorWithHexString:@"#D6DCED"];
    [self.mothBtn hyb_addCornerRadius:9];
    

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.dataList = [NSMutableArray array];
   
    
    self.time = @"1";
    
    if ([self.time isEqualToString:@"1"]) {
        self.dayBtn.backgroundColor = [MyColor colorWithHexString:@"#435B9B"];
        self.dayBtn.titleLabel.textColor = [UIColor whiteColor];
        
        self.weekBtn.backgroundColor = [UIColor whiteColor];
        self.weekBtn.titleLabel.textColor = [MyColor colorWithHexString:@"#7D82A5"];
        
        self.mothBtn.backgroundColor = [UIColor whiteColor];
        self.mothBtn.titleLabel.textColor = [MyColor colorWithHexString:@"#7D82A5"];
    }
    
    self.tableView.ly_emptyView = [LxEmptyView noDataEmptyWith:@"暂无交易记录"];
    
    
    self.tableView.mj_header = [LxResfreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(downLoad)];
    
    self.tableView.mj_footer = [LxRefreshFooter footerWithRefreshingTarget:self refreshingAction:@selector(upLoad)];
    [self.tableView.mj_header beginRefreshing];

}

- (void)downLoad
{
    self.pageOffset = 1;
    [self loadsubData];
}

- (void)upLoad
{
    [self loadsubData];
}

- (void)loadsubData
{
    BADataEntity *entity = [BADataEntity new];
    entity.urlString = [NSString stringWithFormat:@"%@%@",MainUrl,Url_MyCenter];
    entity.needCache = NO;
    entity.parameters = @{@"types":@"6",@"Access_Token":[LxUserDefaults objectForKey:Token],@"time":self.time,@"pageSize":@"20",@"page":[NSString stringWithFormat:@"%d",self.pageOffset]};
    [SVProgressHUD show];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    
    [BANetManager ba_request_POSTWithEntity:entity successBlock:^(id response) {
        NSDictionary *result = response;
        if ([result[@"code"] intValue] == 1) {
            //成功
            [SVProgressHUD dismiss];
            
            NSArray *array = [CashListModel mj_objectArrayWithKeyValuesArray:result[@"data"][@"list"]];
            if (self.pageOffset == 1) {
                [self.dataList removeAllObjects];
                [self.dataList addObjectsFromArray:array];
            }else{
                [self.dataList addObjectsFromArray:array];
            }
            self.pageOffset++;
            
            self.allinMoneyLab.text = [NSString stringWithFormat:@"总入金：%@",result[@"data"][@"sumDeposit"]];;
            self.allmonetyLab.text = [NSString stringWithFormat:@"$%@",result[@"data"][@"sumDeposit"]];
            [self.tableView reloadData];

            [self.tableView.mj_footer endRefreshing];
            [self.tableView.mj_header endRefreshing];
            [self.tableView ly_endLoading];
            
        }else{
            
            [SVProgressHUD showErrorWithStatus:result[@"message"]];
            [self.tableView.mj_footer endRefreshing];
            [self.tableView.mj_header endRefreshing];
            [self.tableView ly_endLoading];

        }
        
        
    } failureBlock:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:error.userInfo[@"NSDebugDescription"]];
        [self.tableView.mj_footer endRefreshing];
        [self.tableView.mj_header endRefreshing];
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
    CashListCell *cell = [tableView dequeueReusableCellWithIdentifier:identifire];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CashListCell" owner:nil options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.model = self.dataList[indexPath.row];
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 48;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 40;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor redColor];
    return self.demoView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
}


- (IBAction)dayAC:(id)sender {
    
    self.time = @"1";
    self.dayBtn.backgroundColor = [MyColor colorWithHexString:@"#435B9B"];
    self.dayBtn.titleLabel.textColor = [UIColor whiteColor];
    
    self.weekBtn.backgroundColor = [UIColor whiteColor];
    self.weekBtn.titleLabel.textColor = [MyColor colorWithHexString:@"#7D82A5"];
    
    self.mothBtn.backgroundColor = [UIColor whiteColor];
    self.mothBtn.titleLabel.textColor = [MyColor colorWithHexString:@"#7D82A5"];
    [self.tableView.mj_header beginRefreshing];
    
    self.dayBtn.hyb_borderWidth = 0;
    self.dayBtn.hyb_borderColor = [MyColor colorWithHexString:@"#D6DCED"];
    [self.dayBtn hyb_addCornerRadius:9];
    
    self.weekBtn.hyb_borderWidth = 1;
    self.weekBtn.hyb_borderColor = [MyColor colorWithHexString:@"#D6DCED"];
    [self.weekBtn hyb_addCornerRadius:9];
    
    self.mothBtn.hyb_borderWidth = 1;
    self.mothBtn.hyb_borderColor = [MyColor colorWithHexString:@"#D6DCED"];
    [self.mothBtn hyb_addCornerRadius:9];
}

- (IBAction)weekAC:(id)sender {
    
    self.time = @"7";
    self.dayBtn.backgroundColor = [UIColor whiteColor];
    self.dayBtn.titleLabel.textColor = [MyColor colorWithHexString:@"#7D82A5"];
    
    self.weekBtn.backgroundColor = [MyColor colorWithHexString:@"#435B9B"];
    self.weekBtn.titleLabel.textColor = [UIColor whiteColor];
    
    self.mothBtn.backgroundColor = [UIColor whiteColor];
    self.mothBtn.titleLabel.textColor = [MyColor colorWithHexString:@"#7D82A5"];
    [self.tableView.mj_header beginRefreshing];
    
    
    self.dayBtn.hyb_borderWidth = 1;
    self.dayBtn.hyb_borderColor = [MyColor colorWithHexString:@"#D6DCED"];
    [self.dayBtn hyb_addCornerRadius:9];
    
    self.weekBtn.hyb_borderWidth = 0;
    self.weekBtn.hyb_borderColor = [MyColor colorWithHexString:@"#D6DCED"];
    [self.weekBtn hyb_addCornerRadius:9];
    
    self.mothBtn.hyb_borderWidth = 1;
    self.mothBtn.hyb_borderColor = [MyColor colorWithHexString:@"#D6DCED"];
    [self.mothBtn hyb_addCornerRadius:9];

}

- (IBAction)mothAC:(id)sender {
    
    self.time = @"30";
    self.dayBtn.backgroundColor = [UIColor whiteColor];
    self.dayBtn.titleLabel.textColor = [MyColor colorWithHexString:@"#7D82A5"];
    
    self.weekBtn.backgroundColor = [UIColor whiteColor];
    self.weekBtn.titleLabel.textColor = [MyColor colorWithHexString:@"#7D82A5"];
    
    self.mothBtn.backgroundColor = [MyColor colorWithHexString:@"#435B9B"];
    self.mothBtn.titleLabel.textColor = [UIColor whiteColor];
    [self.tableView.mj_header beginRefreshing];
    
    self.dayBtn.hyb_borderWidth = 1;
    self.dayBtn.hyb_borderColor = [MyColor colorWithHexString:@"#D6DCED"];
    [self.dayBtn hyb_addCornerRadius:9];
    
    self.weekBtn.hyb_borderWidth = 1;
    self.weekBtn.hyb_borderColor = [MyColor colorWithHexString:@"#D6DCED"];
    [self.weekBtn hyb_addCornerRadius:9];
    
    self.mothBtn.hyb_borderWidth = 0;
    self.mothBtn.hyb_borderColor = [MyColor colorWithHexString:@"#D6DCED"];
    [self.mothBtn hyb_addCornerRadius:9];

}

#pragma mark - JXCategoryListContentViewDelegate
- (UIView *)listView {
    return self.view;
}

- (void)listDidAppear {
    NSLog(@"%@", NSStringFromSelector(_cmd));
   
}

- (void)listDidDisappear {
    NSLog(@"%@", NSStringFromSelector(_cmd));
    
}


@end
