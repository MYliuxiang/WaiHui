//
//  BankMangerVC.m
//  WaiHui
//
//  Created by liuxiang on 2018/12/14.
//  Copyright © 2018年 faxian. All rights reserved.
//

#import "BankMangerVC.h"

@interface BankMangerVC ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) BankModel *model;

@end

@implementation BankMangerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"银行卡管理";
    
    [self loadData];
    self.tableView.ly_emptyView = [LxEmptyView noNetWorkEmptyWithClickBlock:^{
        
    }];
    
}

- (void)loadData
{
    //先判断网络
    BADataEntity *entity = [BADataEntity new];
    entity.urlString = [NSString stringWithFormat:@"%@%@",MainUrl,Url_MyCenter];
    entity.needCache = NO;
    entity.parameters = @{@"types":@"10",@"Access_Token":[LxUserDefaults objectForKey:Token]};
    [SVProgressHUD show];
    [BANetManager ba_request_POSTWithEntity:entity successBlock:^(id response) {
        NSDictionary *result = response;
        if ([result[@"code"] intValue] == 1) {
            //成功
            [SVProgressHUD dismiss];
            self.model = [BankModel mj_objectWithKeyValues:result[@"data"]];
            [self.tableView reloadData];
            
            
        }else{
            
            if ([result[@"code"] intValue] == 403) {
                //登录失败
                BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:[LoginphoneVC new]];
                [self presentViewController:nav animated:YES completion:nil];
            }
            
            [SVProgressHUD showErrorWithStatus:result[@"message"]];
        }
        
        
    } failureBlock:^(NSError *error) {
        
        [SVProgressHUD showErrorWithStatus:@"网络连接失败"];
        
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
    
    if (self.model == nil) {
        return 0;
    }else{
        return 1;

    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *identifire = @"cellID";
    BankCell *cell = [tableView dequeueReusableCellWithIdentifier:identifire];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"BankCell" owner:nil options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.model = self.model;
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 48;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 10;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 10)];
    view.backgroundColor = [MyColor colorWithHexString:@"#F7F9FE"];
    return view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (self.model.auth_status == 3) {
        AddBankVC *vc = [AddBankVC new];
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        
        BankDetailVC *vc = [BankDetailVC new];
        vc.model = self.model;
        [self.navigationController pushViewController:vc animated:YES];
        
        
    }
   
  
    
    
}


@end
