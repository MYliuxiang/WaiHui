//
//  QSearchTCell.m
//  WaiHui
//
//  Created by liuxiang on 2018/12/10.
//  Copyright © 2018年 faxian. All rights reserved.
//

#import "QSearchTCell.h"

@implementation QSearchTCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(ResultModel *)model
{
    _model = model;
    self.nameLab.text = model.symbolName;
    self.subNameLab.text = model.symbol;
    if (_model.add_state == 1) {
        
//        self.imgStatus.image = [UIImage imageNamed:];

        self.imgBtn.selected = YES;
    }else{
        
        self.imgBtn.selected = NO;

    }
   
    
}
- (IBAction)imageAC:(id)sender {
    
    UIButton *btn = (UIButton *)sender;
    if (![LxUserDefaults boolForKey:IsLogin]) {
        
        LoginphoneVC *vc = [LoginphoneVC new];
        vc.backIndex = YES;
        BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:vc];
        [self.ViewController presentViewController:nav animated:YES completion:nil];
        return;
    }else{
        
        NSString *seletedMt4_id = [NSString stringWithFormat:@"%@",[LxUserDefaults objectForKey:Mt4_id]];
        if (seletedMt4_id.length > 2) {
            //有mt4账户
            BADataEntity *entity = [BADataEntity new];
            entity.urlString = [NSString stringWithFormat:@"%@%@",MainUrl,Url_userAction];
            entity.needCache = NO;
            if (self.model.add_state == 1) {
                //已经添加
                entity.parameters = @{@"types":@"7",@"mt4_id":seletedMt4_id,@"symbol":self.model.symbol,@"symbolName":self.model.symbolName,@"operate":@"Delete",@"operateForm":@"Ios"};
            }else{
                //-1未添加
                entity.parameters = @{@"types":@"7",@"mt4_id":seletedMt4_id,@"symbol":self.model.symbol,@"symbolName":self.model.symbolName,@"operate":@"add"};
            }
            
            [SVProgressHUD show];
            [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
            
            [BANetManager ba_request_POSTWithEntity:entity successBlock:^(id response) {
                NSDictionary *result = response;
                if ([result[@"code"] intValue] == 1) {
                    //成功
                    [SVProgressHUD dismiss];
                    if (self.model.add_state == 1) {
                        self.model.add_state = -1;
                        [self xw_postNotificationWithName:OptionalNotice userInfo:@{@"add":@(NO)}];
                    }else{
                        self.model.add_state = 1;
                        [self xw_postNotificationWithName:OptionalNotice userInfo:@{@"add":@(YES)}];
                        
                    }
                    
                    btn.selected = !btn.selected;
                    
                    
                    
                    
                }else{
                    
                    [SVProgressHUD showErrorWithStatus:result[@"message"]];
                    
                }
                
                
            } failureBlock:^(NSError *error) {
                [SVProgressHUD showErrorWithStatus:error.userInfo[@"NSDebugDescription"]];
                
                
            } progressBlock:^(int64_t bytesProgress, int64_t totalBytesProgress) {
                
            }];
            
            
            
            
            
        }else{
            
            MyTipAlert *alert = [[MyTipAlert alloc] initWithTipAlertWithTitle:@"您当前没有选中mt4账户" contentStr:@"是否跳转添加" btnStr:@"确定"];
            alert.clickBlock = ^(int index) {
                if (index == 0) {
                    [self gotoVC];
                    
                }else{
                    [MainTabBarController shareMainTabBarController].selectedIndex = 0;
                }
            };
            [alert show];
            return;
        }
    }
}

- (void)gotoVC
{
    //账户管理
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
            NSArray *array = [Mt4Model mj_objectArrayWithKeyValuesArray:result[@"data"]];
            AccountManagerVC *vc = [[AccountManagerVC alloc] init];
            vc.dataList = array;
            [self.ViewController.navigationController pushViewController:vc animated:YES];
        }else{
            
            [SVProgressHUD showErrorWithStatus:result[@"message"]];
            
        }
        
        
    } failureBlock:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:error.userInfo[@"NSDebugDescription"]];
        
        
    } progressBlock:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];
    
}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
