//
//  QuickTransactionAlert.h
//  WaiHui
//
//  Created by liuxiang on 2018/12/7.
//  Copyright © 2018年 faxian. All rights reserved.
//

#import "LxCustomAlert.h"

NS_ASSUME_NONNULL_BEGIN

@interface QuickTransactionAlert : LxCustomAlert
@property (weak, nonatomic) IBOutlet UIButton *tishiBtn;
@property (weak, nonatomic) IBOutlet UIButton *canBtn;
@property (weak, nonatomic) IBOutlet UIButton *doneBtn;
@property (weak, nonatomic) IBOutlet UILabel *opertaionLab;
@property (weak, nonatomic) IBOutlet UILabel *countLab;
@property (weak, nonatomic) IBOutlet UILabel *productLab;
@property (nonatomic,copy) void(^clickBlok)(int index) ;


- (IBAction)doneAC:(id)sender;

- (IBAction)cancleAC:(id)sender;

- (instancetype)initQuickTransactionAlertWith:(NSString *)opertaionstr
                                   productStr:(NSString *)productStr
                                     countStr:(NSString *)countStr;

@end

NS_ASSUME_NONNULL_END
