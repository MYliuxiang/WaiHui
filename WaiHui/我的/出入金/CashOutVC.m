//
//  CashOutVC.m
//  WaiHui
//
//  Created by liuxiang on 2018/12/14.
//  Copyright © 2018年 faxian. All rights reserved.
//

#import "CashOutVC.h"

@interface CashOutVC ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) IBOutlet UIView *footerView;
@property (nonatomic,strong) NSArray *dataList;
@property (nonatomic,copy) NSString *bankStr;
@property (nonatomic,copy) NSString *rnbStr;
@property (nonatomic,strong) TXLimitedTextField *textField;
@property (nonatomic,strong) Mt4Account *account;
@property (weak, nonatomic) IBOutlet UIButton *doneBtn;


@property (nonatomic,assign) BOOL IsFirst;
@property (nonatomic,strong) CashOutModel *model;

@end

@implementation CashOutVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.footerView.height = 180;
    [self.doneBtn hyb_addCornerRadius:5 size:CGSizeMake(kScreenWidth - 30, 44)];
    [self loadData];
}

- (void)loadData{
    
   
    self.IsFirst = YES;

    BADataEntity *entity = [BADataEntity new];
    entity.urlString = [NSString stringWithFormat:@"%@%@",MainUrl,Url_MyCenter];
    entity.needCache = NO;
    entity.parameters = @{@"types":@"5",@"Access_Token":[LxUserDefaults objectForKey:Token]};
    [SVProgressHUD show];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];

    [BANetManager ba_request_POSTWithEntity:entity successBlock:^(id response) {
        NSDictionary *result = response;
        if ([result[@"code"] intValue] == 1) {
            //成功
            [SVProgressHUD dismiss];
            self.model = [CashOutModel mj_objectWithKeyValues:result[@"data"]];
            
            self.tableView.tableFooterView = self.footerView;
            self.dataList = @[@"MT4账户",@"出金金额",@"余额 ",@"银行账号"];
            BankInfo *info = self.model.bank_info.firstObject;
            self.bankStr = info.bank_number;
            self.rnbStr = @"0";

            if (self.mt4Str.length == 0) {
                self.account = self.model.mt4Accounts.firstObject;
                self.mt4Str = self.account.mt4_id;
                
            }else{
                for (Mt4Account *acount in self.model.mt4Accounts) {
                    if ([self.mt4Str isEqualToString:acount.mt4_id]) {
                        self.account = acount;
                    }
                }
            }
           
            [self.tableView reloadData];
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
    if (indexPath.row == 0 || indexPath.row == 3) {
        
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
        cell.textLabel.textColor = [MyColor colorWithHexString:@"#3D478B"];
        
        cell.detailTextLabel.textColor = [MyColor colorWithHexString:@"#2B2B76"];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
        if (indexPath.row == 0 ) {
            
            cell.detailTextLabel.text = self.mt4Str;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

        }else{
            cell.detailTextLabel.text = self.bankStr;
            cell.accessoryType = UITableViewCellAccessoryNone;

        }
        
        return cell;
    }else if (indexPath.row == 1){
        static NSString *identifire = @"cellID2";
        CashTextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:identifire];
        if (cell == nil) {
            cell = [[NSBundle mainBundle] loadNibNamed:@"CashTextFieldCell" owner:nil options:nil].lastObject;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
        cell.name1.text = self.dataList[indexPath.row];
        cell.nameLab2.text = @"美元";
        cell.textField.placeholder = @"入金金额";
        cell.textField.limitedSuffix = 2;
        cell.textField.limitedPrefix = 100;

        cell.textField.limitedType = TXLimitedTextFieldTypePrice;
        self.textField = cell.textField;
        [self.textField addTarget:self action:@selector(changText) forControlEvents:UIControlEventEditingChanged];
        return cell;
        
    }else{
        
        static NSString *identifire = @"cellID3";
        CashRateCell *cell = [tableView dequeueReusableCellWithIdentifier:identifire];
        if (cell == nil) {
            cell = [[NSBundle mainBundle] loadNibNamed:@"CashRateCell" owner:nil options:nil].lastObject;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
        
        cell.lab1.text = @"余额";
        cell.lab2.text = [NSString stringWithFormat:@"$%f",self.account.balanceLeft];
        cell.lab3.text = @"折算为";
        cell.lab4.text = self.rnbStr;
        cell.lab5.text = @"元人民币";
        
        return cell;
        
    }
    
}

- (void)changText
{
    
    
    self.rnbStr = [NSString stringWithFormat:@"%.2f",[self.textField.text floatValue] * [self.model.rate floatValue]];
    [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:2 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 48;
    
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
    if (indexPath.row == 0) {
        
        NSMutableArray *marray = [NSMutableArray array];
        for (Mt4Account *model in self.model.mt4Accounts) {
            [marray addObject:model.mt4_id];
        }
        
        NSArray *dataList = marray;
        TableViewAlert *alert = [[TableViewAlert alloc] initTableViewAlertWithTitle:@"选择账户" withDatasource:dataList];
        alert.clickBlock = ^(int index) {
            
            self.mt4Str = dataList[index];
            self.account = self.model.mt4Accounts[index];
            [self.tableView reloadData];
        };
        [alert show];
    }
    
    
}

- (IBAction)doneAC:(id)sender {
    
    
    if (self.textField.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入入金金额"];
        return;
    }
    
    if ([self.textField.text floatValue] > self.account.balanceLeft) {
        [SVProgressHUD showErrorWithStatus:@"金额超出范围"];
        return;
    }
    
   
    BADataEntity *entity = [BADataEntity new];
    entity.urlString = [NSString stringWithFormat:@"%@%@",MainUrl,Url_MyCenter];
    entity.needCache = NO;
    entity.parameters = @{@"types":@"9",@"Access_Token":[LxUserDefaults objectForKey:Token],@"usdmoney":self.textField.text,@"mt4_id":self.account.mt4_id,@"cnymoney":self.rnbStr};
    [SVProgressHUD show];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    
    [BANetManager ba_request_POSTWithEntity:entity successBlock:^(id response) {
        NSDictionary *result = response;
        if ([result[@"code"] intValue] == 1) {
            //成功
            [SVProgressHUD dismiss];
            [SVProgressHUD showSuccessWithStatus:@"成功"];
            [SVProgressHUD dismissWithCompletion:^{
                self.IsFirst = NO;
                [self loadData];
            }];
          
            
        }else{
            
            [SVProgressHUD showErrorWithStatus:result[@"message"]];
            
        }
        
        
    } failureBlock:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:error.userInfo[@"NSDebugDescription"]];
        
        
    } progressBlock:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];
    
    
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




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
