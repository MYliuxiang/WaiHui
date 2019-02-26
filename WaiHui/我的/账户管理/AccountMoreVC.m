//
//  AccountMoreVC.m
//  WaiHui
//
//  Created by liuxiang on 2018/12/14.
//  Copyright © 2018年 faxian. All rights reserved.
//

#import "AccountMoreVC.h"

@interface AccountMoreVC ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) NSArray *dataList;

@end

@implementation AccountMoreVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"账户设置";
    if (self.type == 0) {
        self.dataList = @[@"杠杆调整",@"重置密码",@"模拟入金"];
    }else{
        self.dataList = @[@"杠杆调整",@"重置密码",@"出入金"];
    }
    
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifire];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifire];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 47.5, kScreenWidth, .5)];
        view.backgroundColor = [MyColor colorWithHexString:@"#F1F1F8"];
        [cell.contentView addSubview:view];
    }
    cell.textLabel.text = self.dataList[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.textLabel.textColor = [MyColor colorWithHexString:@"#4C5694"];
    cell.detailTextLabel.textColor = [MyColor colorWithHexString:@"#747898"];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
    //cell.detailTextLabel.text = self.titles[indexPath.row];
    
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
    return 0.1;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 10)];
    view.backgroundColor = [MyColor colorWithHexString:@"#F7F9FE"];
    return view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        //杠杆调整
        LeverAdjustmentVC *vc = [[LeverAdjustmentVC alloc] init];
        vc.model = self.model;
        [self.navigationController pushViewController:vc animated:YES];
       
    }else if (indexPath.row == 1){
        //重置密码
        if(self.type == 1){
       
            ResetPWStartVC *vc = [[ResetPWStartVC alloc] init];
            vc.mt4Str = self.model.mt4_id;
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            
            ResetPWVC *vc = [[ResetPWVC alloc] init];
            vc.model = self.model;
            [self.navigationController pushViewController:vc animated:YES];
        }
        
    }else if (indexPath.row == 2){
        //出入金"
        if (self.type == 0) {
            
            
            
            
            
            
            
            
            
        }else{
            CashInOrOutVC *vc = [[CashInOrOutVC alloc] init];
            vc.mt4Str = self.model.mt4_id;
            [self.navigationController pushViewController:vc animated:YES];
            
        }
       
    }    
    
}

- (void)cashInMoney
{
    
    if ([self.model.balance floatValue] > 1000) {
        CashToast *toast = [[CashToast alloc] initWithTitle:@"入金失败" message:@"您的模拟账户当前余额高于1000美金～"];
        [self.view showToast:toast duration:3 position:CSToastPositionCenter completion:nil];
        
        return;
    }
    BADataEntity *entity = [BADataEntity new];
    entity.urlString = [NSString stringWithFormat:@"%@%@",MainUrl,Url_MyCenter];
    entity.needCache = NO;
    entity.parameters = @{@"types":@"1",@"Access_Token":[LxUserDefaults objectForKey:Token],@"mt4_id":self.model.mt4_id,@"usdmoney":@"10000"};
    [SVProgressHUD show];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    
    [BANetManager ba_request_POSTWithEntity:entity successBlock:^(id response) {
        NSDictionary *result = response;
        if ([result[@"code"] intValue] == 1) {
            //成功
            [SVProgressHUD dismiss];
            
            MyTipAlert *alert = [[MyTipAlert alloc] initWithTipAlertWithTitle:@"入金成功" contentStr:@"您的模拟账户已经入金$10000，快去交易吧～" btnStr:@"确定"];
            alert.clickBlock = ^(int index) {
                if (index == 0) {
                    [self.navigationController popViewControllerAnimated:YES];
                }
            };
            [alert show];
            
            
            
        }else{
            
            [SVProgressHUD showErrorWithStatus:result[@"message"]];
            
        }
        
        
    } failureBlock:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:error.userInfo[@"NSDebugDescription"]];
        
        
    } progressBlock:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];
    
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
