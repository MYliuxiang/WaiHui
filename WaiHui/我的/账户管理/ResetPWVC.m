//
//  ResetPWVC.m
//  WaiHui
//
//  Created by liuxiang on 2018/12/14.
//  Copyright © 2018年 faxian. All rights reserved.
//

#import "ResetPWVC.h"

@interface ResetPWVC ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) NSArray *dataList;
@property (nonatomic,strong) NSArray *placeholders;
@property (strong, nonatomic) IBOutlet UIView *footerView;

@property (weak, nonatomic) IBOutlet UIButton *doneBtn;

@property (nonatomic, strong) TXLimitedTextField *onePwField;
@property (nonatomic, strong) TXLimitedTextField *twoField;


@end

@implementation ResetPWVC

- (IBAction)doneAC:(id)sender {
    
    if (self.onePwField.text.length == 0){
        [SVProgressHUD showErrorWithStatus:@"请输入新密码！"];
        return;
    }
    
    if (self.onePwField.text.length < 6) {
        [SVProgressHUD showErrorWithStatus:@"新密码输入错误！"];
        return;
    }
    
    if ([HandleTool checkIsHaveNumAndLetter:self.onePwField.text] == 1) {
        [SVProgressHUD showErrorWithStatus:@"新密码请输入含有大小写的英文字母"];
        return;
    }
    if([HandleTool checkIsHaveNumAndLetter:self.onePwField.text] == 2){
        [SVProgressHUD showErrorWithStatus:@"新密码不能包含特殊字母"];
        return;
    }
    if ([HandleTool checkIsHaveNumAndLetter:self.onePwField.text] == 3){
        [SVProgressHUD showErrorWithStatus:@"新密码没有包含数字"];
        return;
    }
    
    if (self.twoField.text == 0) {
        [SVProgressHUD showErrorWithStatus:@"请再次输入新密码！"];
        return;
    }
    
    if(![self.onePwField.text isEqualToString:self.twoField.text]){
        [SVProgressHUD showErrorWithStatus:@"两次密码不相同！"];
        return;
        
    }
    
    
    BADataEntity *entity = [BADataEntity new];
    entity.urlString = [NSString stringWithFormat:@"%@%@",MainUrl,Url_userAction];
    entity.needCache = NO;
    //@"Access_Token":[LxUserDefaults objectForKey:Token]
    entity.parameters = @{@"types":@"18",@"mt4_id":self.model.mt4_id,@"password":self.onePwField.text,@"qrpassword":self.twoField.text};
    [SVProgressHUD show];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    
    [BANetManager ba_request_POSTWithEntity:entity successBlock:^(id response) {
        NSDictionary *result = response;
        if ([result[@"code"] intValue] == 1) {
            //成功
            [SVProgressHUD dismiss];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            
            [SVProgressHUD showErrorWithStatus:result[@"message"]];
            
        }
        
    } failureBlock:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:error.userInfo[@"NSDebugDescription"]];
        
    } progressBlock:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"重置密码";
    self.dataList = @[@"MT4账号",@"新密码",@"确认新密码"];
    self.placeholders = @[@"",@"输入新密码",@"再次输入新密码"];
    self.footerView.height = 154 + 44 + 44;
    self.tableView.tableFooterView = self.footerView;
    [self.doneBtn hyb_addCornerRadius:5 size:CGSizeMake(kScreenWidth - 30, 44)];

    
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
    
    if (indexPath.row == 0) {
        
        static NSString *identifire = @"cellID";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifire];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifire];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.accessoryType = UITableViewCellAccessoryNone;
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 47.5, kScreenWidth, .5)];
            view.backgroundColor = [MyColor colorWithHexString:@"#F1F1F8"];
            [cell.contentView addSubview:view];
        }
        
        cell.textLabel.text = self.dataList[indexPath.row];
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.textLabel.textColor = [MyColor colorWithHexString:@"#4C5694"];
        
        cell.detailTextLabel.textColor = [MyColor colorWithHexString:@"#747898"]; 
        cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
        cell.detailTextLabel.text = self.model.mt4_id;
        
        
        return cell;
        
    }else{
        static NSString *identifire = @"cellID";
        ResetCell *cell = [tableView dequeueReusableCellWithIdentifier:identifire];
        if (cell == nil) {
            cell = [[NSBundle mainBundle] loadNibNamed:@"ResetCell" owner:nil options:nil].lastObject;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
        
        cell.titleLab.text = self.dataList[indexPath.row];
        cell.textField.placeholder = self.placeholders[indexPath.row];
        cell.textField.textAlignment = NSTextAlignmentRight;
        if (indexPath.row == 1) {
            self.onePwField = cell.textField;
            self.onePwField.limitedNumber = 16;
        }else{
            self.twoField = cell.textField;
            self.twoField.limitedNumber = 16;
            
        }
        return cell;
        
    }
    
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
