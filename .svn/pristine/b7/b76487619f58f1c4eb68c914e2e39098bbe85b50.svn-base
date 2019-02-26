//
//  AddMt4VC.m
//  WaiHui
//
//  Created by liuxiang on 2018/12/17.
//  Copyright © 2018年 faxian. All rights reserved.
//

#import "AddMt4VC.h"

@interface AddMt4VC ()

@property (nonatomic,strong) NSArray *dataList;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (copy,nonatomic) NSString *accoutType;
@property (copy,nonatomic) NSString *timeStr;


@property (weak, nonatomic) IBOutlet UIButton *doneBtn;
@property (nonatomic,strong) NSDictionary *dataDic;

@end

@implementation AddMt4VC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.dataList = @[@"账号类型",@"账号杠杆"];
    self.accoutType = @"标准STP账户";
    self.timeStr = @"1:100";
    self.title = @"新建MT4账户";
    [self.doneBtn hyb_addCornerRadius:5 size:CGSizeMake(kScreenWidth - 30, 44)];
    
    [self loadData];
}

- (void)loadData
{
    BADataEntity *entity = [BADataEntity new];
    entity.urlString = [NSString stringWithFormat:@"%@%@",MainUrl,Url_MyCenter];
    entity.needCache = NO;
    entity.parameters = @{@"types":@"21",@"Access_Token":[LxUserDefaults objectForKey:Token]};
    [SVProgressHUD show];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [BANetManager ba_request_POSTWithEntity:entity successBlock:^(id response) {
        NSDictionary *result = response;
        if ([result[@"code"] intValue] == 1) {
            //成功
            [SVProgressHUD dismiss];
            self.dataDic = result[@"data"][@"list"];
            [self handleData];
            
        }else{
            
            [SVProgressHUD showErrorWithStatus:result[@"message"]];
            
        }
        
        
    } failureBlock:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:error.userInfo[@"NSDebugDescription"]];
        
    } progressBlock:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];
}

- (void)handleData
{
    if (self.type == FictitiousAccount) {
        self.accoutType = @"模拟微型账户";
        
        NSMutableArray *marray = [NSMutableArray array];
        
            for (NSString *str in _dataDic[@"M1"]) {
                NSString *leverStr = [NSString stringWithFormat:@"1:%@",str];
                [marray addObject:leverStr];
            }
        self.timeStr = marray.firstObject;
        
        
    }else{
        self.accoutType = @"标准账户";
        NSMutableArray *marray = [NSMutableArray array];
        
        for (NSString *str in _dataDic[@"M2"]) {
            NSString *leverStr = [NSString stringWithFormat:@"1:%@",str];
            [marray addObject:leverStr];
        }
        self.timeStr = marray.firstObject;
        
    }
    [self.tableView reloadData];
    
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
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 47.5, kScreenWidth, .5)];
        view.backgroundColor = [MyColor colorWithHexString:@"#F1F1F8"];
        [cell.contentView addSubview:view];
        
    }
    
    cell.textLabel.text = self.dataList[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.textLabel.textColor = [MyColor colorWithHexString:@"#4C5694"];
    
    cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
    //    cell.detailTextLabel.text = self.titles[indexPath.row];
    if(indexPath.row == 0){
        cell.detailTextLabel.textColor = [MyColor colorWithHexString:@"#9995B0"];
        cell.detailTextLabel.text = self.accoutType;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    }else{
        
        cell.detailTextLabel.text = self.timeStr;
        cell.detailTextLabel.textColor = [MyColor colorWithHexString:@"#9995B0"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
    }
    
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
        //账号类型
        NSArray *array;
        if (self.type == FictitiousAccount) {
            array = @[@"模拟微型账户",@"模拟标准账户"];

        }else{
           array = @[@"标准账户",@"微型账户",@"ECN账户"];
        }
        TableViewAlert *alert = [[TableViewAlert alloc] initTableViewAlertWithTitle:@"选择账户类型" withDatasource:array];
        alert.clickBlock = ^(int index) {
            
            self.accoutType = array[index];
            [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            
        };
        [alert show];
        
    }else{
        //账号杠杆
        NSMutableArray *marray = [NSMutableArray array];
        if ([self.accoutType isEqualToString:@"模拟微型账户"]) {
            
            for (NSString *str in _dataDic[@"M1"]) {
                NSString *leverStr = [NSString stringWithFormat:@"1:%@",str];
                [marray addObject:leverStr];
            }
            
        }else if ([self.accoutType isEqualToString:@"模拟标准账户"]){
            for (NSString *str in _dataDic[@"M12"]) {
                NSString *leverStr = [NSString stringWithFormat:@"1:%@",str];
                [marray addObject:leverStr];
            }
            
        }else if ([self.accoutType isEqualToString:@"标准账户"]){
            
            for (NSString *str in _dataDic[@"M2"]) {
                NSString *leverStr = [NSString stringWithFormat:@"1:%@",str];
                [marray addObject:leverStr];
            }
        }else if ([self.accoutType isEqualToString:@"微型账户"]){
            for (NSString *str in _dataDic[@"M3"]) {
                NSString *leverStr = [NSString stringWithFormat:@"1:%@",str];
                [marray addObject:leverStr];
            }
            
        }else{
            for (NSString *str in _dataDic[@"M4"]) {
                NSString *leverStr = [NSString stringWithFormat:@"1:%@",str];
                [marray addObject:leverStr];
            }
            
        }
        TableViewAlert *alert = [[TableViewAlert alloc] initTableViewAlertWithTitle:@"选择账户杠杆" withDatasource:marray];
        alert.clickBlock = ^(int index) {
            
            self.timeStr = marray[index];
            [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        };
        [alert show];
        
    }
    
    
    
}


- (IBAction)doneAC:(id)sender {
    
    if (self.type == FictitiousAccount) {
        BADataEntity *entity = [BADataEntity new];
        entity.urlString = [NSString stringWithFormat:@"%@%@",MainUrl,Url_userAction];
        entity.needCache = NO;
        
        NSString *userType;
        if ([self.accoutType isEqualToString:@"模拟微型账户"]) {
            
            userType = @"1";
            
        }else if ([self.accoutType isEqualToString:@"模拟标准账户"]){
            
            userType = @"12";

        }else if ([self.accoutType isEqualToString:@"标准账户"]){
            
            userType = @"2";

        }else if ([self.accoutType isEqualToString:@"微型账户"]){
           
            userType = @"3";

        }else{
            userType = @"4";

            
        }
        
        entity.parameters = @{@"types":@"23",@"Access_Token":[LxUserDefaults objectForKey:Token],@"leverage":[self.timeStr substringFromIndex:2],@"user_type":userType};
        [SVProgressHUD show];
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
        
        [BANetManager ba_request_POSTWithEntity:entity successBlock:^(id response) {
            NSDictionary *result = response;
            if ([result[@"code"] intValue] == 1) {
                //成功
                [SVProgressHUD dismiss];
                SucessAddMt4VC *vc = [SucessAddMt4VC new];
                vc.mt4Id = result[@"data"][@"mt4_id"];
                vc.pw = result[@"data"][@"mt4_password"];
                vc.fwq = result[@"data"][@"server"];
                [self.navigationController pushViewController:vc animated: YES];
            }else{
                
                [SVProgressHUD showErrorWithStatus:result[@"message"]];
                
            }
            
            
        } failureBlock:^(NSError *error) {
            [SVProgressHUD showErrorWithStatus:error.userInfo[@"NSDebugDescription"]];
            
        } progressBlock:^(int64_t bytesProgress, int64_t totalBytesProgress) {
            
        }];
    }else{
        BADataEntity *entity = [BADataEntity new];
        entity.urlString = [NSString stringWithFormat:@"%@%@",MainUrl,Url_MyCenter];
        entity.needCache = NO;
        
        NSString *userType;
        if ([self.accoutType isEqualToString:@"模拟微型账户"]) {
            
            userType = @"1";
            
        }else if ([self.accoutType isEqualToString:@"模拟标准账户"]){
            
            userType = @"12";
            
        }else if ([self.accoutType isEqualToString:@"标准账户"]){
            
            userType = @"2";
            
        }else if ([self.accoutType isEqualToString:@"微型账户"]){
            
            userType = @"3";
            
        }else{
            userType = @"4";
            
            
        }
        
        entity.parameters = @{@"types":@"4",@"Access_Token":[LxUserDefaults objectForKey:Token],@"leverage":[self.timeStr substringFromIndex:2],@"type":userType};
        [SVProgressHUD show];
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
        
        [BANetManager ba_request_POSTWithEntity:entity successBlock:^(id response) {
            NSDictionary *result = response;
            if ([result[@"code"] intValue] == 1) {
                //成功
                [SVProgressHUD dismiss];
                SucessAddMt4VC *vc = [SucessAddMt4VC new];
                vc.mt4Id = result[@"data"][@"mt4_id"];
                vc.pw = result[@"data"][@"mt4_password"];
                vc.fwq = result[@"data"][@"server"];
                [self.navigationController pushViewController:vc animated: YES];
            }else{
                
                [SVProgressHUD showErrorWithStatus:result[@"message"]];
                
            }
            
            
        } failureBlock:^(NSError *error) {
            [SVProgressHUD showErrorWithStatus:error.userInfo[@"NSDebugDescription"]];
            
        } progressBlock:^(int64_t bytesProgress, int64_t totalBytesProgress) {
            
        }];
        
        
    }
    
    
    
    
}


@end
