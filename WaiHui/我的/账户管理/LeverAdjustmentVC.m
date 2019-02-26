//
//  LeverAdjustmentVC.m
//  WaiHui
//
//  Created by liuxiang on 2018/12/14.
//  Copyright © 2018年 faxian. All rights reserved.
//

#import "LeverAdjustmentVC.h"

@interface LeverAdjustmentVC ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) NSArray *dataList;
@property (nonatomic,copy) NSString *leverStr;
@property (nonatomic,strong) NSDictionary *dataDic;


@end

@implementation LeverAdjustmentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"杠杆调整";
    self.dataList = @[@"账号类型",@"账号杠杆"];
    self.leverStr = self.model.leverage;
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
            
        }else{
            
            [SVProgressHUD showErrorWithStatus:result[@"message"]];
            
        }
        
        
    } failureBlock:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:error.userInfo[@"NSDebugDescription"]];
        
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
        cell.detailTextLabel.textColor = [MyColor colorWithHexString:@"#F29360"];
        if (self.model.user_type == 1) {
            cell.detailTextLabel.text = @"模拟微型账户";

        }else if (self.model.user_type == 2){
            cell.detailTextLabel.text = @"标准STP账户";

        }else if (self.model.user_type == 3){
            cell.detailTextLabel.text = @"微型账户";

        }else if (self.model.user_type == 4){
            cell.detailTextLabel.text = @"ECN账户";

        }else{
            cell.detailTextLabel.text = @"模拟标准账户";
            
        }
        
        cell.accessoryType = UITableViewCellAccessoryNone;

    }else{
        
        cell.detailTextLabel.text = [NSString stringWithFormat:@"1:%@",self.leverStr];
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

       
        
        
    }else{
        //账号杠杆
        //账号杠杆
        NSMutableArray *marray = [NSMutableArray array];
        
        NSString *typeStr = [NSString stringWithFormat:@"M%d",self.model.user_type];
            for (NSString *str in _dataDic[typeStr]) {
                NSString *leverStr = [NSString stringWithFormat:@"1:%@",str];
                [marray addObject:leverStr];
            }
      
        TableViewAlert *alert = [[TableViewAlert alloc] initTableViewAlertWithTitle:@"选择账户杠杆" withDatasource:marray];
        alert.clickBlock = ^(int index) {
            NSString *str = marray[index];
            NSString *leverStr = [str substringFromIndex:2];
            BADataEntity *entity = [BADataEntity new];
            entity.urlString = [NSString stringWithFormat:@"%@%@",MainUrl,Url_MyCenter];
            entity.needCache = NO;
            entity.parameters = @{@"types":@"12",@"Access_Token":[LxUserDefaults objectForKey:Token],@"mt4_id":self.model.mt4_id,@"user_type":[NSString stringWithFormat:@"%d",self.model.user_type],@"pry":leverStr};
            [SVProgressHUD show];
            [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
            [BANetManager ba_request_POSTWithEntity:entity successBlock:^(id response) {
                NSDictionary *result = response;
                if ([result[@"code"] intValue] == 1) {
                    //成功
                    [SVProgressHUD dismiss];
                    self.leverStr = leverStr;
                    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];

                }else{
                    
                    [SVProgressHUD showErrorWithStatus:result[@"message"]];
                    
                }
                
                
            } failureBlock:^(NSError *error) {
                [SVProgressHUD showErrorWithStatus:error.userInfo[@"NSDebugDescription"]];
                
            } progressBlock:^(int64_t bytesProgress, int64_t totalBytesProgress) {
                
            }];
            
            
        };
        [alert show];
        
    }
    
    
    
}


@end
