//
//  RegistEmailVC.m
//  WaiHui
//
//  Created by liuxiang on 2018/12/19.
//  Copyright © 2018年 faxian. All rights reserved.
//

#import "RegistEmailVC.h"
#import "RegistSuccessVC.h"

@interface RegistEmailVC ()
@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UILabel *emailLab;
@property (weak, nonatomic) IBOutlet TXLimitedTextField *codeField;
@property (weak, nonatomic) IBOutlet UILabel *codeLab;
@property (weak, nonatomic) IBOutlet UIButton *codeBtn;
@property (weak, nonatomic) IBOutlet TXLimitedTextField *pwField;
@property (weak, nonatomic) IBOutlet UILabel *pwLab;
@property (weak, nonatomic) IBOutlet UIButton *agreeMentBtn;
@property (weak, nonatomic) IBOutlet UIImageView *agreementImg;

@property (weak, nonatomic) IBOutlet UIView *agreeMentView;
@property (weak, nonatomic) IBOutlet UIButton *doneBtn;
@property (weak, nonatomic) IBOutlet TXLimitedTextField *yaoqingField;

@end

@implementation RegistEmailVC

- (IBAction)dismissAC:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    [self.doneBtn hyb_addCornerRadius:5 size:CGSizeMake(kScreenWidth - 60, 48)];
    self.emailLab.hidden = YES;
    self.pwLab.hidden = YES;
    self.codeLab.hidden = YES;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.fd_prefersNavigationBarHidden = YES;
    [self.doneBtn hyb_addCornerRadius:5 size:CGSizeMake(kScreenWidth - 60, 48)];
    self.emailLab.hidden = YES;
    self.codeLab.hidden = YES;
    self.pwLab.hidden = YES;
    self.codeField.limitedNumber = 15;
    self.pwField.limitedNumber = 24;
    self.yaoqingField.limitedNumber = 7;



}
- (IBAction)doneAC:(id)sender {
    
    if (self.emailField.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入邮箱号！"];
        return;
    }
    
    if (![HandleTool isEmail:self.emailField.text]) {
        [SVProgressHUD showErrorWithStatus:@"邮箱号不正确！"];
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
        [SVProgressHUD showErrorWithStatus:@"您输入的密码必须大于8位字符！"];
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
    entity.parameters = @{@"types":@"20",@"email":self.emailField.text,@"password":self.pwField.text,@"email_code":self.codeField.text,@"agentnumber":self.yaoqingField.text.length==0?@"":self.yaoqingField.text};
    [SVProgressHUD show];
    [BANetManager ba_request_POSTWithEntity:entity successBlock:^(id response) {
        NSDictionary *result = response;
        if ([result[@"code"] intValue] == 1) {
            //成功
            [SVProgressHUD dismiss];
            [self.view endEditing:YES];
            FillInInfoVC *vc = [FillInInfoVC new];
            vc.reg_token = result[@"data"][@"reg_token"];
            vc.registStr = self.emailField.text;
            vc.agentnumber = self.yaoqingField.text;
            vc.password = self.pwField.text;
            vc.type = RegistTypeEmail;
            [self.navigationController pushViewController:vc animated:YES];
            
        }else{
            
            [SVProgressHUD showErrorWithStatus:result[@"message"]];
        }
    } failureBlock:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"网络连接失败"];
        
    } progressBlock:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];
    
   
}

- (IBAction)registAC:(id)sender {
    
    if ([self.navigationController.viewControllers[self.navigationController.viewControllers.count - 2] isKindOfClass:[RegistPhoneVC class]]) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        
        [self.navigationController pushViewController:[RegistPhoneVC new] animated:YES];
        
    }
}


- (IBAction)sendCodeAC:(id)sender {
    
    BADataEntity *entity = [BADataEntity new];
    entity.urlString = [NSString stringWithFormat:@"%@%@",MainUrl,Url_userAction];
    entity.needCache = NO;
    entity.parameters = @{@"types":@"16",@"email":self.emailField.text,@"template":@"2"};
    [SVProgressHUD show];
    [BANetManager ba_request_POSTWithEntity:entity successBlock:^(id response) {
        NSDictionary *result = response;
        if ([result[@"code"] intValue] == 1) {
            //成功
            [SVProgressHUD dismiss];
            [self.view endEditing:YES];
            
            [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(repeat:) userInfo:nil repeats:YES];

            
        }else{
            
            [SVProgressHUD showErrorWithStatus:result[@"message"]];
        }
    } failureBlock:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"网络连接失败"];
        
    } progressBlock:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];
}

- (void)repeat:(NSTimer*)timer
{
    static int i = 1;
    int max = 60;
    if ((i%max)<max&&(i%max)!=0) {
        
        [self.codeBtn setTitle:[NSString stringWithFormat:@"（%.2ds）重新获取",(max-i%max)] forState:UIControlStateNormal];
        i++;
        self.codeBtn.userInteractionEnabled = NO;
    }else{
        
        [timer invalidate];
        i++;
        [self.codeBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
        self.codeBtn.userInteractionEnabled = YES;
    }
}



@end
