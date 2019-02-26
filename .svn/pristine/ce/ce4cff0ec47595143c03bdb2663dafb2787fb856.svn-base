//
//  FillInInfoVC.m
//  WaiHui
//
//  Created by liuxiang on 2019/1/10.
//  Copyright © 2019年 faxian. All rights reserved.
//

#import "FillInInfoVC.h"

@interface FillInInfoVC ()
@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIButton *btn2;
@property (weak, nonatomic) IBOutlet TXLimitedTextField *nameField;
@property (weak, nonatomic) IBOutlet TXLimitedTextField *lastNameField;
@property (weak, nonatomic) IBOutlet TXLimitedTextField *allNameField;
@property (weak, nonatomic) IBOutlet UIButton *doneBtn;
@property (assign,nonatomic) int sex;
@property (weak, nonatomic) IBOutlet UIImageView *agreeImg;
@property (assign,nonatomic) BOOL agree;
@property (weak, nonatomic) IBOutlet YYLabel *clickLab;

@end

@implementation FillInInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.btn1 setTitleColor:[MyColor colorWithHexString:@"#435C95"] forState:UIControlStateNormal];
    [self.btn1 setImage:[UIImage imageNamed:@"selected"] forState:UIControlStateNormal];

    [self.btn2 setTitleColor:[MyColor colorWithHexString:@"#DBE0EB"] forState:UIControlStateNormal];
    [self.btn2 setImage:[UIImage imageNamed:@"unselected"] forState:UIControlStateNormal];
    [self.btn1 layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:5];
    [self.btn2 layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:5];


    self.sex = 1;
    [self.doneBtn hyb_addCornerRadius:5 size:CGSizeMake(kScreenWidth - 60, 48)];
    self.agree = YES;
    self.fd_prefersNavigationBarHidden = YES;
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:self.clickLab.text];
    text.yy_color = [MyColor colorWithHexString:@"#ABB3C5"];
    [text yy_setTextHighlightRange:NSMakeRange(25, 6)
                             color:[MyColor colorWithHexString:@"#435C95"]
                   backgroundColor:[MyColor colorWithHexString:@"#ABB3C5"]
                         tapAction:^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect){
             NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@Risk_Disclosure.html",BaseWeb_url]];                             HWBaseWebViewController *vc = [HWBaseWebViewController new];
                             vc.url = url;
                             [self.navigationController pushViewController:vc animated:YES];
                            
                         }];
    [text yy_setTextHighlightRange:NSMakeRange(32, 10)
                             color:[MyColor colorWithHexString:@"#435C95"]
                   backgroundColor:[MyColor colorWithHexString:@"#ABB3C5"]
                         tapAction:^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect){
                             
                             NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@Cookie_Policy.html",BaseWeb_url]];
                             
                             HWBaseWebViewController *vc = [HWBaseWebViewController new];
                             vc.url = url;
                             [self.navigationController pushViewController:vc animated:YES];
                         }];
    [text yy_setTextHighlightRange:NSMakeRange(43, 8)
                             color:[MyColor colorWithHexString:@"#435C95"]
                    backgroundColor:[MyColor colorWithHexString:@"#ABB3C5"]
                          tapAction:^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect){
                                                      
                                                        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@Order_Execution_Policy.html",BaseWeb_url]];
                                                      HWBaseWebViewController *vc = [HWBaseWebViewController new];
                                                      vc.url = url;
                                                      [self.navigationController pushViewController:vc animated:YES];
                                                  }];
    
    [text yy_setTextHighlightRange:NSMakeRange(52, 6)
                             color:[MyColor colorWithHexString:@"#435C95"]
                   backgroundColor:[MyColor colorWithHexString:@"#ABB3C5"]
                         tapAction:^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect){
                             NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@Privacy_Policy.html",BaseWeb_url]];
                             HWBaseWebViewController *vc = [HWBaseWebViewController new];
                             vc.url = url;
                             [self.navigationController pushViewController:vc animated:YES];
                         }];
    [text yy_setTextHighlightRange:NSMakeRange(59, 8)
                             color:[MyColor colorWithHexString:@"#435C95"]
                   backgroundColor:[MyColor colorWithHexString:@"#ABB3C5"]
                         tapAction:^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect){
                               NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@Website_Terms_and_Conditions.html",BaseWeb_url]];
                             HWBaseWebViewController *vc = [HWBaseWebViewController new];
                             vc.url = url;
                             [self.navigationController pushViewController:vc animated:YES];
                         }];
    self.clickLab.attributedText = text;
    self.clickLab.preferredMaxLayoutWidth = kScreenWidth - 100;//设置最大宽度

   

}
- (IBAction)btn1AC:(id)sender {
    
    [self.btn1 setTitleColor:[MyColor colorWithHexString:@"#435C95"] forState:UIControlStateNormal];
    [self.btn1 setImage:[UIImage imageNamed:@"selected"] forState:UIControlStateNormal];
    
    [self.btn2 setTitleColor:[MyColor colorWithHexString:@"#DBE0EB"] forState:UIControlStateNormal];
    [self.btn2 setImage:[UIImage imageNamed:@"unselected"] forState:UIControlStateNormal];

    self.sex = 1;
    
}
- (IBAction)btn2AC:(id)sender {
    
    [self.btn1 setTitleColor:[MyColor colorWithHexString:@"#DBE0EB"] forState:UIControlStateNormal];
    [self.btn1 setImage:[UIImage imageNamed:@"unselected"] forState:UIControlStateNormal];

    [self.btn2 setTitleColor:[MyColor colorWithHexString:@"#435C95"] forState:UIControlStateNormal];
    [self.btn2 setImage:[UIImage imageNamed:@"selected"] forState:UIControlStateNormal];

    self.sex = 2;

    
}
- (IBAction)doneAC:(id)sender {
    
    if (self.nameField.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入您的名字！"];
        return;
    }
    
    if (self.lastNameField.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入您的姓氏！"];
        return;
    }
    
    if (self.allNameField.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入您的全名！"];
        return;
    }
    
    BADataEntity *entity = [BADataEntity new];
    entity.urlString = [NSString stringWithFormat:@"%@%@",MainUrl,Url_userAction];
    entity.needCache = NO;
    if (self.type == RegistTypePhone) {
         entity.parameters = @{@"types":@"22",@"phone":self.registStr,@"password":self.password,@"sex":[NSString stringWithFormat:@"%d",_sex],@"username":self.allNameField.text,@"surnames":self.lastNameField.text,@"name":self.nameField.text,@"reg_token":self.reg_token,@"agree":[NSString stringWithFormat:@"%d",_agree],@"agentnumber":self.agentnumber};
    }else{
        
         entity.parameters = @{@"types":@"22",@"email":self.registStr,@"password":self.password,@"sex":[NSString stringWithFormat:@"%d",_sex],@"username":self.allNameField.text,@"surnames":self.lastNameField.text,@"name":self.nameField.text,@"reg_token":self.reg_token,@"agree":[NSString stringWithFormat:@"%d",_agree],@"agentnumber":self.agentnumber};
    }
   
    [SVProgressHUD show];
    [BANetManager ba_request_POSTWithEntity:entity successBlock:^(id response) {
        NSDictionary *result = response;
        if ([result[@"code"] intValue] == 1) {
            //成功
            [SVProgressHUD dismiss];
            [self.view endEditing:YES];
            RegistSuccessVC *vc = [RegistSuccessVC new];
            if (self.type == RegistTypePhone) {
                vc.type = 0;
                
                [LxUserDefaults setObject:self.registStr forKey:Phone];
            }else{
                vc.type = 1;
                [LxUserDefaults setObject:self.registStr forKey:Email];
            }
            
            [LxUserDefaults synchronize];
            [self.navigationController pushViewController:vc animated:YES];
            
        }else{
            
            [SVProgressHUD showErrorWithStatus:result[@"message"]];
        }
    } failureBlock:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"网络连接失败"];
        
    } progressBlock:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];
    
    
    
    
    
    
    
}

- (IBAction)tiaozhuanAC:(id)sender {
    
    
}

- (IBAction)tapAC:(id)sender {
    
    self.agree =!self.agree;
    if (self.agree) {
        self.agreeImg.image = [UIImage imageNamed:@"gouxuan-1"];
    }else{
        self.agreeImg.image = [UIImage imageNamed:@"close01"];
        
    }
}

- (IBAction)agreeAC:(id)sender {
    
    self.agree =!self.agree;
    if (self.agree) {
        self.agreeImg.image = [UIImage imageNamed:@"gouxuan-1"];
    }else{
        self.agreeImg.image = [UIImage imageNamed:@"close01"];
        
    }
}
- (IBAction)disMissAC:(id)sender {
    
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

@end
