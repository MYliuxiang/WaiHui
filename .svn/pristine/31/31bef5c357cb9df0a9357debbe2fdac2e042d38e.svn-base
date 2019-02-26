
//
//  ForgetPwEmailNextVC.m
//  WaiHui
//
//  Created by liuxiang on 2018/12/19.
//  Copyright © 2018年 faxian. All rights reserved.
//

#import "ForgetPwEmailNextVC.h"

@interface ForgetPwEmailNextVC ()
@property (weak, nonatomic) IBOutlet TXLimitedTextField *codeField;
@property (weak, nonatomic) IBOutlet TXLimitedTextField *pwField;
@property (weak, nonatomic) IBOutlet UILabel *pwLab;
@property (weak, nonatomic) IBOutlet UIButton *doneBtn;
@property (weak, nonatomic) IBOutlet UILabel *codeLab;

@end

@implementation ForgetPwEmailNextVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.fd_prefersNavigationBarHidden = YES;
    [self.doneBtn hyb_addCornerRadius:5 size:CGSizeMake(kScreenWidth - 60, 48)];
    self.codeField.limitedNumber = 10;
    self.codeLab.hidden = YES;
    self.pwLab.hidden = YES;

}
- (IBAction)disMissAC:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];

}
- (IBAction)doneAC:(id)sender {
    
    if (self.emailStr.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入手机号码！"];
        return;
    }
    
    if (self.codeField.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请填写验证码！"];
        return;
    }
    
    if (self.pwField.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入登录密码！"];
        return;
    }
    
    if (self.pwField.text.length < 8) {
        [SVProgressHUD showErrorWithStatus:@"您输入的密码必须大于6位字符！"];
        return;
    }
    
    /*
     返回0、1、2 3为格式不正确，返回4为密码格式正确
     0长度不正确
     1没有大写或小写
     2含有特殊字符
     3没有数字
     */
    if ([HandleTool checkIsHaveNumAndLetter:self.pwField.text] == 1) {
        [SVProgressHUD showErrorWithStatus:@"请输入含有大小写的英文字母"];
        return;
    }
    if([HandleTool checkIsHaveNumAndLetter:self.pwField.text] == 2){
        [SVProgressHUD showErrorWithStatus:@"不能包含特殊字母"];
        return;
    }
    if ([HandleTool checkIsHaveNumAndLetter:self.pwField.text] == 3){
        [SVProgressHUD showErrorWithStatus:@"没有包含数字"];
        return;
    }
    
    BADataEntity *entity = [BADataEntity new];
    entity.urlString = [NSString stringWithFormat:@"%@%@",MainUrl,Url_userAction];
    entity.needCache = NO;
    entity.parameters = @{@"types":@"15",@"email":self.emailStr,@"password":self.pwField.text,@"verify":self.codeField.text};
    [SVProgressHUD show];
    [BANetManager ba_request_POSTWithEntity:entity successBlock:^(id response) {
        NSDictionary *result = response;
        if ([result[@"code"] intValue] == 1) {
            //成功
            [SVProgressHUD dismiss];
            [self.view endEditing:YES];
            
            [LxUserDefaults setObject:self.emailStr forKey:Email];
            [LxUserDefaults synchronize];
            [self.navigationController popToViewController:self.navigationController.viewControllers[self.navigationController.viewControllers.count - 3] animated:YES];
            
        }else{
            
            [SVProgressHUD showErrorWithStatus:result[@"message"]];
        }
    } failureBlock:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"网络连接失败"];
        
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
