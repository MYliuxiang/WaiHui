//
//  RegistPhoneVC.m
//  WaiHui
//
//  Created by liuxiang on 2018/12/19.
//  Copyright © 2018年 faxian. All rights reserved.
//

#import "RegistPhoneVC.h"
#import "RegistSuccessVC.h"

@interface RegistPhoneVC ()
@property (weak, nonatomic) IBOutlet UIButton *phoneType;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet TXLimitedTextField *codeTextField;
@property (weak, nonatomic) IBOutlet TXLimitedTextField *pwTextField;
@property (weak, nonatomic) IBOutlet UILabel *phoneLab;
@property (weak, nonatomic) IBOutlet UILabel *codeLab;
@property (weak, nonatomic) IBOutlet UILabel *pwLab;
@property (weak, nonatomic) IBOutlet UIView *agreementView;
@property (weak, nonatomic) IBOutlet UIImageView *agreementImg;
@property (weak, nonatomic) IBOutlet UIButton *doneBtn;
@property (weak, nonatomic) IBOutlet UIButton *codeBtn;
@property (nonatomic,assign) BOOL IsAgree;
@property (weak, nonatomic) IBOutlet TXLimitedTextField *yaoqingField;

@end

@implementation RegistPhoneVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.IsAgree = YES;
    self.fd_prefersNavigationBarHidden = YES;
    self.phoneLab.hidden = YES;
    self.pwLab.hidden = YES;
    self.codeLab.hidden = YES;
//    self.codeTextField.limitedNumber = 5;
    self.pwTextField.limitedNumber = 24;
    self.yaoqingField.limitedNumber = 7;

    [self.doneBtn hyb_addCornerRadius:5 size:CGSizeMake(kScreenWidth - 60, 48)];
    [self.phoneType layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:5];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
    [self.agreementView addGestureRecognizer:tap];
   
    
    if (@available(iOS 12.0, *)) {
        //Xcode 10 适配
        self.codeTextField.textContentType = UITextContentTypeOneTimeCode;
        //非Xcode 10 适配
        self.codeTextField.textContentType = @"one-time-code";
    }


}





- (IBAction)agreeMentAC:(id)sender {
    
    NSLog(@"进入协议");

}

- (void)tap{
    
    self.IsAgree = !self.IsAgree;
    if (self.IsAgree) {
        self.agreementImg.image = [UIImage imageNamed:@"gouxuan-1"];
    }else{
        self.agreementImg.image = [UIImage imageNamed:@"close01"];
    }
        
    
}

- (IBAction)dismissAC:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];

}

- (IBAction)doneAC:(id)sender {
   
  
    
    if (self.phoneTextField.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入手机号码！"];
        return;
    }
    
    if (self.codeTextField.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请填写验证码！"];
        return;
    }
    
    if (self.pwTextField.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入登录密码！"];
        return;
    }
    
    if (self.pwTextField.text.length < 8) {
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
    if ([HandleTool checkIsHaveNumAndLetter:self.pwTextField.text] == 1) {
        [SVProgressHUD showErrorWithStatus:@"请输入含有大小写的英文字母"];
        return;
    }
    if([HandleTool checkIsHaveNumAndLetter:self.pwTextField.text] == 2){
        [SVProgressHUD showErrorWithStatus:@"不能包含特殊字母"];
        return;
    }
    if ([HandleTool checkIsHaveNumAndLetter:self.pwTextField.text] == 3){
        [SVProgressHUD showErrorWithStatus:@"没有包含数字"];
        return;
    }
    
    BADataEntity *entity = [BADataEntity new];
    entity.urlString = [NSString stringWithFormat:@"%@%@",MainUrl,Url_userAction];
    entity.needCache = NO;
    entity.parameters = @{@"types":@"3",@"phone":self.phoneTextField.text,@"password":self.pwTextField.text,@"phone_code":self.codeTextField.text,@"agentnumber":self.yaoqingField.text.length==0?@"":self.yaoqingField.text};
    [SVProgressHUD show];
    [BANetManager ba_request_POSTWithEntity:entity successBlock:^(id response) {
        NSDictionary *result = response;
        if ([result[@"code"] intValue] == 1) {
            //成功
            [SVProgressHUD dismiss];
            [self.view endEditing:YES];
            FillInInfoVC *vc = [FillInInfoVC new];
            vc.reg_token = result[@"data"][@"reg_token"];
            vc.registStr = self.phoneTextField.text;
            vc.agentnumber = self.yaoqingField.text;
            vc.password = self.pwTextField.text;
            vc.type = RegistTypePhone;
            [self.navigationController pushViewController:vc animated:YES];
            
                       
        }else{
            
            [SVProgressHUD showErrorWithStatus:result[@"message"]];
        }
    } failureBlock:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"网络连接失败"];
        
    } progressBlock:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];
    
}

- (IBAction)codeAC:(id)sender {
    
    if (self.phoneTextField.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入手机号码！"];
        return;
    }
    
    BADataEntity *entity = [BADataEntity new];
    entity.urlString = [NSString stringWithFormat:@"%@%@",MainUrl,Url_userAction];
    entity.needCache = NO;
    entity.parameters = @{@"types":@"2",@"phone":self.phoneTextField.text};
    [SVProgressHUD show];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];

    [BANetManager ba_request_POSTWithEntity:entity successBlock:^(id response) {
        NSDictionary *result = response;
        if ([result[@"code"] intValue] == 1) {
            //成功
            [SVProgressHUD dismiss];
            [self.codeTextField resignFirstResponder];
//            [self.view endEditing:YES];
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


- (IBAction)emailRegistAC:(id)sender {
        
    if ([self.navigationController.viewControllers[self.navigationController.viewControllers.count - 2] isKindOfClass:[RegistEmailVC class]]) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        
        [self.navigationController pushViewController:[RegistEmailVC new] animated:YES];
        
    }
        
}


@end
