//
//  FillNickNameVC.m
//  WaiHui
//
//  Created by liuxiang on 2019/1/14.
//  Copyright © 2019年 faxian. All rights reserved.
//

#import "FillNickNameVC.h"

@interface FillNickNameVC ()
@property (strong, nonatomic) IBOutlet UIView *footerView;
@property (weak, nonatomic) IBOutlet UIButton *doneBtn;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) TXLimitedTextView *field;

@end

@implementation FillNickNameVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"昵称设置";
    self.footerView.height = 110 + 44 + 44;
    self.tableView.tableFooterView = self.footerView;
    [self.doneBtn hyb_addCornerRadius:5 size:CGSizeMake(kScreenWidth - 30, 44)];
}

- (IBAction)doneAC:(id)sender {
    
    if ([self.model.nickname isEqualToString:self.field.text]) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        if (self.field.text.length == 0) {
            [SVProgressHUD showErrorWithStatus:@"请输入昵称!"];
            return;
        }
        
        BADataEntity *entity = [BADataEntity new];
        entity.urlString = [NSString stringWithFormat:@"%@%@",MainUrl,Url_userAction];
        entity.needCache = NO;
        entity.parameters = @{@"types":@"21",@"Access_Token":[LxUserDefaults objectForKey:Token],@"nickname":self.field.text};
        [SVProgressHUD show];
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
        
        [BANetManager ba_request_POSTWithEntity:entity successBlock:^(id response) {
            NSDictionary *result = response;
            if ([result[@"code"] intValue] == 1) {
                //成功
                [SVProgressHUD dismiss];
                self.model.nickname = self.field.text;
                [self.navigationController popViewControllerAnimated:YES];

            }else{
                
                [SVProgressHUD showErrorWithStatus:result[@"message"]];
                
            }
            
            
        } failureBlock:^(NSError *error) {
            [SVProgressHUD showErrorWithStatus:error.userInfo[@"NSDebugDescription"]];
            
            
        } progressBlock:^(int64_t bytesProgress, int64_t totalBytesProgress) {
            
        }];
        
        
        
        
    }
    
    
}

#pragma  mark --------UITableView Delegete----------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
        static NSString *identifire = @"ResetCellID";
        ResetCell *cell = [tableView dequeueReusableCellWithIdentifier:identifire];
        if (cell == nil) {
            cell = [[NSBundle mainBundle] loadNibNamed:@"ResetCell" owner:nil options:nil].lastObject;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;

        }
    cell.textFieldConstraint.constant = 135;
    cell.titleLab.text = @"修改昵称";
    cell.textField.text = self.model.nickname;
    cell.textField.placeholder = @"请输入昵称";
    cell.textField.clearButtonMode=UITextFieldViewModeWhileEditing;
    self.field = cell.textField;
    
    
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
