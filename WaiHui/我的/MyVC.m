//
//  MyVC.m
//  WaiHui
//
//  Created by liuxiang on 2018/12/6.
//  Copyright © 2018年 faxian. All rights reserved.
//

#import "MyVC.h"
#import "BANetManagerCache.h"

@interface MyVC ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIView *headerV;
@property (nonatomic,strong) NSArray *dataList;
@property (weak, nonatomic) IBOutlet UIButton *realName;
@property (weak, nonatomic) IBOutlet UIImageView *avatorImg;
@property (weak, nonatomic) IBOutlet UIButton *nameBtn;
@property (weak, nonatomic) IBOutlet UIView *rezhenView;
@property (weak, nonatomic) IBOutlet UIImageView *renzhenImg;
@property (weak, nonatomic) IBOutlet UILabel *renzhenLab;

@property (weak, nonatomic) IBOutlet UIView *loginView;



@property (nonatomic,assign) BOOL isFisrst;
@property (nonatomic,strong) MyModel *model;


@end

@implementation MyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"我的";
    self.fd_prefersNavigationBarHidden = YES;
    [self.realName hyb_addCornerRadius:10.5];
    [self.avatorImg hyb_addCornerRadius:22];
    self.headerV.height = kScreenWidth / 375 * 139;
    self.tableView.tableHeaderView = self.headerV;

    self.isFisrst = YES;
    
}

- (IBAction)noLoginAC:(id)sender {
    
    BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:[LoginphoneVC new]];
    [self.navigationController presentViewController:nav animated:YES completion:nil];
    
}


- (IBAction)tapnameAC:(id)sender {
    
    PersonalVC *vc = [PersonalVC new];
    vc.model = self.model;
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (IBAction)avatorAC:(id)sender {
    
    if (![LxUserDefaults boolForKey:IsLogin]) {
        BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:[LoginphoneVC new]];
        [self.navigationController presentViewController:nav animated:YES completion:nil];
        return;
    }
    
    PersonalVC *vc = [PersonalVC new];
    vc.model = self.model;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if(![LxUserDefaults boolForKey:IsLogin]){
        
        self.loginView.hidden = NO;
        self.realName.hidden = YES;
        self.rezhenView.hidden = YES;
        self.nameBtn.hidden = YES;
        self.avatorImg.image = [UIImage imageNamed:@"默认头像"];
        self.tableView.tableHeaderView = self.headerV;
        self.dataList = @[@[@"联系我们",@"设置"]];
        [self.tableView reloadData];
        
    }else{
        
        self.dataList = @[@[@"账户管理",@"银行卡管理",@"出入/金",@"安全管理"],@[@"联系我们",@"设置"]];
        self.loginView.hidden = YES;
        self.realName.hidden = YES;
        self.nameBtn.hidden = YES;
        self.rezhenView.hidden = YES;
        [self loadData];

    }
    
}

- (void)loadData
{

    BADataEntity *entity = [BADataEntity new];
    entity.urlString = [NSString stringWithFormat:@"%@%@",MainUrl,Url_MyCenter];
    entity.needCache = YES;
    entity.parameters = @{@"types":@"1",@"Access_Token":[LxUserDefaults objectForKey:Token]};
    
    if(self.isFisrst){
        [SVProgressHUD show];
    }
    [BANetManager ba_request_POSTWithEntity:entity successBlock:^(id response) {
        NSDictionary *result = response;
        if ([result[@"code"] intValue] == 1) {
            //成功
            [SVProgressHUD dismiss];
            if (self.isFisrst) {
                //第一次网络请求
               
                self.isFisrst = NO;
            }
            self.dataList = @[@[@"账户管理",@"银行卡管理",@"出入/金",@"安全管理"],@[@"联系我们",@"设置"]];
             self.model = [MyModel mj_objectWithKeyValues:result[@"data"]];
            [LxUserDefaults setInteger:self.model.id_card_status forKey:Id_Card_Status];
            [LxUserDefaults setObject:self.model.email forKey:Email];
            [LxUserDefaults setObject:self.model.phone forKey:Phone];

            [LxUserDefaults setInteger:self.model.bank_status forKey:Bank_status];
            [LxUserDefaults synchronize];

            if (self.model.id_card_status == 0) {
                 //审核中
//                [self.realName setTitle:@"审核中" forState:UIControlStateNormal];
                self.renzhenImg.image = [UIImage imageNamed:@"in review"];
                self.renzhenLab.text = @"审核中";
                self.renzhenLab.textColor = [MyColor colorWithHexString:@"#F29360"];
                self.realName.hidden = YES;
                self.rezhenView.hidden = NO;
                
            }else if(self.model.id_card_status == 1){
                
                //审核成功
                self.renzhenImg.image = [UIImage imageNamed:@"renzhen"];
                self.renzhenLab.text = @"已认证";
                self.renzhenLab.textColor = [MyColor colorWithHexString:@"#9F9FB8"];
                self.realName.hidden = YES;
                self.rezhenView.hidden = NO;
            
            }else if(self.model.id_card_status == 2){
                //审核失败
                [self.realName setTitle:@"重新认证" forState:UIControlStateNormal];
                self.realName.hidden = NO;
                self.rezhenView.hidden = YES;
                
            }else{
                
                //未认证
                [self.realName setTitle:@"去认证" forState:UIControlStateNormal];
                self.realName.hidden = NO;
                self.rezhenView.hidden = YES;
            }
            self.nameBtn.hidden = NO;
            [self.avatorImg sd_setImageWithURL:[NSURL URLWithString:self.model.face_img] placeholderImage:[UIImage imageNamed:@"默认头像"]];
            [self.nameBtn setTitle:self.model.username forState:UIControlStateNormal];
            [self.nameBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:5];
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
        
  [SVProgressHUD showErrorWithStatus:error.userInfo[@"NSDebugDescription"]];
    } progressBlock:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];
    
}




#pragma  mark --------UITableView Delegete----------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *array = self.dataList[section];
    return array.count;
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
    
    cell.textLabel.text = self.dataList[indexPath.section][indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.textLabel.textColor = [MyColor colorWithHexString:@"#3D478B"];
    
    cell.detailTextLabel.textColor = [MyColor colorWithHexString:@"#F29360"];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
    if ([LxUserDefaults boolForKey:IsLogin]) {
        
        if (indexPath.row == 0 && indexPath.section == 0) {
            
            if(self.model.mt4_id == 0){
                cell.detailTextLabel.text = @"未开通真实账户";

            }else{
                cell.detailTextLabel.text = @"";

            }
                        
        }else if(indexPath.row == 1 && indexPath.section == 0){
            if (self.model.bank_status == 0) {
                cell.detailTextLabel.text = @"审核中";
            }else if(self.model.bank_status == 1){
                cell.detailTextLabel.text = @"";
            }else if(self.model.bank_status == 2){
                cell.detailTextLabel.text = @"审核不通过";
            }else{
                cell.detailTextLabel.text = @"未绑定";
            }
        }else{
            cell.detailTextLabel.text = @"";
            
        }
    }else{
        cell.detailTextLabel.text = @"";
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
    
    
    if(![LxUserDefaults boolForKey:IsLogin]){
        if (indexPath.row == 0) {
            //联系我们
            ContactUsVC *vc = [[ContactUsVC alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            //设置
            SetVC *vc = [[SetVC alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
        return;
    }
    
    if (indexPath.section == 0) {
        
        if (indexPath.row == 0) {
            //账户管理
            [self gotoAccountVC];
         
        }else if(indexPath.row == 1){
           
            if (self.model.bank_status == 3) {
                //银行卡管理
                if (self.model.phone.length == 0 || self.model.email == 0) {
                    MyTipAlert *alert = [[MyTipAlert alloc] initWithTipAlertWithTitle:@"个人信息提示" contentStr:@"您的个人信息尚未完善，请先完善个人信息" btnStr:@"马上完善"];
                    alert.clickBlock = ^(int index) {
                        if (index == 0) {
                        SafeMangerVC *vc = [[SafeMangerVC alloc] init];
                        [self.navigationController pushViewController:vc animated:YES];
                        }
                    };
                    [alert show];
                    return;
                }
                
                if (self.model.id_card_status == 3) {
                    MyTipAlert *alert = [[MyTipAlert alloc] initWithTipAlertWithTitle:@"身份认证提示" contentStr:@"您的身份信息尚未认证，请先完成认证！" btnStr:@"马上认证"];
                    alert.clickBlock = ^(int index) {
                        if (index == 0) {
                            RealNameVC *vc = [RealNameVC new];
                            [self.navigationController pushViewController:vc animated:YES];
                        }
                    };
                    [alert show];
                    return;
                }
                
                if (self.model.id_card_status == 2) {
                    MyTipAlert *alert = [[MyTipAlert alloc] initWithTipAlertWithTitle:@"身份认证提示" contentStr:@"您的身份证信息认证失败，请您重新上传证件信息！" btnStr:@"重新认证"];
                    alert.clickBlock = ^(int index) {
                        if (index == 0) {
                        RealNameVC *vc = [RealNameVC new];
                        [self.navigationController pushViewController:vc animated:YES];
                        }
                    };
                    [alert show];
                    return;
                }
                
                if (self.model.id_card_status == 0) {
                    MyTipAlert *alert = [[MyTipAlert alloc] initWithTipAlertWithTitle:@"身份认证提示" contentStr:@"您的身份证信息正在审核中，审核完成后即可开立MT4交易账户并入金交易～" btnStr:@"确认"];
                    alert.clickBlock = ^(int index) {
                        
                    };
                    [alert show];
                    return;
                }
                
                AddBankVC *vc = [[AddBankVC alloc] init];
                [self.navigationController pushViewController:vc animated:YES];
               
            }else{
                
                BankMangerVC *vc = [[BankMangerVC alloc] init];
                [self.navigationController pushViewController:vc animated:YES];
            }
            
          
        }else if(indexPath.row == 2){
            
            if (self.model.phone.length == 0 || self.model.email == 0) {
                MyTipAlert *alert = [[MyTipAlert alloc] initWithTipAlertWithTitle:@"个人信息提示" contentStr:@"您的个人信息尚未完善，请先完善个人信息" btnStr:@"马上完善"];
                alert.clickBlock = ^(int index) {
                    if (index == 0) {
                    SafeMangerVC *vc = [[SafeMangerVC alloc] init];
                    [self.navigationController pushViewController:vc animated:YES];
                    }
                };
                [alert show];
                return;
            }
            
            if (self.model.id_card_status == 3) {
                MyTipAlert *alert = [[MyTipAlert alloc] initWithTipAlertWithTitle:@"身份认证提示" contentStr:@"您的身份信息尚未认证，请先完成认证！" btnStr:@"马上认证"];
                alert.clickBlock = ^(int index) {
                    
                    if (index == 0) {
                    RealNameVC *vc = [RealNameVC new];
                    [self.navigationController pushViewController:vc animated:YES];
                    }
                    
                };
                [alert show];
                return;
            }
            if (self.model.mt4_id == 0) {
                MyTipAlert *alert = [[MyTipAlert alloc] initWithTipAlertWithTitle:@"账户管理提示" contentStr:@"您的尚未开通账户，请先开通账户" btnStr:@"马上开通"];
                alert.clickBlock = ^(int index) {
                    if (index == 0) {
                        [self gotoAccountVC];
                    }
                };
                [alert show];
                return;
            }
            
            
            //出入金
            CashInOrOutVC *vc = [[CashInOrOutVC alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            
            SafeMangerVC *vc = [[SafeMangerVC alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
        
    }else{
        
        if (indexPath.row == 0) {
            //联系我们
            ContactUsVC *vc = [[ContactUsVC alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            //设置
            SetVC *vc = [[SetVC alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
    
}

- (void)gotoAccountVC
{
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
            NSArray *array = [Mt4Model mj_objectArrayWithKeyValuesArray:result[@"data"][@"list"]];
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


- (IBAction)realnameAC:(id)sender {
    
    if(self.model.phone.length == 0 || self.model.email.length == 0 ){
        
        MyTipAlert *alert = [[MyTipAlert alloc] initWithTipAlertWithTitle:@"身份认证提示" contentStr:@"您的身份信息尚未认证，请先完成认证！" btnStr:@"马上认证"];
        alert.clickBlock = ^(int index) {
            if (index == 0) {
            SafeMangerVC *vc = [[SafeMangerVC alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            }
        };
        [alert show];
        return;
    }
    
    RealNameVC *vc = [RealNameVC new];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
