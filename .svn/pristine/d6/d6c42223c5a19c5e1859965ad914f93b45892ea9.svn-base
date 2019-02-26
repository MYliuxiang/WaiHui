//
//  Mt4LoginAlert.h
//  WaiHui
//
//  Created by liuxiang on 2019/1/23.
//  Copyright © 2019年 faxian. All rights reserved.
//

#import "LxCustomAlert.h"

NS_ASSUME_NONNULL_BEGIN

@interface Mt4LoginAlert : LxCustomAlert
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet TXLimitedTextField *pwField;
@property (weak, nonatomic) IBOutlet UILabel *tipLab;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UIButton *resetBtn;

@property (nonatomic,copy) NSString *mt4Str;
@property (nonatomic,copy) void(^loginBlcok)(int type) ;
@property (nonatomic,retain) UIViewController *vc;


- (IBAction)loginAC:(id)sender;
- (IBAction)resetAC:(id)sender;

- (instancetype)initTableViewAlertWithTitle:(NSString *)title;

@end

NS_ASSUME_NONNULL_END
