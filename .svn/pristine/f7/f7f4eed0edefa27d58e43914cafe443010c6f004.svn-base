//
//  Mt4LoginAlert.m
//  WaiHui
//
//  Created by liuxiang on 2019/1/23.
//  Copyright © 2019年 faxian. All rights reserved.
//

#import "Mt4LoginAlert.h"

@implementation Mt4LoginAlert
- (instancetype)initTableViewAlertWithTitle:(NSString *)title
{
    self = [super init];
    if (self) {
        
        self.type = LxCustomAlertTypeSheet;
        self.maskView.alpha = 1;
        self.offsetBotom = 20;
        self.width = kScreenWidth - 30;
        self.titleLab.text = title;
        NSRange range = [title rangeOfString:@"："];
        self.mt4Str = [title substringFromIndex:range.location + 1];
        self.tipLab.hidden = YES;
        [IQKeyboardManager sharedManager].keyboardDistanceFromTextField = 80;
        [self setupAutoHeightWithBottomView:self.resetBtn bottomMargin:10];
        
    }
    return self;
    
    
}

- (void)disMiss
{
    [super disMiss];
     [IQKeyboardManager sharedManager].keyboardDistanceFromTextField = 10;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.loginBtn hyb_addCornerRadius:5];
    [self hyb_addCornerRadius:5];

    
}

- (IBAction)loginAC:(id)sender {
    
    
    if (self.pwField.text.length == 0){
        [SVProgressHUD showErrorWithStatus:@"请输入密码！"];
        return;
    }
    
    if (self.pwField.text.length < 6) {
        [SVProgressHUD showErrorWithStatus:@"密码输入错误！"];
        return;
    }
    
//    if ([HandleTool checkIsHaveNumAndLetter:self.pwField.text] == 1) {
//        [SVProgressHUD showErrorWithStatus:@"密码请输入含有大小写的英文字母"];
//        return;
//    }
    if([HandleTool checkIsHaveNumAndLetter:self.pwField.text] == 2){
        [SVProgressHUD showErrorWithStatus:@"密码不能包含特殊字母"];
        return;
    }
    if ([HandleTool checkIsHaveNumAndLetter:self.pwField.text] == 3){
        [SVProgressHUD showErrorWithStatus:@"新密码没有包含数字"];
        return;
    }
    
    
    
    BADataEntity *entity = [BADataEntity new];
    entity.urlString = [NSString stringWithFormat:@"%@%@",MainUrl,Url_Mt4Info];
    entity.needCache = NO;
    entity.parameters = @{@"types":@"3",@"mt4_id":self.mt4Str,@"password":self.pwField.text};
    [SVProgressHUD show];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    
    [BANetManager ba_request_POSTWithEntity:entity successBlock:^(id response) {
        NSDictionary *result = response;
        if ([result[@"code"] intValue] == 1) {
            //成功
            [SVProgressHUD dismiss];
            if (self.loginBlcok) {
                self.loginBlcok(0);
            }
            [self disMiss];
            
        }else{
            [SVProgressHUD showErrorWithStatus:result[@"message"]];
        }
        
        
    } failureBlock:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:error.userInfo[@"NSDebugDescription"]];
        
        
    } progressBlock:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];
    
    
    
}

- (IBAction)resetAC:(id)sender {
    
    [self disMiss];

    if (self.loginBlcok) {
        self.loginBlcok(1);
    }
   
}
@end
